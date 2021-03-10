#!/usr/bin/env bash

# Version of application to install
HELM2_VERSION="2.17.0"
KUBECTL_VERSION="1.17.14"
TERRAFORM_VERSION="0.12.29"

# Save current directory
ORIG_DIR=$(pwd)

# Setup OS/Architecture metadata
OS=$(uname -s | tr '[:upper:]' '[:lower:]')

# Archive File Names
HELM2_ARCHIVE="helm-v${HELM2_VERSION}-${OS}-amd64.tar.gz"
TERRAFORM_ARCHIVE="terraform_${TERRAFORM_VERSION}_${OS}_amd64.zip"

# URLs
HELM2_URL="https://get.helm.sh/${HELM2_ARCHIVE}"
PIP_URL="https://bootstrap.pypa.io/get-pip.py"
TERRAFORM_URL="https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/${TERRAFORM_ARCHIVE}"

# Directory paths
TMP_PATH="/tmp"
OPT_PATH="${HOME}/opt"
BIN_PATH="${HOME}/bin"
HELM2_PATH="${OPT_PATH}/helm-${HELM2_VERSION}"
TERRAFORM_PATH="${OPT_PATH}/terraform-${TERRAFORM_VERSION}"

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
    sudo python3 get-pip.py
    echo "Finished installing pip."
else
    echo "FOUND"
fi

NEED_HELM2=1
NEED_KUBECTL=1
NEED_TERRAFORM=1

# Check for Helm v2
echo -n "Checking for helm v2... "
if [[ -n "$(which helm2)" ]]
then
    HELM2_VERSION_DETECTED=$(helm2 version --client --short | sed 's/Client: v//;s/+.*//;')
    if [[ "${HELM2_VERSION_DETECTED}" == "${HELM2_VERSION}" ]]
    then
        echo "FOUND"
        NEED_HELM2=
    else
        echo "VERSION MISMATCH (v${HELM2_VERSION_DETECTED})"
    fi
else
    echo "MISSING"
fi

# Check for Terraform
echo -n "Checking for terraform... "
if [[ -n "$(which terraform)" ]]
then
    TERRAFORM_VERSION_DETECTED=$(terraform --version | sed -n '1{s/Terraform v//;p;}')
    if [[ "${TERRAFORM_VERSION_DETECTED}" == "${TERRAFORM_VERSION}" ]]
    then
        echo "FOUND"
        NEED_TERRAFORM=
    else
        echo "VERSION MISMATCH (v${TERRAFORM_VERSION_DETECTED})"
    fi
else
    echo "MISSING"
fi

# Download archives
cd ${TMP_PATH}

if [[ -n "${NEED_GCLOUD}" ]]
then
    echo "Downloading google-cloud-sdk..."
    curl -O "${GCLOUD_URL}"
fi

if [[ -n "${NEED_HELM2}" ]]
then
    echo "Downloading helm v2..."
    curl -O "${HELM2_URL}"
fi

if [[ -n "${NEED_TERRAFORM}" ]]
then
    echo "Downloading terraform..."
    curl -O "${TERRAFORM_URL}"
fi
echo "Finished downloading archives."

# Install Google Cloud SDK
if [[ -n "${NEED_GCLOUD}" ]]
then
    echo "Unpacking Google Cloud SDK..."
    mkdir -p ${GCLOUD_PATH}
    cd ${GCLOUD_PATH}
    tar xzvf "${TMP_PATH}/${GCLOUD_ARCHIVE}" --strip-components 1
    echo "Finished unpacking Google Cloud SDK."
    echo "Running Google Cloud SDK installer..."
    ${GCLOUD_PATH}/install.sh
    echo "Finished running Google Cloud SDK installer."
fi

# Install Kubectl
if [[ -n "${NEED_KUBECTL}" ]]
then
    echo "Installing kubectl..."
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/darwin/amd64/kubectl"
    chmod +x ./kubectl
    mv ./kubectl /usr/local/bin/kubectl
    sudo chown root: /usr/local/bin/kubectl
    sudo echo "Finished installing kubectl version:"
    kubectl version --client
fi

# Install helm v2
if [[ -n "${NEED_HELM2}" ]]
then
    echo "Unpacking helm v2..."
    mkdir -p ${HELM2_PATH}
    cd ${HELM2_PATH}
    tar xzvf "${TMP_PATH}/${HELM2_ARCHIVE}" --strip-components 1
    echo "Finished unpacking helm v2."
fi

# Install terraform
if [[ -n "${NEED_TERRAFORM}" ]]
then
    echo "Unpacking terraform..."
    mkdir -p ${TERRAFORM_PATH}
    cd ${TERRAFORM_PATH}
    unzip "${TMP_PATH}/${TERRAFORM_ARCHIVE}"
    echo "Finished unpacking terraform."
fi

# Setup convenience links
echo -n "Setup convenience links... "
cd ${OPT_PATH}

if [[ -n "${NEED_HELM2}" ]]
then
    ln -nsf "helm-${HELM2_VERSION}" helm2
fi

if [[ -n "${NEED_TERRAFORM}" ]]
then
    ln -nsf "terraform-${TERRAFORM_VERSION}" terraform
fi

echo "DONE"

# Setup BIN_PATH
echo -n "Setup bin directory... "
mkdir -p $BIN_PATH
cd $BIN_PATH

if [[ -n "${NEED_HELM2}" ]]
then
    ln -fs "${OPT_PATH}/helm2/helm" helm2
    ln -fs helm2 helm
    ln -fs "${OPT_PATH}/helm2/tiller" tiller
fi

if [[ -n "${NEED_TERRAFORM}" ]]
then
    ln -fs "${OPT_PATH}/terraform/terraform" terraform
fi

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

if [[ "${OS}" == "darwin" ]]
then
    PYTHON3_VERSION=$(python3 --version | sed 's/Python \(.*\)\.\(.*\)\..*/\1.\2/;')
    if [[ "${PYTHON3_VERSION}" == "3.8" && -z "${CLOUDSDK_PYTHON}" ]]
    then
        echo
        echo
        echo "!!!!!!!!!!"
        echo "The script detected that you are running Python v3.8. There is a change in Python 3.8 that breaks multithreading in gsutil."
        echo
        echo "To fix the problem, add the following to your ~/.bashrc and/or ~/.zshrc file:"
        echo
        echo "export CLOUDSDK_PYTHON=/usr/bin/python3"
        echo
    fi
fi

