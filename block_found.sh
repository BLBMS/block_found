#!/bin/bash
# v.2024-08-06
# by blbMS
wallet=$(jq -r '.wallet' block_data.json)
coin_list=$(jq -r '.coin_list[]' block_data.json)

get_block() {
    coinl=$(echo "$coin" | tr '[:upper:]' '[:lower:]')
    if [[ "$coinl" == "vrsc" ]]; then
        coinf="verus"
    else
        coinf="$coinl"
    fi
    url="https://luckpool.net/$coinf/blocks/$wallet"
    output_file="block_${coin}.list"
    temp_file="block_temp.list"
    temp_file_sorted="block_temp.sorted"
    data=$(curl -s "$url")
    if [[ "$data" == "[]" ]]; then
        return
    elif echo "$data" | head -n 1 | grep -q "<html>"; then
        return
    fi
    > "$temp_file"
    > "$temp_file_sorted"
    declare -A timestamp_map
    declare -A month_block_count
    while read -r line; do
        block_num=$(echo "$line" | awk '{print $1}')
        timestamp=$(echo "$line" | awk '{print $2" "$3}')
        timestamp_map[$block_num]="$timestamp"
        block_month=$(echo "$timestamp" | cut -d'-' -f1,2)
        month_block_count[$block_month]=$((month_block_count[$block_month]+1))
    done < "$output_file"
    echo "$data" | tr -d '[]' | tr ',' '\n' | tac | while IFS=':' read -r hash sub_hash block_num worker timestamp_millis pool data1 data2 data3; do
        worker_name=$(echo "$worker" | awk -F'.' '{print $NF}')
        timestamp_seconds=$((timestamp_millis / 1000))
        block_time=$(date -d @"$timestamp_seconds" +"%Y-%m-%d %H:%M:%S")
        block_month=$(date -d @"$timestamp_seconds" +"%Y-%m")
        if [[ -z "${timestamp_map[$block_num]}" || "$block_time" > "${timestamp_map[$block_num]}" ]]; then
            if [[ -z "${month_block_count[$block_month]}" ]]; then
                month_block_count[$block_month]=1
            else
                month_block_count[$block_month]=$((month_block_count[$block_month]+1))
            fi
            new_block_num=${month_block_count[$block_month]}
            echo "$block_num   $block_time   $new_block_num   $worker_name" >> "$temp_file"
            echo -e "New \e[0;91m$coin\e[0m block: \e[0;92m$block_num   $block_time   $new_block_num   $worker_name\e[0m"
            echo "yes" > is_found.txt
        fi
    done
    cat "$temp_file" "$output_file" | sort -r -k2,2 -k3,3 | awk '!seen[$0]++' > "$output_file.new"
    mv "$output_file.new" "$output_file"
    rm "$temp_file" "$temp_file_sorted"
}
rm -f is_found.txt
echo "$coin_list" | while read -r coin; do
    get_block
done
if [[ -f is_found.txt ]]; then
    is_found=$(cat is_found.txt)
    if [[ "$is_found" == "yes" ]]; then
        echo -e "\n"
    fi
fi
