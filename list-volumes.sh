read -p "Enter API key: " APIKEY
curl -X GET -H "Content-Type: application/json" -H "Authorization: Bearer $APIKEY" "https://api.digitalocean.com/v2/volumes?region=fra1"
