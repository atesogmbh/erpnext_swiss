# ATESO ERPNext container
The following sections briefly explain how to generate the container.


## Build docker package
Build,

```shell
docker buildx bake
```
or without caching functionality. Everything from the scratch ...

```shell
docker buildx bake --no-cache
```

Note:

- Use `docker buildx bake --load` to load images for usage with docker.
- Use `docker buildx bake --push` to push images to registry.
- Use `docker buildx bake --help` for more information.
- Change version in `version.txt` to build tagged images from the changed version.


## Deplay and start containers
1. Deploy containers

    ```bash
    docker-compose -f compose.yaml -f overrides/compose.noproxy.yaml -f overrides/compose.mariadb.yaml -f overrides/compose.redis.yaml -f compose.override.yaml up -d
    ```

2. Install site and apps: Two step with clean install or fully

    ```bash
    docker-compose exec backend bench new-site frontend --mariadb-root-password 123 --admin-password admin --install-app erpnext --set-default
    docker-compose exec backend bench --site frontend install-app erpnextswiss
    ```

    or all together ...

    ```bash
    docker-compose exec backend bench new-site frontend --mariadb-root-password 123 --admin-password admin --install-app erpnext --install-app erpnextswiss --set-default
    ```

3. Restart and enjoy
    ```bash
    docker-compose restart backend
    ```