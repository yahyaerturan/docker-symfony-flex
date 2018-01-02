# Docker Symfony (PHP7-FPM - NGINX - MySQL - ELK)

Based on maxpou/docker-symfony. Thanks for great work.

This Docker uses only official images - no unknown flavour included.

Ready to eat Symfony environment with:

* Nginx 1.6.2
* PHP 7.1.12 FPM + Opcache + Xdebug
* Mysql 5.7.2
* ELK (Elasticsearch - Logstash - Kibana)
* PHPMyAdmin v4.7.7
* Git v2.1.4
* Node v8.9.3
* Npm v5.5.1
* Yarn v1.3.2
* Composer v1.5.6
* Symfony 3.4.x & 4.x compatible
* Easy php ini_settings management
* Automated Timezone via `.env` file
* Automated Global Git Configuration via `.env` file
* Pre-deployed .bashrc with colours and useful shortcuts
* Fixed IP Addresses to ensure you'll always have same IP for containers, especially for MySQL.
* `.data` folder (being created automatically) to ensure persistant data (logs, databases, etc.)
* Unified Working Directory: You will be working at `/var/www/symfony` whatever project folder you mount.
* and more.. Check Dockerfiles and configuration files to know 100% what's going on.

![](doc/schema.png)

Docker-symfony gives you everything you need for developing Symfony application. This complete stack run with docker and [docker-compose (1.7 or higher)](https://docs.docker.com/compose/).

## Installation

1. Create a `.env` from the `.env.dist` file. Adapt it according to your symfony application

    ```bash
    cp .env.dist .env
    ```


2. Build/run containers with (with and without detached mode)

    ```bash
    $ docker-compose build
    $ docker-compose up -d
    ```

3. Update your system host file (add myapp.local)

    Normally all you need is to set your `myapp.local` domain to `127.0.0.1` in your `/etc/hosts` file on host machine.

    ```bash
    # UNIX only: get containers IP address and update host (replace IP according to your configuration) (on Windows, edit C:\Windows\System32\drivers\etc\hosts)
    $ sudo echo $(docker network inspect bridge | grep Gateway | grep -o -E '[0-9\.]+') "myapp.local" >> /etc/hosts
    ```

    **Note:** For **OS X**, please take a look [here](https://docs.docker.com/docker-for-mac/networking/) and for **Windows** read [this](https://docs.docker.com/docker-for-windows/#/step-4-explore-the-application-and-run-examples) (4th step).

4. Work with your Symfony app located in any folder thanks to `.env` file.

    In this point, I advice you to setup a utility to open a /bin/bash line in containers because you will do it a lot :)
    [docker-ssh-automator](https://github.com/yahyaerturan/docker-ssh-automator) provides a very easy tool to get in containers.

    Simply type `docker-ssh` to get an option list for available containers. Click the number, and you are in.

    To work with Symfony, you need to get in respected `php` contanier.

5. Enjoy :-)

## Usage

Just run `docker-compose up -d`, then:

* Symfony app: visit [myapp.local](http://myapp.local)
* Symfony dev mode: visit [myapp.local/app_dev.php](http://myapp.local/app_dev.php)
* Logs (Kibana): [myapp.local:81](http://myapp.local:81)
* Logs (files location): logs/nginx and logs/symfony

## How it works?

Have a look at the `docker-compose.yml` file, here are the `docker-compose` built images:

* `db`: This is the MySQL database container,
* `php`: This is the PHP-FPM container in which the application volume is mounted,
* `nginx`: This is the Nginx webserver container in which application volume is mounted too,
* `elk`: This is a ELK stack container which uses Logstash to collect logs, send them into Elasticsearch and visualize them with Kibana.
* `phpmyadmin`: This is a PHPMyAdmin container to manage your databases.

This results in the following running containers:

```bash
$ docker-compose ps
           Name                          Command               State              Ports
--------------------------------------------------------------------------------------------------
dockersymfony_db_1            docker-entrypoint.sh mysqld      Up      0.0.0.0:3306->3306/tcp
dockersymfony_elk_1           /usr/bin/supervisord -n -c ...   Up      0.0.0.0:81->80/tcp
dockersymfony_nginx_1         nginx                            Up      0.0.0.0:80->80/tcp, 443/tcp
dockersymfony_php_1           docker-php-entrypoint php-fpm    Up      0.0.0.0:9000->9000/tcp
dockersymfony_phpmyadmin_1    /run.sh phpmyadmin               Up      0.0.0.0:8080->80/tcp
```

## Useful commands

```bash
# bash commands
$ docker-compose exec php bash

# Retrieve an IP Address (here for the nginx container)
$ docker inspect --format '{{ .NetworkSettings.Networks.dockersymfony_default.IPAddress }}' $(docker ps -f name=nginx -q)
$ docker inspect $(docker ps -f name=nginx -q) | grep IPAddress

# MySQL commands
$ docker-compose exec db mysql -uroot -p"root"

# F***ing cache/logs folder
$ sudo chmod -R 777 var/cache var/logs var/sessions # Symfony3

# Check CPU consumption
$ docker stats $(docker inspect -f "{{ .Name }}" $(docker ps -q))

# Delete all containers
$ docker rm $(docker ps -aq)

# Delete all images
$ docker rmi $(docker images -q)
```

## FAQ

* Got this error: `ERROR: Couldn't connect to Docker daemon at http+docker://localunixsocket - is it running?
If it's at a non-standard location, specify the URL with the DOCKER_HOST environment variable.` ?
Run `docker-compose up -d` instead.

* Permission problem? See [this doc (Setting up Permission)](http://symfony.com/doc/current/book/installation.html#checking-symfony-application-configuration-and-setup)

* How to config Xdebug?
Xdebug is configured out of the box!
Just config your IDE to connect port  `9001` and id key `PHPSTORM`

## Contributing

First of all, **thank you** for contributing ♥
If you find any typo/misconfiguration/... please send me a PR or open an issue. You can also ping me on [twitter](https://twitter.com/yahyaerturan).
Also, while creating your Pull Request on GitHub, please write a description which gives the context and/or explains why you are creating it.
