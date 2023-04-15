#!/bin/bash
# Description: Start a remote Jupyter kernel and tunnel the ports to localhost

set -o errexit
set -o nounset
set -o pipefail

# Set variables
USER="krider"
HOST="honeydew"
ENV="182"
LOCAL_RUNTIME_DIR=$(jupyter --runtime-dir)

_start () {
    ssh $USER@$HOST "source /home/krider/mambaforge/bin/activate"\
        "&& conda activate $ENV"\
        "&& jupyter kernel --kernel python3"
}

_tunnel () {
    KERNEL_PATH="$1"
    if [ -z "$KERNEL_PATH" ]; then
        echo "No kernel ID provided"
        exit 1
    fi
    KERNEL_FILE=$(basename $KERNEL_PATH)

    scp $USER@$HOST:$KERNEL_PATH $LOCAL_RUNTIME_DIR
    echo "Kernel JSON file:"
    echo $KERNEL_FILE

    KERNEL_PORT=$(jq '.shell_port' $LOCAL_RUNTIME_DIR/$KERNEL_FILE)
    echo "Kernel port: $KERNEL_PORT"

    CONTROL_PORT=$(jq '.control_port' $LOCAL_RUNTIME_DIR/$KERNEL_FILE)
    echo "Control port: $CONTROL_PORT"

    IOPUB_PORT=$(jq '.iopub_port' $LOCAL_RUNTIME_DIR/$KERNEL_FILE)
    echo "IOPub port: $IOPUB_PORT"

    HB_PORT=$(jq '.hb_port' $LOCAL_RUNTIME_DIR/$KERNEL_FILE)
    echo "Heartbeat port: $HB_PORT"

    # keep tunnel open until user kills it
    ssh -L $KERNEL_PORT:localhost:$KERNEL_PORT \
        -L $CONTROL_PORT:localhost:$CONTROL_PORT \
        -L $IOPUB_PORT:localhost:$IOPUB_PORT \
        -L $HB_PORT:localhost:$HB_PORT \
        $USER@$HOST "tail -f /dev/null"
}

if [ "$1" = "start" ]; then
    _start
elif [ "$1" = "tunnel" ]; then
    _tunnel "$2"
else
    echo "Usage: remote_jupyter_kernel.sh [start|tunnel]"
fi

