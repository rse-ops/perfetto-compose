# Perfetto Docker

This is a small docker container (and automated build)

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

### Cleanup

Bring down the images and remove volumes.

```bash
$ docker-compose stop
$ docker-compose rm
$ docker volume rm perfetto_web-data
```
