# Smashing Dashboard

A custom [smashing](https://github.com/Smashing/smashing) dashboard

## Build

    docker build -t smashing .

## Run Dashboard on localhost

    docker run -d --rm --name smashing -p 80:8080 -v $(pwd)/dashboard:/usr/app/dashboard smashing -p 8080 -e production
    open http://localhost/sample
    open http://localhost/sampletv

## Run Dashboard on Heroku

The dashboard application is in a subdirectory, hence we need to push a subtree:

    heroku login
    heroku apps:create my-own-dashboard
    heroku git:remote -a my-own-dashboard
    git subtree push --prefix dashoard heroku master

## Create New Dashboard

Create a new dashboard **ops**:

    cd dashboard
    docker run -v $(pwd):/usr/app/dashboard smashing generate dashboard ops

Open dashboard in browser and push a message:

    open http://localhost/ops
    curl -d '{ "auth_token": "123", "text": "Hey!" }' http://localhost/widgets/my_widget

## Create New Widget

Create a new widget **alert**:

    cd dashboard
    docker run -v $(pwd):/usr/app/dashboard smashing generate widget alert

Push an alert:

    curl -d '{ "auth_token": "123", "value": 999 }' http://localhost/widgets/response_time

<img src="https://raw.githubusercontent.com/thomd/smashing-dashboard/images/screenshot.png">
