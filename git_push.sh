#!/bin/bash

GITPATH=/home/garfield/文档
ADD=$(git add .)
DATE=$(date +%y%m%d)
GITPUSH=$(git push blog master)
GITPULL=$(git pull blog master)
cd $GITPATH
$ADD 
git commit -m "$DATE"
$GITPULL
$GITPUSH
