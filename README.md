# Website for Falcons

This contains the Dockerfile to create an Alpine container with nginx for
deployment onto a minikube cluster from docker hub.

## `prebuild.sh`

This file creates the main page of the site (`index.html`) from the template
file `src/index.template.html`. The script inserts the short git hash and the
commit date and time so that it is easy to see which version the site is
currently running.

