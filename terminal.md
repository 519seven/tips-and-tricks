# Terminal Tips & Tricks #

## Clearing history ##

```bash
clear

# alias cls='printf "\033c"'
# \033 == \x1B == 27 == ESC
# this become <ESC>c which is the 
# VT100 escape code for resetting the terminal
printf "\033c"

# reset - slow
reset
# reset - fast
tput reset

```
