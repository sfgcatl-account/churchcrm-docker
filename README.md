#Docker ChurchCRM

This is the Docker Installation of ChurchCRM. This image is currently using the latest release of ChurchCRM. It is installed on Alpine Linux, Apache, PHP7 & the Latest MariaDB.

##How To Use

Download the latest image:

``docker pull jasonaskipper/churchcrm``

You can run MariaDB first with the following command. Make sure to change the passwords to something more secure.

``docker run --name crm-mariadb -e MYSQL_ROOT_PASSWORD=my-secret-password -e MYSQL_DATABASE=churchcrm -e MYSQL_USER=churchcrm -e MYSQL_PASSWORD=my-secret-pw -p 3306:3306 -d mariadb:latest``

Then Run the ChurchCRM image:

``docker run --name churchcrm -p 80:80 -p 443:443 --link crm-mariadb -d jasonaskipper/churchcrm``

##Docker-Compose

You can also download the repository and run ``docker-compose build`` and ``docker-compose up`` from the project folder.

##Running ChurchCRM

Go to your website and fill in the database username and password that you set up in the commands above. use ``crm-mariadb`` as the database host. Once set up you can use the default username of ``admin`` and password of ``changeme`` to log in.
