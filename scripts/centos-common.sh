#!/bin/bash

# Update centOS with any patches
yum update -y --exclude=kernel
# Tools
yum install -y nano unzip screen nc telnet