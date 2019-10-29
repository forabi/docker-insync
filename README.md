# docker-insync

[![Docker Automated build](https://img.shields.io/docker/cloud/automated/hadim/docker-insync.svg)](https://hub.docker.com/r/hadim/docker-insync 'DockerHub')
[![Docker Build Status](https://img.shields.io/docker/cloud/build/hadim/docker-insync.svg)](https://hub.docker.com/r/hadim/docker-insync 'DockerHub')
[![Docker Pulls](https://img.shields.io/docker/pulls/hadim/docker-insync.svg)](https://hub.docker.com/r/hadim/docker-insync 'DockerHub')
[![Docker Image Size](https://images.microbadger.com/badges/image/hadim/docker-insync.svg)](https://microbadger.com/images/hadim/docker-insync "MicroBadger")

A Docker image to sync a Google Drive on disk using [Insync](https://www.insynchq.com/) and [`s6-overlay`](https://github.com/just-containers/s6-overlay).

*Note: This Docker image is inspired from https://github.com/tiredofit/docker-insync.*

## How to use

### Docker Hub

Use the following `docker-compose.yml` file:

```yaml
version: '3'

services:

  insync:
    container_name: insync
    image: hadim/docker-insync
    restart: unless-stopped
    environment:
      TIMEZONE: "America/Montreal"
      PUID: 1000
      PGID: 1000
      INSYNC_1_USERNAME: $DRIVE_USERNAME
      INSYNC_1_AUTH_CODE: $DRIVE_TOKEN
      INSYNC_1_DOWNLOAD: "ms-office"
      INSYNC_1_DISABLE_SYNC: >
                             root:<FOLDER_ID>,
                             root:<FOLDER_ID>,
                             root:<FOLDER_ID>,
      INSYNC_1_ENABLE_SYNC: >
                            root:<FOLDER_ID>,
                            root:<FOLDER_ID>
    volumes:
      - ../Drive:/data
```

### Cloning

You need to clone this repository and build the repository:

```bash
git clone https://github.com/hadim/docker-insync.git
cd docker-insync/
docker-compose build
```

Edit `docker-compose.yml`. Then run the container:

```bash
docker-compose up -d
docker-compose logs -f insync
```

## Configurations

### Data Volumes

| Directory | Description |
| --- | --- |
| `/data` | Backup and Configuration Directory |

### Environment Variables

| Parameter | Description | Default |
| --- | --- | --- |
| `TIMEZONE` | [Timezone string](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones) | `"America/Montreal"` |
| `PUID` | User ID (use `id $USER`) | `1000` |
| `PGID` | Group ID (use `id $USER`) | `1000` |
| `INSYNC_1_USERNAME` | Google Drive username (email) | `$DRIVE_USERNAME` |
| `INSYNC_1_AUTH_CODE` | [Google Drive Auth Token](https://insynchq.com/auth) | `$DRIVE_TOKEN` |
| `INSYNC_1_DOWNLOAD` | How to download Office files: `link` (.gdoc), `ms-office` (.docx), `open-document` (.odt) | `"ms-office"` |
| `INSYNC_1_DISABLE_SYNC` | List of folder IDs separated by a comma to exclude. |  |
| `INSYNC_1_ENABLE_SYNC` | List of folder IDs separated by a comma to include. |  |

You can also define `INSYNC_2_USERNAME`, `INSYNC_3_USERNAME` and so forth to sync multiple users.

## License

[MIT License](./LICENSE).

## Author

- [Hadrien Mary](https://github.com/hadim)
