apt-get install unzip
elhosts=$(cat hosts)
elhosts=($elhosts)
node=${elhosts[1]}
# scp hosts root@$node:hosts
# ssh root@$node 'bash -s' < gencerts.sh
scp root@$node:elastic-certs.zip elastic-certs.zip
unzip elastic-certs.zip

cat hosts | while read line || [[ -n $line ]];
do
 string=($line)
 scp ${string[1]}.zip root@${string[1]}:${string[1]}.zip
 scp sowca/ca.crt root@${string[1]}:ca.crt
 ssh -o StrictHostKeyChecking=no root@${string[1]} "apt-get install unzip"
 ssh -o StrictHostKeyChecking=no root@${string[1]} "unzip ${string[1]}.zip"
 ssh -o StrictHostKeyChecking=no root@${string[1]} "mkdir /etc/elasticsearch/security/"
 ssh -o StrictHostKeyChecking=no root@${string[1]} "mv ${string[1]}/${string[1]}.key /etc/elasticsearch/security/"
 ssh -o StrictHostKeyChecking=no root@${string[1]} "mv ${string[1]}/${string[1]}.crt /etc/elasticsearch/security/"
 ssh -o StrictHostKeyChecking=no root@${string[1]} "mv ca.crt /etc/elasticsearch/security/"
 ssh -o StrictHostKeyChecking=no root@${string[1]} "chown elasticsearch:elasticsearch /etc/elasticsearch/security/${string[1]}.*"
 ssh -o StrictHostKeyChecking=no root@${string[1]} "chmod 400 /etc/elasticsearch/security/${string[1]}.*"
 ssh -o StrictHostKeyChecking=no root@${string[1]} "chown elasticsearch:elasticsearch /etc/elasticsearch/security/ca.crt"
 ssh -o StrictHostKeyChecking=no root@${string[1]} "chmod 400 /etc/elasticsearch/security/ca.crt"
 ssh -o StrictHostKeyChecking=no root@${string[1]} "rm ${string[1]}.zip && rm -rf ${string[1]}"
done

#scp -o StrictHostKeyChecking=no ${string[1]}/* root@${string[1]}:/etc/elasticsearch/security/