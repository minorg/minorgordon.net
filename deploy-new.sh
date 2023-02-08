#!/bin/sh

set -e

bundle exec jekyll build
aws s3 sync _site/ s3://new.minorgordon.net --delete
