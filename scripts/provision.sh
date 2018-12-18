#!/usr/bin/env bash

# update apt db
sudo apt-get update

# install and configure go 1.10
sudo apt-get install -y golang-1.10

# configure go for root
grep 'GOPATH|GOROOT' ~/.bash_profile &>/dev/null || {
  sudo mkdir -p ~/go
  [ -f ~/.bash_profile ] && {
    cp ~/.bash_profile ~/.bash_profile.ori
    grep -v 'GOPATH|GOROOT' ~/.bash_profile.ori | sudo tee -a ~/.bash_profile
  }
  echo 'export GOROOT=/usr/lib/go-1.10' | sudo tee -a ~/.bash_profile
  echo 'export PATH=$PATH:$GOROOT/bin' | sudo tee -a ~/.bash_profile
  echo 'export GOPATH=~/go' | sudo tee -a ~/.bash_profile
  echo 'source ~/.bashrc' | sudo tee -a ~/.bash_profile
}

# configure go for vagrant user
grep 'GOPATH|GOROOT' /home/vagrant/.bash_profile &>/dev/null || {
  sudo mkdir -p /home/vagrant/go
  [ -f /home/vagrant/.bash_profile ] && {
    cp /home/vagrant/.bash_profile /home/vagrant/.bash_profile.ori
    grep -v 'GOPATH|GOROOT' /home/vagrant/.bash_profile.ori | sudo tee -a /home/vagrant/.bash_profile
  }
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

# install Kitchen-CI requirements
sudo apt-get install -y ruby ruby-dev
sudo gem install bundler

# clean up
sudo apt-get clean
