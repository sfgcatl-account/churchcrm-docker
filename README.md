# Docker ChurchCRM

This is the Docker Installation of ChurchCRM. This image is the latest release ChurchCRM for Docker. It is installed on Alpine Linux, Apache, PHP7 & is using MariaDB in a separate Alpine container.

## How To Use

To use, first change your desired database info and **passwords** in the **``.env``** file. *(Download that file from the main ChurchCRM/Docker repository directory)*

Once complete, Start ChurchCRM in Docker by using the Docker RUN command from the directory that your ``.env`` file resides or by building and starting with docker-compose.

###Starting with Docker Run

For example, you can start MariaDB first with the following command. Make sure to **change the passwords** in the ``.env`` file first.

``docker run --name database --env-file .env -d jaskipper/alpine-mariadb``

Then start the ChurchCRM container:

``docker run --name churchcrm -p 80:80 --link database --env-file .env -d churchcrm/crm``

Visit your website and you will be up and running. Log in with the default username ``admin`` and password ``changeme`` and then change your admin password on the next screen.

### Building and Starting with Docker-Compose

To build and run with Docker-Compose, you must have all of the files in the Github repo. Download the Github Docker repository and run ``docker-compose build`` and ``docker-compose up`` from the project folder. **Be SURE to Change Passwords in the .env file before starting your container**.

## Up and Running with ChurchCRM

![Login Screen](https://github.com/ChurchCRM/Docker/images/Login.jpg)
