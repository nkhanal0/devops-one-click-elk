#!/usr/bin/env bash

#Set Keypair Name
KEYPAIR=AWS-Demo-Keypair-Niraj

set -e

#Define Functions

gen_keypair () {
  #Generate a new keypair
  set -x
  aws ec2 create-key-pair --key-name $KEYPAIR --query 'KeyMaterial' --output text > $KEYPAIR.pem
  chmod 400 $KEYPAIR.pem
  set +x
}

display_keypair () {
  #Display generated keypair
  set -x
  aws ec2 describe-key-pairs --key-name $KEYPAIR
  set +x
}

#Run Functions
gen_keypair
display_keypair
