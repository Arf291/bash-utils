# !/bin/bash

# Build for match script to create test structure and packages needed

function installCommand() {
	comm="sudo apt-get install $1"

	if [ "$(uname)" = "Darwin" ]; then
		brew install $1
	fi
}

function main() {
	echo "Creating structure for tests..."
	mkdir -p tests/test1
	mkdir -p tests/test2

	echo "Installing bats..."
	installCommand bats
}

main