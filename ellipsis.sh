#!/usr/bin/env bash

pkg.install() {
    if ! utils.cmd_exists docker; then
        case "$(uname -rs)" in
            Darwin*)
                if utils.cmd_exists brew; then
                    brew install --cask docker;
                fi
                ;;
            *WSL2|*-microsoft-standard)
                choco install docker-desktop;
                ;;
            Linux*)
                if utils.cmd_exists apt-get; then
                    sudo apt-get -y update;
                    sudo apt-get -y install \
                        apt-transport-https \
                        ca-certificates \
                        curl \
                        gnupg \
                        lsb-release;
                    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg;
                    echo \
                        "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
                        $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null;
                    sudo apt-get update;
                    sudo apt-get install docker-ce docker-ce-cli containerd.io;
                fi
                ;;
        esac
    fi
}

pkg.link() {
    : # Metapackage does not contain linkable files
}

pkg.unlink() {
    : # Metapackage does not contain linkable files 
}
