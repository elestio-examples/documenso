#set env vars
set -o allexport; source .env; set +o allexport;

docker-compose down;
sed -i "s~DOMAIN_TO_CHANGE~${DOMAIN}~g" ./docker-compose.yml
docker-compose up -d;

#wait until the server is ready
echo "Waiting for software to be ready ..."
sleep 300s;

