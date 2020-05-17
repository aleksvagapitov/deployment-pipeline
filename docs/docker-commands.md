docker tag aspnetcore/generator:multi localhost:55000/aspnetcore/generator:multi
docker push localhost:55000/aspnetcore/generator:multi

docker build -t testing .
docker run --rm testing ls -alR

docker run --rm -it -p 8080:80 localhost:55000/gen:ci-10

docker image prune

# For Integration Project
docker-compose up --force-recreate --abort-on-container-exit --build
