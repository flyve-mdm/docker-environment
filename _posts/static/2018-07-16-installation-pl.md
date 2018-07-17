---
layout: post
howtos: true
published: true
title: Installation
permalink: howtos/installation-pl
description: Building and configuring the environment
category: plugin
date: 2018-07-17
---

## Get the Docker Environment

To start with the installation process, we must get the [Flyve MDM Docker Environment](https://github.com/flyve-mdm/docker-environment) from its source.

- Using git, clone the repo: ```git clone https://github.com/flyve-mdm/docker-environment.git```
- [Download the project from GitHub](https://github.com/flyve-mdm/docker-environment/archive/develop.zip)
- [From GitHub Releases](https://github.com/flyve-mdm/docker-environment/releases)

Then, we follow these easy steps:

### If you're on Linux or Mac OS

#### 1. Enter into docker directory

After we get the project, we enter into the docker directory located in the root of the project.

#### 2. Configure the hosts file

In this part, we have to modify the host file in our host machine. This file is in the route ```/etc/hosts```.

Then, we add the host in a new line:

```172.26.0.31 www.dev.glpi.local```

Where, the parameters are:

    [ip_address_web] [host_name]

    ip_address_web             internal ip address of the Apache container
    host_name                  server_name defined in the .env file

#### 3. Configure your Fork source

In the documentation to [contribute to Docker Environment](https://github.com/flyve-mdm/docker-environment/blob/develop/CONTRIBUTING.md), we recommend to create a fork from the Flyve MDM repository. After this, we need set the  *FLYVEMDMSOURCE* variable in the *.env* file, writing the source of this fork.

```FLYVEMDM_SOURCE=git@github.com:<your_username>/glpi-plugin.git```

<img src="{{ '/images/picto-information.png' | absolute_url }}" alt="Good to know:" height="16px"/> We must remember that before this step, it must be ready the configuration of the SSH keys corresponding to your Github account.

#### 4. Build and start the containers

Now execute the command to build the docker environment in the terminal:

```user@localhost:docker-image-feature-add-containers $ docker-compose up --build```

#### 5. Open the browser

Open the browser and enter the server_name added in the previous step.

```http://www.dev.glpi.local```

This process download the images, build the containers, execute the configuration, create the network interface and start running all containers.