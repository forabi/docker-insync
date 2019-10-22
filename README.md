# docker-insync

A Docker image to sync a Google Drive on disk using [Insync](https://www.insynchq.com/) and [`s6-overlay`](https://github.com/just-containers/s6-overlay).

You can get the Insync Drive token (`INSYNC_1_AUTH_CODE`) at https://insynchq.com/auth.

## How to use

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

## License

[MIT License](./LICENSE).

## Author

- [Hadrien Mary](https://github.com/hadim)
