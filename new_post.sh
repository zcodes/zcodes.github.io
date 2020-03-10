#!/usr/bin/env sh
#
# 创建新的博客文章
# Usage: ./new_post.sh file-name-without-datetime "文章标题"
#

if [ "$#" -ne 2 ]; then
    echo "Usage: ./new_post.sh file-name-without-datetime "文章标题""
    exit 0
fi

DATE=`date +%Y-%m-%d`
DATETIME=`date "+%Y-%m-%d %H:%M:%S %z"`
FILE=_posts/$DATE-$1.md
TITLE=$2

shift 2

cat > $FILE <<EOF
---
layout: post
title: "$TITLE"
date: $DATETIME
categories:
published: false
---
EOF

vim $FILE
