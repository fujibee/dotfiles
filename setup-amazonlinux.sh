sudo yum -y install zsh
sudo yum install util-linux-user
sudo chsh -s "$(which zsh)" ec2-user

# install node
curl -sL https://rpm.nodesource.com/setup_16.x | sudo bash -
sudo yum install -y nodejs
