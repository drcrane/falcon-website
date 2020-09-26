# Website for Falcons

This contains the Dockerfile to create an Alpine container with nginx for
deployment onto a minikube cluster from docker hub.

## `prebuild.sh`

This file creates the main page of the site (`index.html`) from the template
file `src/index.template.html`. The script inserts the short git hash and the
commit date and time so that it is easy to see which version the site is
currently running.

## Build and run the Docker container

To build the container:

    docker build --tag falcon-website:latest .

To run the container:

    docker run -i -t -e PORT=8080 -p 8989:8080 --name falcon_website falcon-website:latest

To check that it works, switch to a new terminal and use curl:

    curl http://127.0.0.1:8989/

Discover the IP address and connect directly:

    FALCONIP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' falcon_website) \
        curl http://${FALCONIP}:8080

When the requests have been made a log entry should appear after the run
command, something like this:

    172.17.0.1 - - [26/Sep/2020:11:24:37 +0000] "GET / HTTP/1.1" 200 513 "-" "curl/7.71.1" rt=0.000 uct="-" uht="-" urt="-"

