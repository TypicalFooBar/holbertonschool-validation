# Build a docker container based on a Dockerfile
build:
	cp ~/.ssh/docker.pub .
	cp ~/.ssh/github .
	cp ~/.ssh/github.pub .
	docker build -t holberton-20.04 .
	rm docker.pub
	rm github
	rm github.pub

# Run a docker container
run:
	docker run -d -p 2022:22 -p 1313:1313 holberton-20.04

# Stop all docker containers
stop:
	docker stop $$(docker ps -a -q)

ssh:
	ssh -i ~/.ssh/docker root@localhost -p 2022

# Remove all containers and images - useful when debugging the Dockerfile a bunch
clean:
	docker system prune -af
	rm -f ~/.ssh/known_hosts

# Hugo server
hugo-server:
	hugo server --bind 0.0.0.0