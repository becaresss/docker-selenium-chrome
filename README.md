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

```git clone https://github.com/Stratio/selenium-chrome```
```cd selenium-chrome```
```docker build -t selenium-chrome:56 ```

## How to extend it?

In your Dockerfile include the next line
```FROM selenium-chrome:56```

## Enviroment Variables

### ID
This variable is mandatory and specifies the unique identificator of the browser.
Ex. "ID=stratio"

### SELENIUM_GRID
This variable is optional and it is used to indicated a specific grid.
Ex. "SELENIUM_GRID=sl.demo.stratio.com:4444"

### USER
This variable is optional and it is used to execute the browser with an specific user.
Ex. "USER=jenkins"
