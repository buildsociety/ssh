# BuildSociety SSH Server

This repository contains a Dockerized simple SSH server setup using Alpine Linux. The server is configured to generate new SSH host keys, ensure the SSH user has the necessary directories, and start the SSH server.

## Repository Structure

- `.github/workflows/`: Contains GitHub Actions workflows.
  - `build.yaml`: Workflow for building and pushing the Docker image.
- `Dockerfile`: Dockerfile to build the SSH server image.
- `entrypoint.sh`: Entrypoint script to set up and start the SSH server.
- `sshd_config`: Configuration file for the SSH server.
- `README.md`: This file.

## Docker Image

The Docker image is built using the `Dockerfile` and includes the following steps:
1. Uses Alpine Linux as the base image.
2. Adds the `sshd_config` and `entrypoint.sh` files to the image.
3. Installs the `openssh-server` package.
4. Creates necessary directories and user.
5. Sets permissions and ownership.
6. Exposes port `2222` for SSH connections.
7. Sets the entrypoint to the `entrypoint.sh` script.

## Entrypoint Script

The `entrypoint.sh` script performs the following actions:
1. Generates new SSH host keys.
2. Ensures the SSH user has a `.ssh` directory.
3. Adds any keys found in the `/workspace/keys` directory to the user's authorized keys.
4. Starts the SSH server.

## SSH Configuration

The `sshd_config` file configures the SSH server with the following settings:
- Listens on port `2222`.
- Uses host keys located in `/workspace/etc/ssh/`.
- Disables root login and password authentication.
- Enables public key authentication.
- Configures various other SSH settings.

## Add your SSH key

In order to connect, you will need to mount a copy of your **public** key into `/workspace/keys/`. This will then be added to the `authorized_keys` file for the `ssh-user` account.

## GitHub Actions Workflow

The GitHub Actions workflow defined in `.github/workflows/build.yaml` automates the building and pushing of the Docker image to GitHub Container Registry. It supports multiple platforms and runs on a schedule, on push, and on pull request events.

## Usage

To run this container, you can use the following to pull from our official GitHub Packages repo:

```sh
docker pull ghcr.io/buildsociety/ssh:latest
docker run -p 2222:2222 -v /path/to/public/key.pub:/workspace/keys/key.pub ghcr.io/buildsociety/ssh:latest