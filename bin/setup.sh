#!/usr/bin/env bash
set -e
[ -n "$PYENV_DEBUG" ] && set -x

if [ -z "$OX_ROOT" ]; then
  OX_ROOT="${HOME}/.ox-setup"
fi

OX_ANSIBLE=$OX_ROOT/ansible

# Shared functions
pretty_print() {
	printf "\n%b\n" "$1"
}
checkout() {
  [ -d "$2" ] || git clone --depth 1 "$1" "$2"
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
checkout "https://github.com/m1yag1/setup-openstax-machine.git" "${OX_ROOT}"

# Run the playbook
pretty_print "Running the ansible playbook. You will need to enter your password."
    ansible-playbook -i $OX_ANSIBLE/inventory $OX_ANSIBLE/playbook.yml --ask-become-pass
