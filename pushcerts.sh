cat hosts | while read line || [[ -n $line ]];
do
 string=($line)
 mv ${string[1]}.key /etc/elasticsearch/security/
 mv ${string[1]}.crt /etc/elasticsearch/security/
 chown elasticsearch:elasticsearch /etc/elasticsearch/security/${string[1]}.*
 chmod 400 /etc/elasticsearch/security/${string[1]}.*
done

# mv sowca/ca.key /etc/elasticsearch/security/
# cp sowca/ca.crt /etc/elasticsearch/security/
# mv sowca/ca.crt /usr/share/ca-certificates/
# interactive method 
# dpkg-reconfigure ca-certificates
# non-interactive method
# update-ca-certificates
# chown elasticsearch:elasticsearch /etc/elasticsearch/security/ca.*
# chmod 400 /etc/elasticsearch/security/ca.key
# chmod 444 /etc/elasticsearch/security/ca.crt
rm -rf sowca
rm sowca.zip