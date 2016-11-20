#! /bin/bash
aws s3 cp "public/js/" s3://quadfit/assets/js/ --recursive --acl public-read
aws s3 cp "public/css/" s3://quadfit/assets/css/ --recursive --acl public-read