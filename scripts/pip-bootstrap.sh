#!/usr/bin/env bash

# Save current directory
ORIG_DIR=$(pwd)

# Setup OS/Architecture metadata
OS=$(uname -s | tr '[:upper:]' '[:lower:]')

# URLs
PIP_URL="https://bootstrap.pypa.io/get-pip.py"

# Directory paths
TMP_PATH="/tmp"
OPT_PATH="${HOME}/opt"
BIN_PATH="${HOME}/bin"

# Install prerequisites
echo -n "Checking for unzip... "
if [[ -z "$(which unzip)" ]]
then
    echo "MISSING"
    if [[ "${OS}" == 'linux' ]]
    then
        echo "Installing unzip..."
        sudo apt-get install -y unzip
        echo "Finished installing unzip."
    else
        echo "ERROR!!! Unable to find unzip."
        exit 1
    fi
else
    echo "FOUND"
fi

echo -n "Checking for tar... "
if [[ -z "$(which tar)" ]]
then
    echo "MISSING"
    if [[ "${OS}" == 'linux' ]]
    then
        echo "Installing tar..."
        sudo apt-get install -y tar
        echo "Finished installing tar."
    else
        echo "ERROR!!! Unable to find tar."
        exit 1
    fi
else
    echo "FOUND"
fi

echo -n "Checking for jq... "
if [[ -z "$(which jq)" ]]
then
    echo "MISSING"
    if [[ "${OS}" == 'linux' ]]
    then
        echo "Installing jq..."
        sudo apt-get install -y jq
        echo "Finished installing jq."
    else
        brew install jq
    fi
else
    echo "FOUND"
fi

# Check for Python v3
echo -n "Checking for python3... "
if [[ -z "$(which python3)" ]]
then
    echo "MISSING"
    echo "Install python3..."
    if [[ "${OS}" == "darwin" ]]
    then
        brew install python3
    else
        sudo apt-get -y install python3
    fi
    echo "Finished installing python3."
else
    echo "FOUND"
fi

# Check for pip3
echo -n "Checking for pip3... "
if [[ -z "$(which pip3)" ]]
then
    echo "MISSING"
    echo "Install pip..."
    cd ${TMP_PATH}
    curl ${PIP_URL} -o get-pip.py
    sudo -H python3 get-pip.py
    echo "Finished installing pip."
else
    echo "FOUND"
fi

# Download archives
cd ${TMP_PATH}

echo "Finished downloading archives."

echo "DONE"

# Setup BIN_PATH
echo -n "Setup bin directory... "
mkdir -p $BIN_PATH
cd $BIN_PATH

echo "DONE"

# Setup Python modules
echo -n "Detecting requirements.txt file... "
cd ${ORIG_DIR}
if [[ ! -f 'requirements.txt' ]]
then
    echo "ERROR!!! requirements.txt not found."
    exit 1
fi
echo "DONE"

echo "Installing required Python modules..."
sudo -H python3 -m pip install -r requirements.txt
echo "Finished installing required Python modules."

echo "Bootstrap complete."
