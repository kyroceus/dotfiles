#!/bin/bash
# Show the 1-minute load average
awk '{print $1}' /proc/loadavg
