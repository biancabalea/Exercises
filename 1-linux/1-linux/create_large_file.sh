#!/bin/bash

dd if=/dev/zero of=large_file bs=1M count=50

mv large_file /home/john