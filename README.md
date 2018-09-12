# docker-dero

Run DERO daemon on a Docker container...

### How to build

```sh
$ git clone https://github.com/monerador/docker-dero.git
$ cd docker-dero
$ docker build -t monerador/dero .
```

### How to Run

```sh
$ docker volume create --name dero
$ docker run -t -d --name dero -v dero:/dero --restart unless-stopped -p 127.0.0.1:20206:20206 -p 20202:20202 monerador/derod:latest
```
