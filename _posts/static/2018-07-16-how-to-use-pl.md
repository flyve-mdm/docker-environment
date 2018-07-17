---
layout: post
howtos: true
published: true
title: How to use
permalink: howtos/how-to-use-pl
description: Useful commands
category: plugin
---

## Commands

In this article we show you how to use and execute commands in your environment.

### Index

- [1. Start all containers](#1)
- [2. Start all containers in background](#2)
- [3. Stop all containers](#3)
- [4. Enter the containers](#4)
  - [4.1 Execute commands outside the containers](#4.1)

#### 1. Start all containers <a name="1"/>

To start all containers in this environment, you must execute the following command after entering the docker directory in the project root: ```docker-compose up```. This command starts all containers stopped.

```console
user@localhost:docker-image-feature-add-containers $ docker-compose up
Starting Glpi-MYSQL ... done
Starting Glpi-apache ... done
Starting Glpi-PHP ... done
Starting Glpi-Phpmyadmin ... done
Starting Glpi-Mosquitto ... done
Attaching to Glpi-MYSQL, Glpi-apache, Glpi-PHP, Glpi-Phpmyadmin, Glpi-Mosquitto
```

Notice that after executing the command, it will display an output indicating the starting process of the containers. If you see an output like this, it's an indicator that the containers are ready to work.

![Terminal output](https://i.imgur.com/0l7d00x.png)

#### 2. Start all containers in background <a name="2"/>

To start all containers in background, you must execute the following command after entering the docker directory in the project root: ```docker-compose start```. This command starts all containers in background.

```console
user@localhost:docker-image-feature-add-containers $ docker-compose start
Starting Glpi-MYSQL ... done
Starting Glpi-apache ... done
Starting Glpi-PHP ... done
Starting Glpi-Phpmyadmin ... done
Starting Glpi-Mosquitto ... done
Attaching to Glpi-MYSQL, Glpi-apache, Glpi-PHP, Glpi-Phpmyadmin, Glpi-Mosquitto
```

Notice that after executing the command, it will display an output indicating the starting process of the containers in background.

This command is useful, only if you don't need to see the start progress.

<img src="{{ '/images/picto-information.png' | absolute_url }}" alt="Good to know:" height="16px"/> To check the containers running you can use the command: ```docker ps```. It will display a table with the containers running, the commands, status and ports.

#### 3. Stop all containers <a name="3"/>

To stop all containers in this environment, you must execute the following command after entering the docker directory in the project root: ```docker-compose stop```. This command stop all containers with all its configuration saved.

```console
user@localhost:docker-image-feature-add-containers $ docker-compose stop
Stopping Glpi-MYSQL ... done
Stopping Glpi-apache ... done
Stopping Glpi-PHP ... done
Stopping Glpi-Phpmyadmin ... done
Stopping Glpi-Mosquitto ... done
```

Notice that after executing the command, it will display an output indicating the stopping process of the containers.

#### 4. Enter in the containers <a name="4"/>

The containers must be running in order to enter them.

##### Enter in Glpi-PHP

In this container you can execute all commands corresponding to PHP and composer packages manager. To enter in this container and access its terminal, you must follow these steps:

- Open a terminal in your host machine.
- Execute the command:

```user@localhost:~ $ docker exec -ti Glpi-PHP bash```

Where the parameters are:

    -i, --interactive          Keep STDIN open even if not attached
    -t, --tty                  Allocate a pseudo-TTY

##### Enter in Glpi-apache

In this container you can see all files corresponding to the GLPI directory. To enter in this container and access its terminal, you must follow these steps:

- Open a terminal in your host machine
- Execute this command:

```user@localhost:~ $ docker exec -ti Glpi-apache bash```

Where the parameters are:

    -i, --interactive          Keep STDIN open even if not attached
    -t, --tty                  Allocate a pseudo-TTY

##### Enter in Glpi-Mosquitto

In this container you can see all files corresponding to Mosquitto. To enter in this container and access its terminal, you must follow these steps:

- Open a terminal in your host machine.
- Execute this command:

```user@localhost:~ $ docker exec -ti Glpi-Mosquitto sh```

Where the parameters are:

    -i, --interactive          Keep STDIN open even if not attached
    -t, --tty                  Allocate a pseudo-TTY

##### Enter in Glpi-MYSQL

In this container you can see all files corresponding to MySQL including the databases. To enter in this container and execute commands from its terminal, you must follow these steps:

- Open a terminal in your host machine.
- Execute the command:

```user@localhost:~ $ docker exec -ti Glpi-MYSQL mysql -udocker -p```

In this step, you'll see a request to enter the password. Write "docker" in the terminal, to enter in the mysql service.

```console
user@localhost:~ $ docker exec -ti Glpi-MYSQL mysql -udocker -p
Enter password
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 665
Server version: 5.6.35 MySQL Community Server (GPL)

Copyright (c) 2000, 2016, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle 				Corporation and/or affiliates. Other names may be trademarks of their respective owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql>
```

Where the parameters are:

    -i, --interactive          Keep STDIN open even if not attached
    -t, --tty                  Allocate a pseudo-TTY
    -u,                        User for mysql database defined in the Mysql Dockerfile
    -p,                        Password set in the .env file  

#### 4.1 Execute command and exit of terminal <a name="4.1"/>

To execute commands inside containers without staying in its terminal, you can use the following syntax. It will enter the container, execute the given command and then exit the container.

##### **Glpi-PHP**

You can execute a command of Composer or/and PHP, for example, if you want to run the command ```composer install```, you must write it as it follows:

```user@localhost:~ $ docker exec -ti Glpi-PHP runuser www-data -c "composer install"```

Where the parameters are:

    -i, --interactive          Keep STDIN open even if not attached
    -t, --tty                  Allocate a pseudo-TTY
    www-data,                  the Apache user configured.

Notice that between the quotes is the command to execute.

In this case, we executed a command as Apache user. It's important to say that this command is executed in the GLPI root directory.

##### Install, uninstall, configure and execute the Flyve MDM Tests from terminal

##### 1. Install tests

To install the tests in the environment, you must use the command:

```user@localhost:~ $ docker exec -ti Glpi-PHP runuser www-data -c "flyvemdm-test -i"```

Where the parameters are:

    -i,                        Indicator to install the tests.

After execute this command, you can see the output indicating the installation process, like this:

![Terminal output](https://i.imgur.com/vRm1i95.png)

##### 2. Execute all tests

To execute the tests in the environment, you must use the command:

```user@localhost:~ $ docker exec -ti Glpi-PHP runuser www-data -c "flyvemdm-test -eall"```

Where the parameters are:

    -eall,                     Indicator to execute all tests

After executing this command, we can see the output indicating the execution process, like this:

![Terminal output](https://i.imgur.com/fZIkH4C.png)

This process execute the unit tests and the integration tests.

##### 3. Execute an specific test

To execute one test in the environment, you must use the command:

```user@localhost:~ $ docker exec -ti Glpi-PHP runuser www-data -c "flyvemdm-test -eone tests/suite-unit/PluginFlyvemdmPolicyBase.php"```

Where the parameters are:

    -eone,                     Indicator for execute one test
    source_to_test,            It's the source to the test for execute it

After executing this command, you can see the output indicating the execution process, like this:

![Terminal output](https://i.imgur.com/Xh6aw5S.png)

This process execute the unit tests and the integration tests.

##### 4. Uninstall all test

To uninstall all tests in the environment, you must use the command:

```user@localhost:~ $ docker exec -ti Glpi-PHP runuser www-data -c "flyvemdm-test -u"```

Where the parameters are:

    -u,                        Indicator to uninstall all tests.

After executing this command, you can see the output indicating the execution process, like this:

![Terminal output](https://i.imgur.com/DdJTgFY.png)

##### 5. Help in flyvemdm-test command

To see a display of the commands available for the tests, you must use the command:

```user@localhost:~ $ docker exec -ti Glpi-PHP runuser www-data -c "flyvemdm-test -h"```

Where the parameters are:

    -h,                        Help to use the command.

After execute this command, you can see the output indicating the help information, like this:

![Terminal output](https://i.imgur.com/glEqdcf.png)

##### 6. Multiple process in the same command

You can use the command to execute multiples processes in the environment, you must use the command:

```user@localhost:~ $ docker exec -ti Glpi-PHP runuser www-data -c "flyvemdm-test -i -eall -u"```

In this case, you do the installation, execution and uninstallation process respectively.

Where the parameters are:

    -i,                        Indicator to install the tests.
    -eall,                     Indicator to execute all tests.
    -u,                        Indicator to uninstall all tests.