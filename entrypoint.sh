#!/bin/sh

# Exit on error
set -e

# Debug output
set -x

echo "Using interfaces: $INTERFACES"

/app/mdns-repeater -f $INTERFACES
