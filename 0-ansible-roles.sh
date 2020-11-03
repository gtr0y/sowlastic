apt-get install python3-pip
pip3 install ansible
ssh-keygen -b 2048 -t rsa
ansible-galaxy collection install community.general
ansible-galaxy collection install community.digitalocean
ansible-galaxy collection install community.crypto
ansible-galaxy install elastic.elasticsearch,7.9.2
git clone https://github.com/gtr0y/sowlastic.git