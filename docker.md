# Docker Cheat Sheet

Process goes like this: 
```bash
Dockerfile =[docker build]=> Docker image =[docker run]=> Docker container
```

# Common Commands

## Build

`cd` to folder where your `Dockerfile` is
```bash
docker build -t <name> .
```

Example:
```bash
docker build . -t graphql-docker
```

Verify image exists

```bash
docker images
```

## Run

__NOTE:__ Be sure to put `-p` before image name

Example (run a built image - neo4j:4.0.6)
```bash
docker run                                     \
-p 7474:7474 -p 7687:7687                      \
-v $PWD/data:/data                             \
--name neo4j-apoc                              \
-e NEO4J_AUTH=neo4j/letmein                    \
-e NEO4J_apoc_export_file_enabled=true         \
-e NEO4J_apoc_import_file_enabled=true         \
-e NEO4J_apoc_import_file_use__neo4j__config=true \
-e NEO4JLABS_PLUGINS=\[\"apoc\"\]              \
neo4j:4.0.6
```

### Detached
```bash
docker run -d <name>
```
Example:
```bash
docker run -p 49160:8080 -d graphql-docker
```
### Add host entry (local DNS)
```bash
docker run -it --add-host=neo4j:[your-host-ip] user/test-neo4j:latest
```
### Run command on container
```bash
docker run -it api:DOIT bash -c 'find / -type f | sort  | xargs -I{} shasum -a 256 {}' > ~pakey/dockerfiles.api-doit.txt
```

## Exec

Feed contents of file to remote command using exec
```bash
docker exec -i mycontainer <command> -t < <filename>
```

[Reference](https://stackoverflow.com/questions/53951136/pass-file-content-to-docker-exec)

# Maintenance #

## List Containers ##
```bash
docker ps
docker ps -a
```
## List Images ##
```bash
docker images
```

## Remove Container ##
```bash
docker rm <container_id>
# Force
docker rm -f <container_id>
```

## Remove Image ##
Will fail if there is a running instance of that image i.e. container
```bash
docker rmi <image_id>
```
To force removal of image even if it is referenced in multiple repositories, i.e. same image id given multiple names/tags.
Will still fail if there is a docker container referencing image
```bash
docker rmi -f <image_id>
```


---
# Docker-Compose

## Compatibility

First line in the `docker-compose.yml` file

Compatibility matrix: https://docs.docker.com/compose/compose-file/compose-file-v3/#compose-and-docker-compatibility-matrix

(Re)build your images (?)

    docker-compose up --build

Rebuild only one service
-

    docker-compose up --build --force-recreate --no-deps [-d] [<service_name>..]

Bring them up

    docker-compose up

If you started Compose in debug mode, stop your services once you've finished with them

    docker-compose up -d
    docker-compose stop
    docker-compose down
    docker-compose ps


---
Docker Images
=

Clean-up

    OLD_IFS=$IFS; IFS=$'\n'; for image_id in $(docker image ls | grep -v "latest" | grep "2 weeks ago"|awk '{print $3}'); do echo $image_id && docker image rm $image_id && echo "$image_id removed"; done; IFS=$OLDIFS

---
Sample Docker File
=

    FROM node:14-alpine
    LABEL org.opencontainers.image.source https://github.com/ajcwebdev/ajcwebdev-express-graphql-docker
    WORKDIR /usr/src/app
    COPY package*.json ./
    RUN npm i
    COPY . ./
    EXPOSE 8080
    #### Examples - only ONE CMD allowed
    CMD [ "node", "index.js" ]
    CMD [ "npm", "start" ]

---
Sample .dockerignore
=

    node_modules
    Dockerfile
    .dockerignore
    .git
    .gitignore
    npm-debug.log

