# Yet Another Docker Container for PHP Apps

This is a ready-to-go Docker container for PHP apps with Composer support.

You can slap this on to an existing project or create a new project using this container.

## Usage

Clone this repository, then modify `docker-compose.yml` to match your project's requirements. The default setup includes **PHP 7.4**, **MySQL 5.7** and **nginx 1.20 (alpine)**. Change it as needed.

Once you're done, build the container:

```
docker-compose build app
```

Then, start the containers:

```
docker-compose up -d
```

The default document root is `www/public`.

## Running artisan/php-cli commands

Simply `cd` into this directory and run:

```
docker-compose exec app <command here>
```

For instance, to run a Laravel migration:

```
docker-compose exec app php artisan migrate
```

## Customizing the Dockerfile

By default, this downloads a pre-built version of the Dockerfile triggered by GitHub Actions to the Docker Hub CI whenever a new tag is published.

If you want to customize the Dockerfile, you can:

1. Make your changes to the `Dockerfile`
2. Comment-out the pre-built section of `app` in the `docker-compose.yml` file
3. Uncomment the build section of `app` in the `docker-compose.yml` file

Then, simply run `docker-compose build app` to build your image locally. You can then run `docker-compose up -d` to start the containers, where it will use your local version.

## Tweaking nginx and PHP

The default nginx configuration file is in `config/nginx/app.conf`. Once you update this file, simply restart the nginx container.

For customizing `php.ini` settings, you can use `.user.ini` since we are using the `PHP-FPM` container. Simply place a `.user.ini` file in your project's public directory containing the settings you want to override.

Changes to `user.ini` should take effect within the value of `user_ini.cache_ttl` (by default, this is set to 5 minutes/300 seconds). If you want to make this change take effect immediately, restart the `main` container:

```
docker restart app-main
```

..of course, replacing `app-main` with the name of the main container you used in your `docker-compose.yml` file.

## License

This repository is free to use under the MIT Open Source license.