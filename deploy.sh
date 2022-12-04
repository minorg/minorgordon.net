#!/bin/sh

set -e

bundle exec jekyll build
aws s3 sync _site/ s3://minorgordon.net --delete
aws cloudfront create-invalidation --distribution-id E3M6EY653OTS82 --paths "/*"
