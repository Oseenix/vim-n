#!/bin/sh
# 去掉前5个参数
shift 5
# 使用vimdiff比较
vimdiff "$@"

