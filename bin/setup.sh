#!/usr/bin/env bash
set -e
[ -n "$PYENV_DEBUG" ] && set -x

# Shared functions
pretty_print() {
	printf "\n%b\n" "$1"
}

checkout() {
  [ -d "$2" ] || git clone --depth 1 "$1" "$2"
  if [[ ${GIT_BRANCH} ]]; then
    git checkout "${GIT_BRANCH}"
  fi
}

install_or_upgrade_package() {
	if brew info $1 | grep --quiet 'Not installed'; then
	    pretty_print "Installing $1"
			brew install $1
	else
		if [ "$2" = true ]; then
			pretty_print "New version of $1 found, upgrading ..."
      brew upgrade $1 || true
		else
	    pretty_print "$1 detected, skipping ..."
		fi
	fi
}

pretty_print "Role Selection Menu \n------------------------------------------------"
# Select menu for Openstax job role
PS3='Enter the number of the role you would like to install: '
roles=("content_manager" "osx_common" "Quit")
select role in "${roles[@]}"
do
  case $role in
    "content_manager")
      OX_ROLE=$role
      pretty_print "Your computer will be configured for ${OX_ROLE}"
      break
      ;;
    "osx_common")
      OX_ROLE=$role
      pretty_print "Your computer will be configured for ${OX_ROLE}"
      break
      ;;
    "Quit")
      exit 1
      ;;
    *) pretty_print "Please make sure you enter the number beside the role.";;
  esac
done

# Set important folder path variables
if [ -z "$OX_ROOT" ]; then
  OX_ROOT="${HOME}/.openstax"
fi

OX_ANSIBLE=$OX_ROOT/ansible

pretty_print "Beginning the install"

# Install Homebrew
if ! command -v brew &>/dev/null; then
  pretty_print "Installing Homebrew, an OSX package manager, follow the instructions."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  pretty_print "You already have Homebrew installed...good job!"
  pretty_print "Checking to make sure Homebrew is up to date"
  brew update
fi

# Install Python3
install_or_upgrade_package "python3"

# Install git
install_or_upgrade_package "git" true

# pip install ansible
pip install -q ansible

# Clone the setup-openstax-machine repo
pretty_print "Cloning the installation playbook"
checkout "https://github.com/openstax/setup-openstax-machine.git" "${OX_ROOT}"

# Run the playbook
pretty_print "Running the ansible playbook. You will need to enter your password."
ansible-playbook -i "${OX_ANSIBLE}/inventory" "${OX_ANSIBLE}/playbook.yml" --ask-become-pass --extra-vars openstax_role="${OX_ROLE}"

# Everything is done so let's do some cleanup
pretty_print "We have finished setting up your computer.\nCleaning up ...\n"
rm -rf $OX_ROOT

# Done
pretty_print "Cleanup complete.\n\nHave a great day =)"
