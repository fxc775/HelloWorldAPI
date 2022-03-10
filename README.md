# HelloWorldAPI

docker build -t helloworldapi -f Dockerfile .

docker run -d -p 8080:80 helloworldapi

http://localhost:8080/helloworld