#set env vars
set -o allexport; source .env; set +o allexport;

NEXTAUTH_SECRET=${NEXTAUTH_SECRET:-`openssl rand -hex 32`}
NEXT_PRIVATE_ENCRYPTION_KEY=${NEXT_PRIVATE_ENCRYPTION_KEY:-`openssl rand -hex 32`}
NEXT_PRIVATE_ENCRYPTION_SECONDARY_KEY=${NEXT_PRIVATE_ENCRYPTION_SECONDARY_KEY:-`openssl rand -hex 32`}
NEXT_PRIVATE_SIGNING_PASSPHRASE=${NEXT_PRIVATE_SIGNING_PASSPHRASE:-`openssl rand -hex 32`}

cat <<EOT > ./servers.json
{
    "Servers": {
        "1": {
            "Name": "local",
            "Group": "Servers",
            "Host": "172.17.0.1",
            "Port": 52598,
            "MaintenanceDB": "postgres",
            "SSLMode": "prefer",
            "Username": "postgres",
            "PassFile": "/pgpass"
        }
    }
}
EOT

cat << EOT >> ./.env
NEXTAUTH_SECRET=${NEXTAUTH_SECRET}
NEXT_PRIVATE_ENCRYPTION_KEY=${NEXT_PRIVATE_ENCRYPTION_KEY}
NEXT_PRIVATE_ENCRYPTION_SECONDARY_KEY=${NEXT_PRIVATE_ENCRYPTION_SECONDARY_KEY}
NEXT_PRIVATE_SIGNING_PASSPHRASE=${NEXT_PRIVATE_SIGNING_PASSPHRASE}

EOT

openssl req -newkey rsa:4096 -keyout myKey.pem -out myCSR.csr -nodes -subj "/CN=${DOMAIN}"
openssl x509 -signkey myKey.pem -in myCSR.csr -req -days 365 -out cert.pem
openssl pkcs12 -export -out cert.p12 -inkey myKey.pem -in cert.pem -password pass:"${NEXT_PRIVATE_SIGNING_PASSPHRASE}" -legacy
