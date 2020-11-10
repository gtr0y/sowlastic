# connect to master1
#ssh sowel-master1
# install unzip for handling cert output
apt-get install unzip
# generate elastic ca as pem+crt (zip output)
/usr/share/elasticsearch/bin/elasticsearch-certutil ca --ca-dn "CN=StandOutWeb Elastic CA" --days 1095 --keysize 4096 --out ~/sowca.zip --pem
unzip sowca.zip
mv ca sowca
#generate node ca as pem+crt (zip output)
#read lines from hosts file
cat hosts | while read line || [[ -n $line ]];
do
 # convert to array
 string=($line)
 /usr/share/elasticsearch/bin/elasticsearch-certutil cert --ca-cert ~/sowca/ca.crt --ca-key ~/sowca/ca.key --keysize 4096 --dns ${string[1]} --ip ${string[0]} --name ${string[1]} --pem --out ~/${string[1]}.zip
 unzip ${string[1]}.zip
 #read file content
 #openssl x509 -text -noout -in ${string[1]}/${string[1]}.crt
 scp ${string[1]}/* root@${string[1]}:/etc/elasticsearch/security/
 mv ${string[1]}/* /etc/elasticsearch/security/
 chown elasticsearch:elasticsearch /etc/elasticsearch/security/${string[1]}.*
 chmod 400 /etc/elasticsearch/security/${string[1]}.*
 rm ${string[1]}.zip
 rm -rf ${string[1]}
done

mv sowca/ca.key /etc/elasticsearch/security/
cp sowca/ca.crt /etc/elasticsearch/security/
mv sowca/ca.crt /usr/share/ca-certificates/
# interactive method 
# dpkg-reconfigure ca-certificates
# non-interactive method
update-ca-certificates
chown elasticsearch:elasticsearch /etc/elasticsearch/security/ca.*
chmod 400 /etc/elasticsearch/security/ca.key
chmod 444 /etc/elasticsearch/security/ca.crt
rm -rf sowca
rm sowca.zip
