#!/bin/bash -e

# Adding the steps to install dependencies for Jenkins.
main() {
  sudo apt-get update -y
  sudo apt install openjdk-8-jdk -y
  wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
  sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
  sudo apt update
  sudo apt install jenkins -y
  systemctl status jenkins
}

main
