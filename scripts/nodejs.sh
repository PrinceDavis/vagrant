cd ~
curl -sL https://deb.nodesource.com/setup_6.x -o nodesource_setup.sh

sudo bash nodesource_setup.sh

sudo apt-get install -y nodejs
sudo apt-get install -y gcc-c++ openssl-devel make
sudo apt-get install -y build-essential