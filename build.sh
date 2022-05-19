#!/bin/bash

usage () {
    echo "Usage: build.sh [OPTIONS]"
    echo "-r     run after building"
    echo "-c     remove build dir"
    echo "-h     print this help"
}

while getopts ":rch" option; do
    case $option in
        h)
            usage
            exit 0
            ;;
        r)
            should_run=yes
            ;;
        c)
            rm -rf bin
            exit 0
            ;;
        *)
            ;;
    esac
done

mkdir -p bin
odin build src -out:bin/nessie

if [[ $? -eq 0 ]] && [[ -n $should_run ]]; then
    bin/nessie
fi

exit $?
