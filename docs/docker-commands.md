docker tag aspnetcore/generator:multi localhost:55000/aspnetcore/generator:multi
docker push localhost:55000/aspnetcore/generator:multi

docker build -t testing .
docker run --rm testing ls -alR

docker image prune