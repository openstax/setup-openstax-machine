# Setting up your OpenStax development environment

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


## Introduction

One of the most important things when starting out in any software project(s) is setting up your development environment. These instructions set out with the goal of configuring an OSX or Linux machine with the basic dependencies needed for the various roles we have at OpenStax. This project attempts to simplify the bootstrapping process so that Content Mangers, Developers, QA Analysts, etc. can get setup quickly and start doing epic stuff.

## Getting started

Open a terminal window and run the following command:

```sh  
bash <(curl -s https://raw.githubusercontent.com/openstax/setup-openstax-machine/master/bin/setup.sh)
```

Follow the instruction prompts given by the script.

## Troubleshooting Homebrew

If you encounter any issues installing/updating Homebrew you may need to follow their [troubleshooting guide](https://github.com/Homebrew/brew/blob/master/docs/Troubleshooting.md)

## Developing on the playbook

### Clone this repository to your project directory

    git clone https://github.com/openstax/setup-openstax-machine.git

### Change into the project directory

    cd setup-openstax-machine

### Checkout the appropriate branch (if necessary)

    git checkout <branch_name>

### Create a virtualenv

    python3 -m venv .venv

### Activate the virtualenv

    source .venv/bin/activate

### Install the dependencies

    pip install -r requirements.txt

### Edit the playbook directly

Open any of the playbook files into your editor of choice

### Run the playbook independently

    ansible-playbook -i ansible/inventory ansible/playbook.yml --extra-vars openstax_role=content_manager --ask-become-pass

## Testing

To test the code found in a Pull Request, determine the branch name for the Pull Request and then replace `${GIT_BRANCH}` in the command below:

```sh
GIT_BRANCH="shiny-new-feature" bash <(curl -s https://raw.githubusercontent.com/openstax/setup-openstax-machine/${GIT_BRANCH}/bin/setup.sh)
```

