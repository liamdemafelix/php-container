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

## Tweaking nginx and PHP

The default nginx configuration file is in `config/nginx/app.conf`. Once you update this file, simply restart the nginx container.

For customizing `php.ini` settings, you can use `.user.ini` since we are using the `PHP-FPM` container. Simply place a `.user.ini` file in your project's working directory containing the settings you want to override.

## License

This repository is free to use under the MIT Open Source license.