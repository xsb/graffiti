FROM busybox
ADD build/graffiti /graffiti
ENTRYPOINT ["/graffiti"]
