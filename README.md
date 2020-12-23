# docker-rails

This is a barebones Rails app built in a Docker container.
It's really just a working example like you would build from
[Docker's documentation](https://docs.docker.com/compose/rails/).

## Getting Started

The Rails app has already been built and you should only need to
run the following:

### Build the Docker containers

You need to build new Docker containers initially. This is probably the
longest part because we need to install dependencies and such.

```bash
docker-compose build && docker-compose up
```

### Create the database

Keep the Docker container up and running (`docker-compose up`) and in
another terminal, run the following below. You'll only need to do this
once.

```bash
docker-compose run web rake db:create
```

### localhost

That's it! You should be able to navigate to localhost:3000 and see the
default Rails app page.
