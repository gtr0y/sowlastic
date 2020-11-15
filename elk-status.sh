# Use curl -k to skip cert checking
clear
ELK='http://sowel-master1'
ELKPW='teslaCoil99'

echo "\n ----- Check Stats -----\n"
curl -k -u elastic:$ELKPW -XGET "$ELK:9200/_stats"
echo "\n ----- Check HTTP -----\n"
curl -k -u elastic:$ELKPW -XGET "http://elasticsearch-production"
echo "\n ----- Check HTTPS -----\n"
curl -k -u elastic:$ELKPW -XGET "$ELK"
echo "\n ----- Show Nodes -----\n"
curl -k -u elastic:$ELKPW -XGET "$ELK:9200/_cat/nodes?v"
echo "\n ----- Cluster Health -----\n"
curl -k -u elastic:$ELKPW -XGET "$ELK:9200/_cluster/health?pretty"
echo "\n ----- Show Master -----\n"
curl -k -u elastic:$ELKPW -XGET "$ELK:9200/_cat/master?v"
echo "\n ----- Show Certificates -----\n"
curl -k -u elastic:$ELKPW -XGET "$ELK:9200/_ssl/certificates?v"
