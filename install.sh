#!/bin/bash

# Prompting the user for Docker installation options
echo "Do you want to install Docker for a single node or multi-node setup?"
echo "1) Single Node"
echo "2) Multi Node"
echo "3) Skip Docker installation and continue to the next step"
# shellcheck disable=SC2162
read -p "Enter your choice (1, 2, or 3): " choice_docker

case $choice_docker in
    1)
        echo "Installing Docker for a single node..."
        ./others/docker/docker_install_single_node.sh
        ;;
    2)
        echo "Installing Docker for a multi-node setup..."
        ./others/docker/docker/docker_install_multi_node.sh
        ;;
    3)
        echo "Skipping Docker installation. Continuing to the next step..."
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

# Prompting the user for Zabbix installation options
echo "Do you want to install Zabbix for a single node or swarm-node setup?"
echo "1) Single Node"
echo "2) Swarm Node"
# shellcheck disable=SC2162
read -p "Enter your choice (1, 2): " choice_zabbix

case $choice_zabbix in
    1)
        echo "Installing zabbix for a single node..."
        ./single-node/scripts/zabbix_install.sh
        ;;
    2)
        echo "Installing zabbix for a swarm-node setup..."
        #./others/docker/docker/docker_install_multi_node.sh
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

# Proceeding to the next step
echo ----------------------------------------
echo "Starting application deployment..."
echo ----------------------------------------
# Call your deployment script or functions here

# Asking to install Zabbix Server
echo "Do you want to install Zabbix server?"
# shellcheck disable=SC2162
read -p "Enter your choice (yes/no): " install_zabbix



if [[ "$install_zabbix" == "yes" ]]; then
    echo "Installing Zabbix server..."
    ./resources/zabbix-6.4.9-main/zabbix_install.sh
else
    echo "Skipping Zabbix server installation."
fi

# Asking to install Grafana Monitor
echo "Do you want to install Grafana Monitor?"
# shellcheck disable=SC2162
read -p "Enter your choice (yes/no): " install_grafana

if [[ "$install_grafana" == "yes" ]]; then
    echo "Installing Grafana Monitor..."
    ./resources/grafana/install_grafana.sh
else
    echo "Skipping Grafana Monitor installation."
fi

# shellcheck disable=SC2154
if [[ "$continue_next" != "yes" ]]; then
    echo "Skipping next step."
    exit 0
fi
