#!/usr/bin/env bash
set -e

# Change into the main dir
cd "$(dirname "$0")"
cd ..

# Define a hash of roles
roles=( ["CM"]= "content_manager")

# Setup some variables
if [ ! -n "$OXDIR"]; then
  OXDIR=~/.ox-setup
fi
OXANSIBLE=$OXDIR/ansible

echo -n "Enter your two letter role at OpenStax from one of these choices:
\n CM - Content Manager \n"
read role_input

ROLE=roles[role_input]

# Shared functions
pretty_print() {
	printf "\n%b\n" "$1"
}

pretty_print "Beginning the install"

# Install Homebrew
if ! command -v brew &>/dev/null; then
  pretty_print "Installing Homebrew, an OSX package manager, follow the instructions."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  pretty_print "You already have Homebrew installed...good job!"
fi

# Install Python3
pretty_print "Installing Python 3.6"
brew install python3

# Install Python3
pretty_print "Installing ansible"
brew install ansible

# Install git
pretty_print "Installing git"
brew install git

# Clone the setup-openstax-machine repo
pretty_print "Cloning the installation playbook"
env git clone --depth=1 https://github.com/m1yag1/setup-openstax-machine $OXDIR || {
    pretty_print "Error: git clone of setup-openstax-machine repo failed\n"
    exit 1
  }

# Run the playbook
pretty_print "Running the ansible playbook. You will need to enter your password."
    ansible-playbook -i $OXANSIBLE/inventory $OXANSIBLE/local_install.yml --ask-become-pass
