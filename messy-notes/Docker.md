## Docker

### Basic usage

- Create group docker and add user to it (relogin required):
```
$ sudo groupadd docker
$ sudo gpasswd -a $USER docker
```
- [Running Postgres in Docker](https://www.cybertec-postgresql.com/en/running-postgres-in-docker-why-and-how/)
- Run and mount:
```
$ docker run -it --name tweaker --rm --mount type=bind,source="$HOME"/,target=/home/mnt tweaker[:tag]
```
- List and remove containers:
```
$ docker stop $(docker ps -aq)
$ docker rm $(docker ps -aq)
```
- Create volume and container:
```
$ docker volume create pg13-data
$ docker run -d --name pg13 -p5432:5432 -e POSTGRES_HOST_AUTH_METHOD=trust \
  -v  pg13-data:/var/lib/postgresql/data \
  postgres
$ docker inspect pg13-data
```
- Various inspections:
```
$ docker exec -ti ae33afff32c6 sh -c "psql -U postgres -h localhost -p 5432 -c "show server_version" postgres
$ docker exec -it pg13 hostname -I
$ docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' pg13

$ docker exec -it pg13 /bin/bash
```
- Starting, stopping and restarting:
```
$ docker stop pg13
$ docker start pg13
$ docker update --restart unless-stopped pg13
```

### Curiosities

#### Health&Help Site Project Deployment
```
$ sudo gpasswd -a username docker  ;;; relogin to enable the docker group
$ sudo docker daemon

$ git clone https://github.com/koluch/hehe
$ cd hehe/

$ docker build -f dev.Dockerfile -t hehe .

$ docker run -it -p 3000:80 -v $(pwd):/var/www/site hehe

$ composer update

# npm install
# gulp
# yii migrate
```
- Cloning the fork:
```
$ git clone https://github.com/Tyrn/site hehe
$ git remote add upstream https://github.com/he-he-org/site
```
- Cyncing:
```
$ git fetch upstream                  ;; upstream optional?
$ git checkout master                 ;; not needed?
$ git merge upstream/master
```
