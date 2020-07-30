#!/bin/bash
DATE=$(date)
cd /home/garfield/文档/
git add .
git commit -m "$DATE"
git push blog master
