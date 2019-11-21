# one-click-elk-using-packer-terraform-ansible-jenkins

# This Readme is a Work In Progress

## Prerequisites
* Install `packer` Locally.
* Install `ansible` Locally.
* Install `terraform` Locally.
* Install `aws-cli` Locally.
* Install `jq` Locally.
* Run `aws configure`.

## Generate Keypair

* Modify the `aws/gen-keypair.sh` with the name of the Keypair you want to create.
* Run `./gen-keypair.sh`.
* You will see a `*.pem` generated based on the name you choose.
* Use that Keypair for other steps.

## Packer(Jenkins)

* Modify the `packer/jenkins-ami.json` to suit your need.
* You need to open port 8080 in your firewall for Jenkins.
* Once the EC2 instance is created, You will need to unlock Jenkins by grabbing a password from the EC2 instance: `sudo cat /var/lib/jenkins/secrets/initialAdminPassword`.

## Ansible (ELK)

* This runs the installation of ELK in an instance.
* Make sure the correct `*.pem` key and `hostname/ip` is referenced in an `playbook/inventory/hosts.yml`.
* Run `ansible-playbook ansible-playbook/elk.yml`
* Failed on t2.micro because of jvm memory.
* Had to use a jdk-install script as ansible was failing.
* Had to use `server.host: "0.0.0.0"` in kibana configuration to allow connecting in all interfaces.
* Need to open 5601 in Security Groups.

## Terraform (Infrastructure Provisioning)
### Export `aws_access_key` and `aws_secret_key`
* Run `export AWS_ACCESS_KEY_ID="YOUR_ACCESS_KEY"` and `export AWS_SECRET_ACCESS_KEY="YOUR_SECRET_KEY"` after replacing it with your keys.
* `cd terraform` and `terraform init`, `terraform plan` and `terraform apply`

# How to Run this?
* Once you have the prerequisites and individual configuration (Packer, Ansible and Terraform) from above steps setup run `./main.sh`.
