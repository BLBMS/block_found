#!/bin/bash
# v.2024-08-06
# by blbMS
my_github=$(jq -r '.my_github' block_data.json)
coin_list=$(jq -r '.coin_list[]' block_data.json)
freq=$(jq -r '.freq' block_data.json)
echo "$coin_list" | while read -r coin; do
    echo -e "\e[4m\e[1;93mLast 5 blocks: \e[1;91m$coin\e[0m:\e[24m"
    block_file="block_${coin}.list"
    if [[ -f "$block_file" && -s "$block_file" && $(head -n 1 "$block_file" | awk '{print $1}') -ne 0 ]]; then
        head -n 5 "$block_file"
    else
        echo -e "\e[90mNo valid block data available.\e[0m"
    fi
done
freq_seconds=$(awk "BEGIN {print int($freq * 3600)}")
if [[ $freq_seconds -lt 3600 ]]; then
    echo -e "\n\e[1;93mCapture frequency: \e[1;91m$freq_seconds\e[0m (sec)\n"
else
    echo -e "\n\e[1;93mCapture frequency: \e[1;91m$freq\e[0m (h)\n"
fi
execute_block_found() {
    echo -e "\e[96m== $(date +%Y-%m-%d\ %H:%M:%S) \e[0m== ($iter)"
    FILE="block_found.sh"
    cd ~/
    rm -f $FILE
    wget -q "$my_github$FILE"
    chmod +x $FILE
    source ./$FILE
    iter=$((iter + 1))
}
iter=1
execute_block_found
current_time=$(date +%s)
last_midnight=$(date -d "today 00:00" +%s)
next_capture_time=$last_midnight
while [[ $next_capture_time -lt $current_time ]]; do
    next_capture_time=$((next_capture_time + freq_seconds))
done
echo -e "Next capture time: \e[93m$(date -d @$next_capture_time +%Y-%m-%d\ %H:%M:%S)\e[0m\033[A\033[K\033[A\033[K"
while true; do
    current_time=$(date +%s)
    jq '.is_found = "no"' block_data.json > tmp.$$.json && mv tmp.$$.json block_data.json
    if [[ "$current_time" -ge "$next_capture_time" ]]; then
        execute_block_found
        next_capture_time=$((next_capture_time + freq_seconds))
        echo -e "Next capture time: \e[93m$(date -d @$next_capture_time +%Y-%m-%d\ %H:%M:%S)\e[0m\033[A\033[K\033[A\033[K"
    fi
done
