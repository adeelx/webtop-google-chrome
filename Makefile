.PHONY: build tag push clean publish login refresh

DOCKER_REGISTRY ?= docker.io
IMAGE_NAME := adeelx/webtop-google-chrome

TIMESTAMP := $(shell date '+%Y%m%d-%H%M%S')

build:
	docker build --no-cache -t $(IMAGE_NAME) .

tag:
	docker tag $(IMAGE_NAME) "$(DOCKER_REGISTRY)/$(IMAGE_NAME):latest"
	docker tag $(IMAGE_NAME) "$(DOCKER_REGISTRY)/$(IMAGE_NAME):$(TIMESTAMP)"

push:
	docker push "$(DOCKER_REGISTRY)/$(IMAGE_NAME):latest"
	docker push "$(DOCKER_REGISTRY)/$(IMAGE_NAME):$(TIMESTAMP)"

clean:
	docker rmi -f "$(DOCKER_REGISTRY)/$(IMAGE_NAME):latest"
	docker rmi -f "$(DOCKER_REGISTRY)/$(IMAGE_NAME):$(TIMESTAMP)"

login:
	@docker login -u $(DOCKER_USERNAME) -p $(DOCKER_PASSWORD)

publish: build tag login push clean

refresh:
	sed -i -E "/Last updated:/s/Last updated: .*?/Last updated: $(shell date)/g" README.md
	git add README.md
	git commit -m "Forced update to initiate new image build."
	git push origin main
