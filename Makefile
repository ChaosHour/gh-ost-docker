BUILDER=mybuilder
IMAGE=gh-ost:latest
PLATFORM=linux/amd64

.PHONY:	all build push clean

all:	build clean

build:
	@if ! docker buildx inspect $(BUILDER) >/dev/null 2>&1; then \
		docker buildx create --name $(BUILDER) --use; \
	else \
		docker buildx use $(BUILDER); \
	fi
	docker buildx inspect --bootstrap
	docker buildx build --platform $(PLATFORM) -t $(IMAGE) --load .

push:
	@if ! docker buildx inspect $(BUILDER) >/dev/null 2>&1; then \
		docker buildx create --name $(BUILDER) --use; \
	else \
		docker buildx use $(BUILDER); \
	fi
	docker buildx inspect --bootstrap
	docker buildx build --platform $(PLATFORM) -t $(IMAGE) . --push

clean:
	docker buildx rm $(BUILDER)