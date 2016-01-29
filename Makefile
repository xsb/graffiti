build:
	CGO_ENABLED=0 GOOS=linux go build -a -tags netgo -ldflags '-w' -o bin/graffiti .

clean:
	rm -rfv bin

container: build
	docker build -t graffiti .

all: clean build
