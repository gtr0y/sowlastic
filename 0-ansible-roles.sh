#!/bin/bash
#git clone https://github.com/gtr0y/sowlastic.git
read -p "Enter API key: " APIKEY
apt-get update
apt-get install python3-pip -y
apt-get install python3-jmespath -y
pip3 install ansible
ansible-galaxy collection install community.general
ansible-galaxy collection install community.digitalocean
ansible-galaxy collection install community.crypto
ansible-galaxy install elastic.elasticsearch,7.9.2
mkdir ./group_vars
echo "digio_api_key: $APIKEY" >> ./group_vars/all
echo "clustername: sowel-prod" >> ./group_vars/all
echo "slug: s-1vcpu-2gb" >> ./group_vars/all
echo "master_heap: 1g" >> ./group_vars/all
echo "data_heap: 1g" >> ./group_vars/all
echo "coord_heap: 1g" >> ./group_vars/all
touch hosts
export ANSIBLE_HOST_KEY_CHECKING=False
echo "[defaults]
host_key_checking = False" >> ./ansible.cfg
ssh-keygen -q -t rsa -b 2048 -N '' -f ~/.ssh/id_rsa <<<n 2>&1 >/dev/null
ansible-playbook 2-playbook-digitalocean.yml -i 1-sowlastic-inventory.yml
ansible-playbook 3-playbook-elastic.yml -i 1-sowlastic-inventory.yml
