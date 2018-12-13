#!/usr/bin/env bash

# uopdate apt db
sudo apt-get update

# install and configure go 1.10
sudo apt-get install -y golang-1.10

grep 'GOPATH|GOROOT' ~/.bash_profile &>/dev/null || {
  sudo mkdir -p ~/go
  cp ~/.bash_profile ~/.bash_profile.ori 2>>/dev/null
  grep -v 'GOPATH|GOROOT' ~/.bash_profile.ori 2>>/dev/null | sudo tee -a ~/.bash_profile
  echo 'export GOROOT=/usr/lib/go-1.10' | sudo tee -a ~/.bash_profile
  echo 'export PATH=$PATH:$GOROOT/bin' | sudo tee -a ~/.bash_profile
  echo 'export GOPATH=~/go' | sudo tee -a ~/.bash_profile
  echo 'source ~/.bashrc' | sudo tee -a ~/.bash_profile
}

grep 'GOPATH|GOROOT' /home/vagrant/.bash_profile &>/dev/null || {
  sudo mkdir -p /home/vagrant/go
  cp /home/vagrant/.bash_profile /home/vagrant/.bash_profile.ori 2>>/dev/null
  grep -v 'GOPATH|GOROOT' /home/vagrant/.bash_profile.ori 2>>/dev/null | sudo tee -a /home/vagrant/.bash_profile
  echo 'export GOROOT=/usr/lib/go-1.10' | sudo tee -a /home/vagrant/.bash_profile
  echo 'export PATH=$PATH:$GOROOT/bin' | sudo tee -a /home/vagrant/.bash_profile
  echo 'export GOPATH=/home/vagrant/go' | sudo tee -a /home/vagrant/.bash_profile
  echo 'source /home/vagrant/.bashrc' | sudo tee -a /home/vagrant/.bash_profile
  sudo chown -R vagrant:  /home/vagrant
}


# install terraform
which wget unzip &>/dev/null || {
  apt-get install -y wget unzip
}

which terraform &>/dev/null || {
  pushd /usr/local/bin
  wget -q https://releases.hashicorp.com/terraform/0.11.10/terraform_0.11.10_linux_amd64.zip
  unzip terraform_0.11.10_linux_amd64.zip
  rm terraform_0.11.10_linux_amd64.zip
  popd
}

# install git
which git || {
  sudo apt-get install -y git
}

# clean up
sudo apt-get clean

