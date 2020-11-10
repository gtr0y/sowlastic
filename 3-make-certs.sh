elhosts=$(cat hosts)
elhosts=($elhosts)
node=${elhosts[1]}
scp hosts root@$node:hosts
ssh root@$node 'bash -s' < gencerts.sh
