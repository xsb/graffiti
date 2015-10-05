bin:
	CGO_ENABLED=0 GOOS=linux go build -a -tags netgo -ldflags '-w' -o build/graffiti .

clean:
	rm -rf build

container: bin
	docker build -t graffiti .

all: clean bin
