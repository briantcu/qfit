#! /bin/bash

BUILD_NUM=$1
aws s3 cp "public/js/" s3://quadfit/assets/${BUILD_NUM}/js/ --recursive --acl public-read --cache-control max-age=604800,public
aws s3 cp "public/css/" s3://quadfit/assets/${BUILD_NUM}/css/ --recursive --acl public-read --cache-control max-age=604800,public