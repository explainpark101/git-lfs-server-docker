# Git LFS Server Docker Setup

This document explains how to set up and run the Git LFS server using Docker and Docker Compose.

## Prerequisites

- Docker
- Docker Compose

## Setup

1.  **`docker-compose.yml`**

    The `docker-compose.yml` file is configured to build the Docker image from the `dockerfile` in the current directory and run the Git LFS server.

    -   **Service:** `git-lfs-server`
    -   **Build:** The image is built from the local `dockerfile`.
    -   **Ports:** The server's port `8080` is mapped to port `12345` on the host machine.
    -   **Environment Variables:**
        -   The environment variables are loaded from the `.env` file. You can customize the values in that file.
        -   `LFS_ADMINUSER`: The admin username for the LFS server.
        -   `LFS_ADMINPASS`: The admin password for the LFS server.
        -   `LFS_SCHEME`: The protocol scheme used by the server.
    -   **Volumes:**
        -   A bind mount is used to map the host directory `/docker/lfs_data` to the container directory `/data/lfs-server`. **You must create the `/docker/lfs_data` directory on your host machine before starting the container.**

2.  **How to Run**

    To start the Git LFS server, run the following command in the same directory as the `docker-compose.yml` file:

    ```bash
    docker-compose up -d
    ```

    The `-d` flag runs the container in detached mode.

3.  **Accessing the Server**

    The Git LFS server will be accessible at `http://<your-docker-host>:9999`. The admin credentials are set in the `.env` file.

    -   **Username:** The value of `LFS_ADMINUSER` in `.env`.
    -   **Password:** The value of `LFS_ADMINPASS` in `.env`.

## Git LFS Configuration

To use this LFS server with your Git repository, configure the LFS URL in your local repository:

```bash
git config -f .lfsconfig lfs.url "http://<your-docker-host>:9999/jaehyung101/my-repo"
```

Replace `<your-docker-host>` with the IP address or hostname of the machine running the Docker container, and `my-repo` with your repository name. When you push LFS files, Git will prompt for your credentials.
