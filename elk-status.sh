# Use curl -k to skip cert checking
clear
ELK='http://138.197.182.176'

echo "\n ----- Check Stats -----\n"
curl -u elastic:AidOikojeedPagBi -XGET "$ELK:9200/_stats"
echo "\n ----- Check HTTP -----\n"
curl -u elastic:AidOikojeedPagBi -XGET "http://elasticsearch-production"
echo "\n ----- Check HTTPS -----\n"
curl -u elastic:AidOikojeedPagBi -XGET "$ELK"
echo "\n ----- Show Nodes -----\n"
curl -u elastic:AidOikojeedPagBi -XGET "$ELK:9200/_cat/nodes?v"
echo "\n ----- Cluster Health -----\n"
curl -u elastic:AidOikojeedPagBi -XGET "$ELK:9200/_cluster/health?pretty"
echo "\n ----- Show Master -----\n"
curl -u elastic:AidOikojeedPagBi -XGET "$ELK:9200/_cat/master?v"
echo "\n ----- Show Certificates -----\n"
curl -u elastic:AidOikojeedPagBi -XGET "$ELK:9200/_ssl/certificates?v"
