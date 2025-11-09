.PHONY: build run stop shell clean distclean push pull

DOCKER_REPO=ghcr.io/ceaser
DOCKER_APPNAME=docker-opencode
VERSION=$(shell git describe --tags 2> /dev/null || echo "latest")
ARGS= --dns 1.1.1.1
BUILD_ARGS=
BUILD_OBJS=

build:
	docker buildx build $(BUILD_ARGS) -t "$(DOCKER_REPO)/$(DOCKER_APPNAME):latest" .

run:
	docker run -it $(ARGS) --rm --name "$(DOCKER_APPNAME)" "$(DOCKER_REPO)/$(DOCKER_APPNAME):latest"

sh:
	docker run -it $(ARGS) --entrypoint bash --rm --name "$(DOCKER_APPNAME)" "$(DOCKER_REPO)/$(DOCKER_APPNAME):latest"

clean:
	-docker stop ${DOCKER_APPNAME}
	-docker rm -v ${DOCKER_APPNAME}
	#-rm $(BUILD_OBJS)

push:
	#docker tag "$(DOCKER_REPO)/$(DOCKER_APPNAME):latest" "$(DOCKER_REPO)/$(DOCKER_APPNAME):$(VERSION)"
	docker push "$(DOCKER_REPO)/$(DOCKER_APPNAME):$(VERSION)"
	docker push "$(DOCKER_REPO)/$(DOCKER_APPNAME):latest"

pull:
	docker pull "$(DOCKER_REPO)/$(DOCKER_APPNAME):latest

ip:
	docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' dev

