docker-compose ps


# To Look inside the built container
docker-compose build
docker rum --rm -it --entrypoint=bash localhost:55000/gen:integration-10