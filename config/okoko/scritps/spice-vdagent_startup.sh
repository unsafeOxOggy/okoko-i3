#!/bin/bash

pkill -x spice-vdagent 2> /dev/null

while pgrep -x spice-vdagent > /dev/null; do sleep 0.1; done

spice-vdagent
