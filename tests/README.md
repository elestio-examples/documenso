<a href="https://elest.io">
  <img src="https://elest.io/images/elestio.svg" alt="elest.io" width="150" height="75">
</a>

[![Discord](https://img.shields.io/static/v1.svg?logo=discord&color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=Discord&message=community)](https://discord.gg/4T4JGaMYrD "Get instant assistance and engage in live discussions with both the community and team through our chat feature.")
[![Elestio examples](https://img.shields.io/static/v1.svg?logo=github&color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=github&message=open%20source)](https://github.com/elestio-examples "Access the source code for all our repositories by viewing them.")
[![Blog](https://img.shields.io/static/v1.svg?color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=elest.io&message=Blog)](https://blog.elest.io "Latest news about elestio, open source software, and DevOps techniques.")

# Documenso, verified and packaged by Elestio

[Documenso](https://documenso.com) the Open Source DocuSign Alternative.

<img src="https://github.com/elestio-examples/documenso/raw/main/documenso.gif" alt="documenso" width="800">

Deploy a <a target="_blank" href="https://elest.io/open-source/documenso">fully managed Documenso</a> on <a target="_blank" href="https://elest.io/">elest.io</a> if you want automated backups, reverse proxy with SSL termination, firewall, automated OS & Software updates, and a team of Linux experts and open source enthusiasts to ensure your services are always safe, and functional.

[![deploy](https://github.com/elestio-examples/documenso/raw/main/deploy-on-elestio.png)](https://dash.elest.io/deploy?source=cicd&social=dockerCompose&url=https://github.com/elestio-examples/documenso)

# Why use Elestio images?

- Elestio stays in sync with updates from the original source and quickly releases new versions of this image through our automated processes.
- Elestio images provide timely access to the most recent bug fixes and features.
- Our team performs quality control checks to ensure the products we release meet our high standards.

# Usage

## Git clone

You can deploy it easily with the following command:

    git clone https://github.com/elestio-examples/documenso.git

Copy the .env file from tests folder to the project directory

    cp ./tests/.env ./.env

Edit the .env file with your own values.

Create cert.p12

    openssl req -newkey rsa:4096 -keyout myKey.pem -out myCSR.csr -nodes -subj "/CN=${DOMAIN}"
    openssl x509 -signkey myKey.pem -in myCSR.csr -req -days 365 -out cert.pem
    openssl pkcs12 -export -out cert.p12 -inkey myKey.pem -in cert.pem -password pass:"${NEXT_PRIVATE_SIGNING_PASSPHRASE}" -legacy

    chmod 777 ./cert.p12

Run the project with the following command

    docker-compose up -d

You can access the Web UI at: `http://your-domain:31264`

## Docker-compose

Here are some example snippets to help you get started creating a container.

    version: "3.9"

    services:
        database:
            image: elestio/postgres:15
            restart: always
            ports:
                - "172.17.0.1:52598:5432"
            volumes:
                - ./storage/db:/var/lib/postgresql/data:rw
            environment:
                - TZ=${TIMEZONE}
                - POSTGRES_DB=${POSTGRES_DB}
                - POSTGRES_USER=${POSTGRES_USER}
                - POSTGRES_PASSWORD=${POSTGRES_PASSWORD}

        documenso:
            image: documenso/documenso:${SOFTWARE_VERSION_TAG}
            depends_on:
                - database
            environment:
                - PORT=${PORT:-3000}
                - NEXTAUTH_URL=${NEXTAUTH_URL:-${NEXT_PUBLIC_WEBAPP_URL}}
                - NEXTAUTH_SECRET=${NEXTAUTH_SECRET:?err}
                - NEXT_PRIVATE_ENCRYPTION_KEY=${NEXT_PRIVATE_ENCRYPTION_KEY:?err}
                - NEXT_PRIVATE_ENCRYPTION_SECONDARY_KEY=${NEXT_PRIVATE_ENCRYPTION_SECONDARY_KEY:?err}
                - NEXT_PRIVATE_GOOGLE_CLIENT_ID=${NEXT_PRIVATE_GOOGLE_CLIENT_ID}
                - NEXT_PRIVATE_GOOGLE_CLIENT_SECRET=${NEXT_PRIVATE_GOOGLE_CLIENT_SECRET}
                - NEXT_PUBLIC_WEBAPP_URL=${NEXT_PUBLIC_WEBAPP_URL:?err}
                - NEXT_PUBLIC_MARKETING_URL=${NEXT_PUBLIC_MARKETING_URL:-https://documenso.com}
                - NEXT_PRIVATE_DATABASE_URL=${NEXT_PRIVATE_DATABASE_URL:?err}
                - NEXT_PRIVATE_DIRECT_DATABASE_URL=${NEXT_PRIVATE_DIRECT_DATABASE_URL:-${NEXT_PRIVATE_DATABASE_URL}}
                - NEXT_PUBLIC_UPLOAD_TRANSPORT=${NEXT_PUBLIC_UPLOAD_TRANSPORT:-database}
                - NEXT_PRIVATE_UPLOAD_ENDPOINT=${NEXT_PRIVATE_UPLOAD_ENDPOINT}
                - NEXT_PRIVATE_UPLOAD_FORCE_PATH_STYLE=${NEXT_PRIVATE_UPLOAD_FORCE_PATH_STYLE}
                - NEXT_PRIVATE_UPLOAD_REGION=${NEXT_PRIVATE_UPLOAD_REGION}
                - NEXT_PRIVATE_UPLOAD_BUCKET=${NEXT_PRIVATE_UPLOAD_BUCKET}
                - NEXT_PRIVATE_UPLOAD_ACCESS_KEY_ID=${NEXT_PRIVATE_UPLOAD_ACCESS_KEY_ID}
                - NEXT_PRIVATE_UPLOAD_SECRET_ACCESS_KEY=${NEXT_PRIVATE_UPLOAD_SECRET_ACCESS_KEY}
                - NEXT_PRIVATE_SMTP_TRANSPORT=${NEXT_PRIVATE_SMTP_TRANSPORT:?err}
                - NEXT_PRIVATE_SMTP_HOST=${NEXT_PRIVATE_SMTP_HOST}
                - NEXT_PRIVATE_SMTP_PORT=${NEXT_PRIVATE_SMTP_PORT}
                - NEXT_PRIVATE_SMTP_USERNAME=${NEXT_PRIVATE_SMTP_USERNAME}
                - NEXT_PRIVATE_SMTP_PASSWORD=${NEXT_PRIVATE_SMTP_PASSWORD}
                - NEXT_PRIVATE_SMTP_APIKEY_USER=${NEXT_PRIVATE_SMTP_APIKEY_USER}
                - NEXT_PRIVATE_SMTP_APIKEY=${NEXT_PRIVATE_SMTP_APIKEY}
                - NEXT_PRIVATE_SMTP_SECURE=${NEXT_PRIVATE_SMTP_SECURE}
                - NEXT_PRIVATE_SMTP_FROM_NAME=${NEXT_PRIVATE_SMTP_FROM_NAME:?err}
                - NEXT_PRIVATE_SMTP_FROM_ADDRESS=${NEXT_PRIVATE_SMTP_FROM_ADDRESS:?err}
                - NEXT_PRIVATE_RESEND_API_KEY=${NEXT_PRIVATE_RESEND_API_KEY}
                - NEXT_PRIVATE_MAILCHANNELS_API_KEY=${NEXT_PRIVATE_MAILCHANNELS_API_KEY}
                - NEXT_PRIVATE_MAILCHANNELS_ENDPOINT=${NEXT_PRIVATE_MAILCHANNELS_ENDPOINT}
                - NEXT_PRIVATE_MAILCHANNELS_DKIM_DOMAIN=${NEXT_PRIVATE_MAILCHANNELS_DKIM_DOMAIN}
                - NEXT_PRIVATE_MAILCHANNELS_DKIM_SELECTOR=${NEXT_PRIVATE_MAILCHANNELS_DKIM_SELECTOR}
                - NEXT_PRIVATE_MAILCHANNELS_DKIM_PRIVATE_KEY=${NEXT_PRIVATE_MAILCHANNELS_DKIM_PRIVATE_KEY}
                - NEXT_PUBLIC_DOCUMENT_SIZE_UPLOAD_LIMIT=${NEXT_PUBLIC_DOCUMENT_SIZE_UPLOAD_LIMIT}
                - NEXT_PUBLIC_POSTHOG_KEY=${NEXT_PUBLIC_POSTHOG_KEY}
                - NEXT_PUBLIC_DISABLE_SIGNUP=${NEXT_PUBLIC_DISABLE_SIGNUP}
                - NEXT_PRIVATE_SIGNING_LOCAL_FILE_PATH=/opt/documenso/cert.p12
                - NEXT_PRIVATE_SIGNING_PASSPHRASE=${NEXT_PRIVATE_SIGNING_PASSPHRASE}
            ports:
                - 172.17.0.1:31264:3000
            volumes:
                - ./cert.p12:/opt/documenso/cert.p12

        pgadmin:
            image: elestio/pgadmin:latest
            restart: always
            environment:
            PGADMIN_DEFAULT_EMAIL: ${ADMIN_EMAIL}
            PGADMIN_DEFAULT_PASSWORD: ${ADMIN_PASSWORD}
            PGADMIN_LISTEN_PORT: 8080
            ports:
                - "172.17.0.1:18879:8080"
            volumes:
                - ./servers.json:/pgadmin4/servers.json

### Environment variables

|                Variable                |                      Value (example)                      |
| :------------------------------------: | :-------------------------------------------------------: |
|          SOFTWARE_VERSION_TAG          |                          latest                           |
|             ADMIN_PASSWORD             |                       your-password                       |
|              ADMIN_EMAIL               |                      admin@email.com                      |
|                 DOMAIN                 |                      your-domain.com                      |
|              POSTGRES_DB               |                         documenso                         |
|             POSTGRES_USER              |                         postgres                          |
|           POSTGRES_PASSWORD            |                       your-password                       |
|             POSTGRES_HOST              |                         database                          |
|             POSTGRES_PORT              |                           5432                            |
|              NEXTAUTH_URL              |                  https://your-domain.com                  |
|         NEXT_PUBLIC_WEBAPP_URL         |                  https://your-domain.com                  |
|       NEXT_PUBLIC_MARKETING_URL        |                  https://your-domain.com                  |
|       NEXT_PRIVATE_DATABASE_URL        | postgres://postgres:your-password@database:5432/documenso |
|    NEXT_PRIVATE_DIRECT_DATABASE_URL    | postgres://postgres:your-password@database:5432/documenso |
|     NEXT_PRIVATE_SIGNING_TRANSPORT     |                           local                           |
|      NEXT_PUBLIC_UPLOAD_TRANSPORT      |                         database                          |
|      NEXT_PRIVATE_SMTP_TRANSPORT       |                         smtp-auth                         |
|         NEXT_PRIVATE_SMTP_HOST         |                      your.smtp.host                       |
|         NEXT_PRIVATE_SMTP_PORT         |                      your.smtp.port                       |
|  NEXT_PRIVATE_SMTP_UNSAFE_IGNORE_TLS   |                           true                            |
|      NEXT_PRIVATE_SMTP_FROM_NAME       |                         Documenso                         |
|     NEXT_PRIVATE_SMTP_FROM_ADDRESS     |                     sender@email.com                      |
| NEXT_PUBLIC_DOCUMENT_SIZE_UPLOAD_LIMIT |                             5                             |
|       NEXT_PRIVATE_JOBS_PROVIDER       |                           local                           |
|            NEXTAUTH_SECRET             |                openssl rand -hex 32 value                 |
|      NEXT_PRIVATE_ENCRYPTION_KEY       |                openssl rand -hex 32 value                 |
| NEXT_PRIVATE_ENCRYPTION_SECONDARY_KEY  |                openssl rand -hex 32 value                 |
|    NEXT_PRIVATE_SIGNING_PASSPHRASE     |                openssl rand -hex 32 value                 |

# Maintenance

## Logging

The Elestio Documenso Docker image sends the container logs to stdout. To view the logs, you can use the following command:

    docker-compose logs -f

To stop the stack you can use the following command:

    docker-compose down

## Backup and Restore with Docker Compose

To make backup and restore operations easier, we are using folder volume mounts. You can simply stop your stack with docker-compose down, then backup all the files and subfolders in the folder near the docker-compose.yml file.

Creating a ZIP Archive
For example, if you want to create a ZIP archive, navigate to the folder where you have your docker-compose.yml file and use this command:

    zip -r myarchive.zip .

Restoring from ZIP Archive
To restore from a ZIP archive, unzip the archive into the original folder using the following command:

    unzip myarchive.zip -d /path/to/original/folder

Starting Your Stack
Once your backup is complete, you can start your stack again with the following command:

    docker-compose up -d

That's it! With these simple steps, you can easily backup and restore your data volumes using Docker Compose.

# Links

- <a target="_blank" href="https://docs.documenso.com/?utm_medium=website&utm_term=header&utm_source=website&ref=website">Documenso documentation</a>

- <a target="_blank" href="https://github.com/documenso/documenso">Documenso Github repository</a>

- <a target="_blank" href="https://github.com/elestio-examples/documenso">Elestio/Documenso Github repository</a>
