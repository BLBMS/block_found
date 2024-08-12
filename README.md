# block_found
## counts mined blocks in verus chain
I've always wondered how many blocks I find in (say) a month. As long as the hash is small this is not a problem. Some pools do not record this or only the last few.

That's why I created a program that works in the screen and checks the found blocks for the specified wallet at a set interval.

Simply enter your wallet in .json and mark with 1 which pool to monitor and 0 to skip.

I recommend a capture interval of 24 hours. Except for a really really big hash, it should be shorter so that the found blocks are not deleted from the database earlier.

Too short a capture interval and marked pools that you don't actually mine on needlessly load the servers. Please also consider the economic aspect of pools and the environmental footprint.

The program starts in a separate screen named 'block_found'. Newly found blocks are displayed on this screen on the fly, and are also recorded in a `block_COIN.list` file for each type of coin separately.

In the file, the blocks are sorted according to the block number - the most recent ones are the highest, and not according to the pool.

To the far right is added a counter of blocks in the same month (this data was my primary purpose for programming). The first block of the month starts with counter 1.

Blocks are also recorded for merged mining for pools that allow this. The coins are written in .json and in the case of new PBaaS coins just add them.

Currently supported pools:
-  community pool
-  verus farm
-  luckpool
-  vipor
-  cloudiko

customization requires some prior programming knowledge

you definitely need this:

`sudo apt-get update ; sudo apt-get upgrade -y ; sudo apt install python3 -y ; sudo apt install python3-pip -y ; sudo pip3 install requests ; sudo apt install nano screen bc jq -y`

**no help, use at your own risk**

in case of a bug, write a message

**if you don't know what to do, don't do anything**

___________
## instructions

download `block_start.sh`, this is start program

download `block_data.json`, modify and enter your data

Other programs are downloaded automatically and are later updated to new versions. In case of a fork, please update the github path (no update).

___________
## example
˘˘˘
3162617   luckpool-eu   2024-08-05 05:13:44   4
3160410   luckpool-eu   2024-08-03 15:18:09   3
3157809   luckpool-eu   2024-08-01 18:28:15   2
3157077   luckpool-eu   2024-08-01 05:58:09   1
3152285   luckpool-eu   2024-07-28 19:32:30   17
3152020   luckpool-eu   2024-07-28 15:06:06   16
3151615   luckpool-eu   2024-07-28 08:14:51   15
3145701   luckpool-eu   2024-07-24 02:26:02   14
3143680   luckpool-eu   2024-07-22 15:33:54   13
3142398   luckpool-eu   2024-07-21 17:37:59   12
3139735   luckpool-eu   2024-07-19 19:45:43   11
3138170   luckpool-eu   2024-07-18 16:51:50   10
3135861   luckpool-eu   2024-07-17 01:03:31   9
3133260   luckpool-eu   2024-07-15 04:28:38   8
3128709   luckpool-eu   2024-07-11 22:04:17   7
3126669   luckpool-eu   2024-07-10 11:20:24   6
```
