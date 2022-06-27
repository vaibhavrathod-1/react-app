include v.env
export $(shell sed 's/=.*//' v.env)
build:	build-version

.PHONY: build start push

build-version:	
	docker build -t ${DOCKER_USERNAME}/${REPO_NAME}:${VERSION} .
	
tag-latest:
	docker tag ${DOCKER_USERNAME}/${REPO_NAME}:${VERSION} ${DOCKER_USERNAME}/${REPO_NAME}:latest
 
start:
	docker run -it --rm ${DOCKER_USERNAME}/${REPO_NAME}:${VERSION}/bin/bash
login:
	echo ${DOCKER_PASSWORD} | docker login -u ${DOCKER_USERNAME} --password-stdin

push:	login tag-latest
	docker push ${DOCKER_USERNAME}/${REPO_NAME}:latest

minikube:
	minikube start

helm: 
	helm install helmchart ./charts/helmchart

service:
	kubectl get service
	

