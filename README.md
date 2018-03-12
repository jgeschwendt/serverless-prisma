# Serverless Prisma

Minimal Serverless + Prisma Project Template

## Getting Started

- Be sure to have `Docker` and `Make` installed on your machine.

- Create an `.env` file for your local machine (refer to `~/.env.example` for the configuration requirements)

- Create Environment configurations for deployments, ie. `.env.dev`, `.env.prod`, alternatively this can be configured in your CI/CD.

```console

# Create a Node Development Docker Container

make devbox


# Start Serverless in Offline Mode

make start


# Package Service for Deployment

make build


# Deploy to a specific Environment

ENV=dev make deploy                     # uses the configuration from `.env.dev`

ENV=prod make deploy                    # uses the configuration from `.env.prod`

```

The complete command list can be viewed in the `~/Makefile`
