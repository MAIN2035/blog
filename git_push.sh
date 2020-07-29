#!/bin/bash

GITPATH=/home/garfield/文档
ADD=$(git add .)
DATE=$(date)
COMMIT=$(git commit -m "$DATE")
GITPUSH=$(git push blog master)
cd $GITPATH
$ADD
$COMMIT
$GITPUSH
