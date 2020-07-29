#!/bin/bash

GITPATH=/home/garfield/文档
ADD=$(git add .)
DATE=$(date)
GITPUSH=$(git push blog master)
GITPULL=$(git pull blog master)
cd $GITPATH
$ADD 
git add img/
git commit -m "$DATE"
$GITPULL
$GITPUSH
