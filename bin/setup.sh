#!/usr/bin/env bash
set -e

# Change into the main dir
cd "$(dirname "$0")"
cd ..

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
