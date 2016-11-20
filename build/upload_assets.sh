#! /bin/bash
aws s3 cp "public/js/" s3://quadfit/assets/ --recursive --acl public-read
aws s3 cp "public/css/" s3://quadfit/assets/ --recursive --acl public-read