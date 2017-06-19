Stratio Selenium-Chrome Image
=============================

Here we have the Stratio's Selenium-Chrome image.

* Based on Ubuntu 16.04
* Selenium Server Standalone 3.0.1
* Chromedriver 2.27
* Chrome version: 56
* OpenJDK 1.8

## How to run it?

```docker run -dit -e ID=<ID> --name selenium-chrome selenium-chrome:56```

## How to build it?

```git clone https://github.com/Stratio/docker-selenium-chrome```
```cd selenium-chrome```
```docker build . -t selenium-chrome:56 --build-arg VERSION=56```

## How to add extra hosts into container's /etc/hosts

You have to use --add-host flag, it can be used more than once

```docker run --add-host=docker:10.180.0.1 -dit -e ID=<ID> --name selenium-chrome selenium-chrome:56```

## How to get downloaded files

To get downloaded files, you just have to mount a directory as volume in /home/${USER_NAME}/Downloads:

```docker run -v /home/${USER_NAME}/Downloads:/home/${USER_NAME}/Downloads -dit -e ID=<ID> --name selenium-chrome selenium-chrome:56```

In this case is mandatory to use User management Variables.

## Enviroment Variables (I)

### ID
This variable is mandatory and specifies the unique identificator of the browser.
Ex. "ID=stratio"

### SELENIUM_GRID
This variable is optional and it is used to indicated a specific grid.
Ex. "SELENIUM_GRID=sl.demo.stratio.com:4444"

## Enviroment Variables (II): User management Variables

These variables are optional and they are used to execute the browser with an specific user. The four variables are mandatory when downloaded files want to be taken.

### USER_NAME
Ex. "USER_NAME=jenkins"

### USER_ID
Ex. "USER_ID=1000"

### GROUP_NAME
Ex. "GROUP_NAME=jenkins"

### USER_ID
Ex. "GROUP_ID=1000"