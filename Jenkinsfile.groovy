#!/usr/bin/env groovy

def github_repo = 'https://github.com/nkhanal0/devops-one-click-elk.git'
def main_branch = 'master'


node () {
  stage ('Checkout-SCM') {
    // TBD: checkout
  }

  stage ('Call Ansible Playbook') {
  // TBD: need to connect this with ansible-plugin
  }
 }
