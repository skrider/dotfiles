# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "/usr/local/texlive/2021/bin/x86_64-linux" ] ; then
    PATH="/usr/local/texlive/2021/bin/x86_64-linux:$PATH"
fi

# node-v16.14.0-linux-x64
if [ -d "/usr/local/lib/nodejs/node-v16.14.0-linux-x64/bin" ] ; then
	PATH="/usr/local/lib/nodejs/node-v16.14.0-linux-x64/bin:$PATH"
fi

export GOPATH=$HOME/go
export PATH="$PATH:$GOPATH/bin:$HOME/.cargo/bin:/usr/local/go/bin"

. "$HOME/.cargo/env"