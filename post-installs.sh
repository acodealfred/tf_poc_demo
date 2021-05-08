#!/bin/bash
yum -y install git
#install terraform
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum -y install terraform
#Install jenkins
#sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
#sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
#sudo yum upgrade
#sudo yum install jenkins java-1.8.0-openjdk-devel -y
#-- working
#wget  wget http://pkg.jenkins-ci.org/redhat-stable/jenkins-2.89.4-1.1.noarch.rpm
#sudo rpm -ivh jenkins-2.89.4-1.1.noarch.rpm
#sudo yum install java-1.8.0-openjdk-devel
#starting jenkins
#sudo systemctl daemon-reload
#sudo systemctl start jenkins

