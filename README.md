# block-found
verus 

I've always wondered how many blocks I find in (say) a month. As long as the hash is small this is not a problem. Some pools do not record this or only the last few.

That's why I created a program that works in the screen and checks the found blocks for the specified wallet at a set interval.

Simply enter your wallet in .json and mark with 1 which pool to monitor and 0 to skip.

I recommend a capture interval of 24 hours. Except for a really really big hash, it should be shorter so that the found blocks are not deleted from the database earlier.

Too short a capture interval and marked pools that you don't actually mine on needlessly load the servers. Please also consider the economic aspect of pools and the environmental footprint.
