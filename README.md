# Trailblazer Example

Trailblazer experiment.

## Installing Docker and Docker Compose

Follow the installation instructions on [https://www.docker.com](https://www.docker.com/).

## Building the Docker image and all the necessary containers

0. Run `docker build .` to build an image with the appropriately installed software
0. Run `docker-compose build` to build all the necessary containers

## Configure the database

0. Run `cp config/database.yml.example config/database.yml` to create the database configuration file
0. Update the file if necessary, be sure to use the correct environment variables and host names available to your Rails app
0. Run `docker-compose run web rake db:create db:setup` to create and set up the database

## Launching the web server

Before launching the web server:

0. Run `cp config/secrets.yml.example config/secrets.yml` to create the secret key file
0. Run `rails secret` to generate a cryptographically secure secret key and add it to the secret key file

Run `docker-compose up` to serve the app. You can access the application via
the browser by visiting `http://localhost:3000`.

## Running the tests

Run `docker-compose run web rails spec` to run the `RSpec` tests.

## Interact via a Rails console

Run `docker-compose run web rails console` to interact via a `Rails` console
