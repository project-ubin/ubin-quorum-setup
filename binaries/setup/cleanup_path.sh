#!/bin/bash

TPATH=${PATH//\//\\/}
TPATH=${TPATH//\:/|}
TPATH="export PATH=\$PATH;\|export PATH=\$PATH:\|"$TPATH
sed -i "/$TPATH/d" ~/.bashrc
