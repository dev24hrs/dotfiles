# last directory
chpwd() {
 # Save the current directory to a file
 echo $PWD > ~/.last_directory
}
[ -f ~/.last_directory ] && cd $(cat ~/.last_directory)

# cheat.sh
ch() {
    curl cheat.sh/$argv[1]
}

proxy() {
    git config --global http.proxy 127.0.0.1:7890 && 
    git config --global https.proxy 127.0.0.1:7890
}

noproxy() {
    git config --global --unset http.proxy &&
    git config --global --unset https.proxy
}

showproxy() {
    git config --global --get http.proxy &&
    git config --global --get https.proxy
}
