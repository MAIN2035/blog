#!/bin/bash

GITPATH=/home/garfield/文档
ADD=$(git add .)
COMMIT=$(git commit -m "$(date) ")
GITPUSH=$(git push blog master)
cd $GITPATH
$ADD
$COMMIT
$GITPUSH
