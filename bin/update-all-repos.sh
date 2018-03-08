#!/bin/bash
# Pull latest versions of all git projects in a directory
find . -maxdepth 1 -type d -exec git --git-dir={}/.git --work-tree=$PWD/{} pull origin master \;
