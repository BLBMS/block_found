# block-found
## counts mined blocks in verus chain
I've always wondered how many blocks I find in (say) a month. As long as the hash is small this is not a problem. Some pools do not record this or only the last few.

That's why I created a program that works in the screen and checks the found blocks for the specified wallet at a set interval.

Simply enter your wallet in .json and mark with 1 which pool to monitor and 0 to skip.

I recommend a capture interval of 24 hours. Except for a really really big hash, it should be shorter so that the found blocks are not deleted from the database earlier.

Too short a capture interval and marked pools that you don't actually mine on needlessly load the servers. Please also consider the economic aspect of pools and the environmental footprint.

The program starts in a separate screen named 'block_found'. Newly found blocks are displayed on this screen on the fly, and are also recorded in a .list file for each type of coin separately.

In the file, the blocks are sorted according to the block number - the most recent ones are the highest, and not according to the pool.

To the far right is added a counter of blocks in the same month (this data was my primary purpose for programming). The first block of the month starts with counter 1.

Blocks are also recorded for merged mining for pools that allow this. The coins are written in .json and in the case of new PBaaS coins just add them.

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
