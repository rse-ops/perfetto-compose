# Perfetto Docker

This is a small docker container (and automated build) to show using
[Perfetto](https://github.com/google/perfetto/) in Docker, and with docker-compose.

There are no guarentees about this setup - use and customize at your own discretion!

## Single Container

To run a single container (development) setup, first build

```bash
$ docker build -t perfetto .
```

Then run as follows, opening to [http://0.0.0.0:8000](http://0.0.0.0:8000)

```bash
$ docker run -it -p 8000:8000 perfetto --serve-host 0.0.0.0 --serve-port 8000 --serve
```
Note that the image will do some building of the frontend at run time, so give it a few minutes
to start up. When the UI is ready you'll see a message about it in the terminal.

## Docker Compose

### Choose Container

If you want to build perfetto, you can leave the docker-compose.yaml as is.
However if you want to use the automated build we provide, replace "build" with "image"

```yaml
services:
  perfetto:
    build: ./
    # Uncomment this and comment build to use image
    # image: ghcr.io/rse-ops/perfetto:latest
```

to

```yaml
services:
  perfetto:
    image: ghcr.io/rse-ops/perfetto:latest
```

### Certificates

To run with docker-compose and nginx (and SSL certs) first generate some self signed certs!

```bash
$ openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ./nginx/ssl/nginx-selfsigned.key -out ./nginx/ssl/nginx-selfsigned.crt
```

(it will ask you for questions - answer them!)

Create a strong Diffie-Hellman group for negotiating Perfect Forward Secrecy with clients:

```bash
$ openssl dhparam -out ./nginx/ssl/dhparam.pem 4096
```

Note that for the above you can also likely use certbot. This is just a straight forward way.

### Containers

Build the container:

```bash
$ docker-compose build
```

Bring up the containers!

```bash
$ docker-compose up -d
```

You'll need to change permissions in the volume or the static assets won't work:

```bash
$ docker exec nginx chmod 775 /usr/share/nginx/html -R
```

### Cleanup

Bring down the images and remove volumes.

```bash
$ docker-compose stop
$ docker-compose rm
$ docker volume rm perfetto_web-data
```

### Support

Need help? [Let us know](https://github.com/rse-ops/perfetto-compose/issues). E.g.,
for the HPC use case this could be modified to run with [Singularity Compose](singularityhub.github.io/singularity-compose/).
or plain Singularity. 
