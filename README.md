
# Mailpit TLS

Providing a mail server [Mailpit](https://github.com/axllent/mailpit) including TLS certificate in [Docker](https://www.docker.com/)

## Installation

To deploy this project run next steps:

### Install docker
Visit the [Docker](https://www.docker.com/) website and install Docker if you haven’t already.

### Clone repository
```bash
git clone git@github.com:sadovyiov/mailpit.git
```

### Change the access permissions to init file
```bash
chmod +x init.sh
```

### Run init
```bash
./init.sh
```

### Fill required fields
- Enter the domain name for your application (e.g., example.com)
- Enter the username for the UI login
- Enter the password for the UI login
- Enter the username for the SMTP service
- Enter the password for the SMTP service

### Run docker containers
```bash
docker compose up -d
```

## Usage

### Dashboard
```
https://DOMAIN
```

### SMTP config
```
host: https://DOMAIN
port: 1025
username: SMTP_USER
password: SMTP_PASSWORD
```
