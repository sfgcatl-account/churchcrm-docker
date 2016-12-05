# Docker ChurchCRM

This is the Docker Installation of ChurchCRM. This image is the latest release ChurchCRM for Docker. It is installed on Alpine Linux, Apache, PHP7 & is using MariaDB in a separate Alpine container.

## How To Use

To use, first you must fill in your desired database info and **passwords** into the **``.env``** file.

Once complete, you can Start ChurchCRM in Docker by using the Docker RUN command or by building and starting with docker-compose.

###Starting the Container

Example:

You can start MariaDB first with the following command. Make sure to **change the passwords** in the ``.env`` file first.

``docker run --name database --env-file .env -d nimmis/alpine-mariadb``

Then start the ChurchCRM container:

``docker run --name churchcrm -p 80:80 --link database --env-file .env -d churchcrm/crm``

Visit your website and you will be up and running. Log in with the default username ``admin`` and password ``changeme`` and then change your admin password on the next screen.

### Building with Docker-Compose

To build and run with Docker-Compose, you must have all of the files in the Github repo. Download the Github Docker repository and run ``docker-compose build`` and ``docker-compose up`` from the project folder. **Be SURE to Change Passwords in the .env file before starting your container**.

## Up and Running with ChurchCRM

[](https://github.com/ChurchCRM/Docker/blob/master/images/Login.jpg)
