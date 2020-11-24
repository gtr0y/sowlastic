This will create the Digital Ocean droplets and install Elastic cluster with hosts in the defined roles, as per the contents of 1-sowlastic-inventory.yml.
Tested on Ubuntu 20
You will need to have the Digital Ocean API key on hand.
After cloning, run the following script:
0-ansible-roles.sh
It should take care of everything except for setting the Elastic account passwords.
After everything had been set up you'll need to connect to any of the new nodes and run the following command:
You'll have to wait for a little bit until the cluster intializes, 10 minutes should be enough.
/usr/share/elasticsearch/bin/elasticsearch-setup-passwords interactive
