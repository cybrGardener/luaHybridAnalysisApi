## Plan of what I am doing

# everything part
* clean up file names to stop being a mess

# lua part
1. threatTest1.lua gets info on submitted malware from falcon sandbox
    1. it gets this from separate config file
2. threatTest1filterHash.lua filters the info to have:
    * name of file
    * hash
    * threat score
3. another (not named yet) script separates just the script for chosen submission
4. threatHash1.lua gets more info on that specific submission
5. further steps to come - generate a html report or something to display on my web page

# tcl/tk part
1. tcl program allows you to input specifications to search on, then outputs them into file
2. the output config file can be read by threatTest1.lua
3. tcl program has a button that runs the query

## tbc
