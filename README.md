# Smashing Dashboard

## Build

    docker build -t smashing .

## Run

    docker run -d --rm --name smashing -p 80:8080 -v $(pwd)/dashboard:/usr/app/dashboard smashing
