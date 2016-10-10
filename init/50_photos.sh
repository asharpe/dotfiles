#!/bin/bash

[[ -e ~/.password-store ]] && {
	e_header "Photos are already hooked up"
	exit 0
}

# TODO there'll be prompting for this
git clone https://gitlab.com/asharpe/photos ~/.password-store

