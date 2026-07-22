#!/bin/bash

# Kill any existing instance of the SPICE agent
pkill spice-vdagent 2> /dev/null

# Restart the user-space SPICE daemon for clipboard and resolution sync
spice-vdagent
