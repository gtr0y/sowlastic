apt-get install unzip
elhosts=$(cat hosts)
elhosts=($elhosts)
node=${elhosts[1]}
scp -o StrictHostKeyChecking=no hosts root@$node:hosts
ssh -o StrictHostKeyChecking=no root@$node 'bash -s' < gencerts.sh
scp -o StrictHostKeyChecking=no root@$node:elastic-certs.zip elastic-certs.zip
ssh -o StrictHostKeyChecking=no root@$node 'rm elastic-certs.zip'
unzip elastic-certs.zip

echo "Hosts to be processed:"
cat hosts
echo "Proceed..."
cat hosts | while read line || [[ -n $line ]];
do
 string=($line)
 echo "Sending certs to ${string[1]}"
 #
 unzip ${string[1]}.zip
 scp ${string[1]}/${string[1]}.key root@${string[1]}:${string[1]}.key
 scp ${string[1]}/${string[1]}.crt root@${string[1]}:${string[1]}.crt
 #
 #scp ${string[1]}.zip root@${string[1]}:${string[1]}.zip
 scp sowca/ca.crt root@${string[1]}:ca.crt
 #ssh -n -o StrictHostKeyChecking=no root@${string[1]} "apt-get install unzip" # decided to send unpacked
 #ssh -n -o StrictHostKeyChecking=no root@${string[1]} "unzip ${string[1]}.zip" # decided to send unpacked
 echo "Moving files (${string[1]})"
 ssh -n -o StrictHostKeyChecking=no root@${string[1]} "mkdir /etc/elasticsearch/security/"
 ssh -n -o StrictHostKeyChecking=no root@${string[1]} "mv ${string[1]}/${string[1]}.key /etc/elasticsearch/security/"
 ssh -n -o StrictHostKeyChecking=no root@${string[1]} "mv ${string[1]}/${string[1]}.crt /etc/elasticsearch/security/"
 ssh -n -o StrictHostKeyChecking=no root@${string[1]} "mv ca.crt /etc/elasticsearch/security/"
 echo "Setting permissions (${string[1]})"
 ssh -n -o StrictHostKeyChecking=no root@${string[1]} "chown elasticsearch:elasticsearch /etc/elasticsearch/security/${string[1]}.*"
 ssh -n -o StrictHostKeyChecking=no root@${string[1]} "chmod 400 /etc/elasticsearch/security/${string[1]}.*"
 ssh -n -o StrictHostKeyChecking=no root@${string[1]} "chown elasticsearch:elasticsearch /etc/elasticsearch/security/ca.crt"
 ssh -n -o StrictHostKeyChecking=no root@${string[1]} "chmod 400 /etc/elasticsearch/security/ca.crt"
 echo "Cleaning up (${string[1]})"
 #ssh -n -o StrictHostKeyChecking=no root@${string[1]} "rm ${string[1]}.zip && rm -rf ${string[1]}" # decided to send unpacked
done

#scp -o StrictHostKeyChecking=no ${string[1]}/* root@${string[1]}:/etc/elasticsearch/security/