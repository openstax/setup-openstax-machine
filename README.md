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

Follow the instruction prompts given by the script

## Development testing

To test the code found in a Pull Request, determine the branch name for the Pull Request and then replace `${BRANCH_NAME}` in the command below:

```sh
bash <(curl -s https://raw.githubusercontent.com/openstax/setup-openstax-machine/${BRANCH_NAME}/bin/setup.sh)
```
