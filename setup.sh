#!/bin/bash
echo ""
echo "*** Setting Up New Mac ***"
echo ""
read -s -p "Enter Password for sudo: " sudoPW
echo ""

#Brew
echo ""
echo "* Homebrew"
if test ! $(which brew); then
  echo "Installing Homebrew..."
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  echo "Homebrew already installed"
fi

# Update homebrew recipes
echo "Updating homebrew..."
brew update

#Xcode command line Tools - This will also install git
echo "Installing Xcode Command Line Tools..."
xcode-select --install

#Cocoapods
echo ""
echo "* Cocoapods"
if test ! $(which cocoapods); then
  echo "Installing cocoapods..."
  echo $sudoPW | sudo gem install cocoapods
else
  echo "Cocoapods already installed"
fi

#pip
echo ""
echo "* pip"
if test ! $(which pip); then
  echo "Installing pip..."
  curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
  python get-pip.py
else
  echo "pip already installed"
fi

#AWS
echo ""
echo "* AWS CLI"
if test ! $(which aws); then
  echo "Installing AWS CLI..."
  pip install awscli
else
  echo "AWS CLI already installed"
fi

#Brew Packages
declare -a brew_apps=(
  node
  carthage
)

for app in "${brew_apps[@]}"; do
  echo ""
  echo "* ${app}"
  echo "Installing: ${app}..."
  brew install ${app}
done

#Applications
declare -a cask_apps=(
  dropbox
  google-chrome
  iterm2
  slack
  sourcetree
  spotify
  visual-studio-code
  fastlane
  postman
  charles
  atom
  intellij-idea-ce
  android-studio
)

for app in "${cask_apps[@]}"; do
  echo ""
  echo "* ${app}"
  echo "Installing: ${app}..."
  brew cask install --appdir="/Applications" ${app}
done

brew cleanup
brew cask alfred link
