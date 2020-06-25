#!/bin/bash

BASE_DIR="$(cd "$(dirname "$0" )" && pwd )"
EC2_KEY_DIR=$BASE_DIR"/gradplanner-ec2-rsa.pem"
EC2_ENDPOINT="ubuntu@ec2-3-21-33-152.us-east-2.compute.amazonaws.com"

ssh -i $EC2_KEY_DIR $EC2_ENDPOINT
