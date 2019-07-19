#!/bin/bash -e

main () {
  sudo apt-get update -y
  sudo apt install openjdk-8-jdk -y
}
main
