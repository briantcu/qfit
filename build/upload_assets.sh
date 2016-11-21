#! /bin/bash

BUILD_NUM=$1
aws s3 cp "public/js/" s3://quadfit/assets/js/${BUILD_NUM}/ --recursive --acl public-read
aws s3 cp "public/css/" s3://quadfit/assets/css/${BUILD_NUM}/ --recursive --acl public-read