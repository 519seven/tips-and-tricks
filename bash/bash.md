# Bash Cheat Sheet #

# Programs & Utilities #
## Filename/Basename ##
### Get Filename and Extension ###

To just get filename from a given path:

```bash
FILE="/home/vivek/lighttpd.tar.gz"
basename "$FILE"
f="$(basename -- $FILE)"
echo "$f"
```

### Get filename without using basename command ###

The syntax is:

```bash
FILE="/home/vivek/lighttpd.tar.gz"
echo ${FILE##*/}
## another example ##
url="https://www.cyberciti.biz/files/mastering-vi-vim.pdf"
echo "${url##*/}"
```

## Arrays ##

### Declare an array and add elements to it ###

```bash
my_array=()
my_array+=("${element_val_1}")
```

### Write all elements of array to stdout ###

```bash
echo "${my_array[@]}"
```
# Conditionals #
## `if..else` ##
### Return Exit Code From Command ###
```bash
if ! grep jenkins /etc/passwd | wc -l; then
        if [ "$VERBOSE" -eq "1" ]; then echo "jenkins user not found, adding jenkins user"
        sudo useradd -d /home/jenkins -G sudo -m -s /bin/bash jenkins
        echo -e "${PWD}\n${PWD}" | sudo -S passwd jenkins
else
        if [ "$VERBOSE" -eq "1" ]; then echo "User found, checking sudo membership"
fi
```

# Environment #
## Redirection ##
### Send Output From Multiple Files ###
```bash
{ sha1sum foo.txt ;sha512sum foo.txt ;md5sum foo.txt ;} >checksum.txt
```

## Declarations ##

### View ###
See which functions and definitions are available in your current shell

[`man declare`](https://linuxcommand.org/lc3_man_pages/declareh.html) (manpage link)

```bash
    declare -f 
```

### Unset ###
Unset anything you see there that you want to get rid of

```bash
    unset -f my_func
```

### Export `Key=Value` Pairs From File ###
[StackOverflow](https://stackoverflow.com/questions/19331497/set-environment-variables-from-file-of-key-value-pairs)

### Default Assignment ###
[Stackoverflow](https://stackoverflow.com/questions/2013547/assigning-default-values-to-shell-variables-with-a-single-command-in-bash)

```bash
    : "${VARIABLE:=DEFAULT_VALUE}"  # Variable names are the same
```

## Asking For User Input ##

```bash
    cat << EOS | tr '\n' ' '
    Would you like to kick off the Jenkins job to pull the image into OCP? [y/n]:
    EOS
    while true
    do
          read
          case ${REPLY:0:1} in
              [Yy] ) Do_Jenkins
                     exit 2;;
              [Nn] ) echo "Skipping kicking off Jenkins job to copy image"
                     break;;
                 * ) echo -n "Please enter [y]es or [n]o: ";;
          esac
    done
```

# Strings #

## Uppercase/Lowercase ##

```bash
x="HELLO"
echo $x
HELLO

y=${x,,}
echo $y
hello

z=${y^^}
echo $z
HELLO

# POSIX standard
# tr

$ echo "$a" | tr '[:upper:]' '[:lower:]'
hi all

# AWK

echo "$a" | awk '{print tolower($0)}'
hi all

# Non-POSIX
# You may run into portability issues with the following examples:
# Bash 4.0

echo "${a,,}"
hi all

# sed

echo "$a" | sed -e 's/\(.*\)/\L\1/'
hi all

# This also works:
sed -e 's/\(.*\)/\L\1/' <<< "$a"
hi all

# Perl

echo "$a" | perl -ne 'print lc'
hi all

# Bash

lc(){
    case "$1" in
        [A-Z])
        n=$(printf "%d" "'$1")
        n=$((n+32))
        printf \\$(printf "%o" "$n")
        ;;
        *)
        printf "%s" "$1"
        ;;
    esac
}
word="I Love Bash"
for((i=0;i<${#word};i++))
do
    ch="${word:$i:1}"
    lc "$ch"
done

# [Source](https://stackoverflow.com/questions/2264428/how-to-convert-a-string-to-lower-case-in-bash)
# Note: YMMV on this one. Doesn't work for me (GNU bash version 4.2.46 and 4.0.33)
# (and same behaviour 2.05b.0 but nocasematch is not implemented)) even with using
# shopt -u nocasematch;. Unsetting that nocasematch causes [[ "fooBaR" == "FOObar" ]]
# to match OK BUT inside case weirdly [b-z] are incorrectly matched by [A-Z]. 
# Bash is confused by the double-negative ("unsetting nocasematch")! :-)

```

## Newlines ##

### References ###
[StackOverflow - ASCII/Hex Conversion in Bash](https://stackoverflow.com/questions/5724761/ascii-hex-convert-in-bash)

### Specific Tasks ###

#### base64 ####
[Newlines In base64 Strings](https://superuser.com/questions/1225134/why-does-the-base64-of-a-string-contain-n)

#### Printing ####
```bash
# print without a new line
echo -n "print this and there will be no newline"
echo "print this and there will be a newline"
printf "print this and there will be no newline"
printf "print this and there will be a newline\n"
```

#### Inspect Characters ####
```bash
# print byte-by-byte
$ echo Aa | od -t x1
0000000 41 61 0a
0000003
```
The `0a` is the implicit newline that `echo` produces.  Use `echo -n` or `printf` instead.
```bash
$ printf Aa | od -t x1
0000000 41 61
0000002
```

## Find substring in string ##
[Linuxize](https://linuxize.com/post/how-to-check-if-string-contains-substring-in-bash/)

```bash
    if [[ "$STR" =~ .*"$SUB".* ]]; then
	  echo "It's there."
	fi
```

# Prompt #

## Powerline

### Step 1: Installation

Install Python3 via homebrew (Optional: in case you do not have pyhton installed. run python3 --version to see if it's installed)

`$ brew install python3`

Install powerline via pip (python package manager)

`$ pip3 install powerline-status`

__Find the location__

`$ pip3 show powerline-status`

*It shows that the powerline-status is installed at `/usr/local/lib/python3.6/site-packages`*

### Step 2: Configuration

To activate powerline, you need to source powerline.sh in your .bash_profile

Open up your .bash_profile in Vim or any editor

`$ vim ~/.bash_profile`

Paste this code into your .bash_profile
```bash
# Powerline
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
source /usr/local/lib/python3.6/site-packages/powerline/bindings/bash/powerline.sh
```

Now, create a configuration directory for powerline in your home directory and copy the config_files/ directory from the powerline direcory.

    $ mkdir ~/.config/powerline
    $ cp -r /usr/local/lib/python3.6/site-packages/powerline/config_files/ ~/.config/powerline/

### Git Status ###

#### Install Powerline Segment for Showing the Status of a Git Repository ####
https://pypi.org/project/powerline-gitstatus/

#### Show Branch In Prompt ####

Either modify `~/.config/powerline/config.json` or make a local copy (`~/.config/powerline`) and change `shell` -> `theme` from `default` to `default_leftonly`.

[Powerline Docs](https://powerline.readthedocs.io/en/latest/configuration.html)

### Install Fonts ###

You can try any ol' font you wish (like [these](https://github.com/powerline/fonts) but they didn't work for me).  


#### Are you seeing ⍰ question mark icons?

During this most recent exercise, I had to install the Hack font from [here](https://github.com/ryanoasis/nerd-fonts#option-4-homebrew-fonts) and set my profile's text preferences in iTerm2.


### Powerline for vim ###

If you want the status bar for your vim, simply add the following code to your `~/.vimrc` file.

Open `.vimrc` in your editor and paste this code.
```bash
" powerline
set rtp+=/usr/local/lib/python3.6/site-packages/powerline/bindings/vim
set laststatus=2
set t_Co=256
```
