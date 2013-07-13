#!/usr/bin/env bash
# Simple setup.sh for configuring Ubuntu 12.04 LTS EC2 instance
# for headless setup. 

# Install nvm: node-version manager
# https://github.com/creationix/nvm
sudo apt-get install -y git-core
sudo apt-get install -y xauth x11-apps
curl https://raw.github.com/creationix/nvm/master/install.sh | sh

wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh

# Load nvm and install latest production node
source $HOME/.nvm/nvm.sh
nvm install v0.10.12
nvm use v0.10.12

# Install jshint to allow checking of JS code within emacs

npm install -g jshint
npm install -g cheerio #light implementation for server side jquery
npm install -g commander #utility for launchin g node js from the command line
npm install -g mocha #utility for unit test
npm install -g should #utility for unit test
# Install rlwrap to provide libreadline features with node
# See: http://nodejs.org/api/repl.html#repl_repl
sudo apt-get install -y rlwrap


# Install emacs24
# https://launchpad.net/~cassou/+archive/emacs
sudo apt-add-repository -y ppa:cassou/emacs
sudo apt-get update
sudo apt-get install -y emacs24 emacs24-el emacs24-common-non-dfsg
sudo apt-get install -y python-rope python-ropemacs ipython python3 ipython3
sudo apt-get install -y make
# git pull and install dotfiles as well
cd $HOME
if [ -d ./dotfiles/ ]; then
    mv dotfiles dotfiles.old
fi
if [ -d .emacs.d/ ]; then
    mv .emacs.d .emacs.d~
fi
git config --global user.name "Francesco Scali"
git config --global user.email francesco.scali@gmail.com 
#git clone https://github.com/startup-class/dotfiles.git
git clone https://github.com/fscali/DotFiles.git
ln -sb DotFiles/.screenrc .
ln -sb DotFiles/.bash_profile .
ln -sb DotFiles/.bashrc .
ln -sb DotFiles/.bashrc_custom .
ln -sf DotFiles/.emacs.d .
ln -sb DotFiles/.vimrc .
ln -sf DotFiles/.vim/ .

git clone git@bitbucket.org:fscali/vim-configuration.git
cd ~/vim-configuration
git submodule update --init
cd $HOME

ln -sf ~/vim-configuration .vim
ln -sb ~/vim-configuration/.vimrc .

cd DotFiles/.emacs.d/plugins/auto-complete-1.3.1
make clean
make byte-compile

#yasnippet
cd ~/DotFiles/
git submodule update --init
cd ..
ln -sb ~/dotfiles/yasnippet DotFiles/.emacs.d/plugins/yasnippet/

#dev
mkdir -p ~/dev/
git clone git@github.com:fscali/js-assessment.git ~/dev/js-assessment/
cd ~/dev/js-assessment/
node install
cd $HOME
#tools
##phantomjs
mkdir -p ~/bin/
mkdir -p ~/tools
wget https://phantomjs.googlecode.com/files/phantomjs-1.9.1-linux-x86_64.tar.bz2 -O - | tar -jxv -C ~/tools
ln -s  ~/tools/phantomjs-1.9.1-linux-x86_64/bin/phantomjs ~/bin/phantomjs

