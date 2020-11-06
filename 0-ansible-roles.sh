apt-get update
apt-get install python3-pip -y
pip3 install ansible
ssh-keygen -q -t rsa -b 2048 -N '' -f ~/.ssh/id_rsa <<<n 2>&1 >/dev/null
ansible-galaxy collection install community.general
ansible-galaxy collection install community.digitalocean
ansible-galaxy collection install community.crypto
ansible-galaxy install elastic.elasticsearch,7.9.2
git clone https://github.com/gtr0y/sowlastic.git