#!/bin/bash

DEVELOPER_DIR=/Applications/Xcode_$(cat .xcode-version).app/Contents/Developer

if [ -z "$GITHUB_ENV" ]; then
	echo "No GITHUB_ENV path set. Setting local environment variables."
	export DEVELOPER_DIR="$DEVELOPER_DIR"
else
	echo "GITHUB_ENV path set. Exporting build settings for downstream job steps."
	echo "DEVELOPER_DIR=$DEVELOPER_DIR" >> $GITHUB_ENV
fi

echo "DEVELOPER_DIR=$DEVELOPER_DIR"