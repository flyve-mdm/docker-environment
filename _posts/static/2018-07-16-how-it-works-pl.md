---
layout: post
howtos: true
published: true
title: How it Works
permalink: howtos/how-it-works-pl
description: Container's specifications
category: plugin
---

## Flyve MDM Docker Environment

Docker is a tool that allows us to create an environment based in containers and work with several dependencies linked together.

### Containers

#### 1. Glpi-apache

This container has the web server necessary to execute GLPI Project.

- Components:

<table class="zebra-style">
  <tbody>
  <tr>	   
     <th>Component</th>
     <th>Version Installed</th>
   </tr>
   <tr>
     <td><a href="https://www.apache.org/" alt="Apache">Apache</a></td>
     <td>2.4.33</td>
   </tr>
   <tr>
     <td><a href="https://curl.haxx.se/docs/manual.html" alt="Curl">Curl</a></td>
     <td>Latest</td>
   </tr>
   <tr>
     <td><a href="https://www.nano-editor.org/" alt="Nano">Nano</a></td>
     <td>Latest</td>
   </tr>
   </tbody>
</table>

This container is based in the [official image of HTTPD](https://hub.docker.com/_/httpd/).

#### 2. Glpi-PHP

This container has the programming languages necessary to execute GLPI Project in the Apache web server.

- Components:

<table class="zebra-style">
  <tbody>
  <tr>	   
     <th>Component</th>
     <th>Version Installed</th>
   </tr>
   <tr>
     <td><a href="http://php.net/manual/en/intro-whatis.php" alt="PHP">PHP</a></td>
     <td>7.1.17</td>
   </tr>
   <tr>
     <td><a href="https://nodejs.org/en/" alt="NodeJS">NodeJS</a></td>
     <td>6</td>
   </tr>
   <tr>
     <td><a href="https://bower.io/" alt="Bower">Bower</a></td>
     <td>Latest</td>
   </tr>
   <tr>
     <td><a href="https://git-scm.com/" alt="Git">Git</a></td>
     <td>Latest</td>
   </tr>
   <tr>
     <td><a href="https://getcomposer.org/" alt="Composer">Composer</a></td>
     <td>Latest</td>
   </tr>
   <tr>
     <td><a href="https://xdebug.org/docs/all_settings" alt="Xdebug">Xdebug</a></td>
     <td>2.6.0</td>
   </tr>
   <tr>
     <td><a href="https://curl.haxx.se/docs/manual.html" alt="Curl">Curl</a></td>
     <td>Latest</td>
   </tr>
   <tr>
     <td><a href="https://www.nano-editor.org/" alt="Nano">Nano</a></td>
     <td>Latest</td>
   </tr>
   </tbody>
</table>

This contianer is based in the [official image of PHP](https://hub.docker.com/_/php/).
The default version in this environment is composed by **FastCGI Process Manager**

#### 3. Glpi-MySQL

This container has the database engine necessary to execute GLPI Project.

- Components:

<table class="zebra-style">
  <tbody>
  <tr>	   
     <th>Component</th>
     <th>Version Installed</th>
   </tr>
   <tr>
     <td><a href="https://www.mysql.com/" alt="MySQL">MySQL</a></td>
     <td>5.6.35</td>
   </tr>
   </tbody>
</table>

This contianer is based in the [official image of MYSQL](https://hub.docker.com/_/mysql/).

#### 4. Glpi-PHPMyAdmin

This container has the web interface PHPMyAdmin necessary to see the Database MySQL of the project.

- Components:

<table class="zebra-style">
  <tbody>
  <tr>	   
     <th>Component</th>
     <th>Version Installed</th>
   </tr>
   <tr>
     <td><a href="https://www.phpmyadmin.net/" alt="PHPMyAdmin">PHPMyAdmin</a></td>
     <td>Latest</td>
   </tr>
   </tbody>
</table>

This contianer is based in the [official image of PHPMyAdmin](https://hub.docker.com/r/phpmyadmin/phpmyadmin/).

#### 5. Glpi-Mosquitto

This container has the Mqtt server necessary to establish connectivity between the Flyve MDM Administrator and the devices through the Flyve MDM Agent.

- Components:

<table class="zebra-style">
  <tbody>
  <tr>	   
     <th>Component</th>
     <th>Version Installed</th>
   </tr>
   <tr>
     <td><a href="https://mosquitto.org/" alt="Eclipse Mosquitto">Eclipse Mosquitto</a></td>
     <td>1.4.12</td>
   </tr>
   <tr>
     <td><a href="https://www.openssl.org/" alt="OpenSSL">OpenSSL</a></td>
     <td>Latest</td>
   </tr>
   <tr>
     <td><a href="https://git-scm.com/" alt="Git">Git</a></td>
     <td>Latest</td>
   </tr>
   </tbody>
</table>

This contianer is based in the [official image of Eclipse Mosquitto](https://hub.docker.com/_/eclipse-mosquitto/).

##### Network interface

This environment has a network defined to link the service containers. This network has a subnet *172.26.0.0/24* and its getaway is: 172.26.0.1.

We must verify the services running in these ports:

<table class="zebra-style">
  <tbody>
  <tr>	   
     <th>Port</th>
     <th>Used by</th>
   </tr>
   <tr>
     <td>80</td>
     <td><a href="https://www.apache.org/" alt="Apache">Apache</a></td>
   </tr>
   <tr>
     <td>9000</td>
     <td><a href="https://xdebug.org/docs/all_settings" alt="Xdebug">Xdebug</a></td>
   </tr>
   <tr>
     <td>3306</td>
     <td><a href="https://www.mysql.com/" alt="MySQL">MySQL</a></td>
   </tr>
   <tr>
     <td>8080</td>
     <td><a href="https://www.phpmyadmin.net/" alt="PHPMyAdmin">PHPMyAdmin</a></td>
   </tr>
   <tr>
     <td>1883 / 8883</td>
     <td><a href="https://mosquitto.org/" alt="Eclipse Mosquitto">Eclipse Mosquitto</a></td>
   </tr>
   </tbody>
</table>

If your host machine has a service listening in some of these ports, you have to stop that service or change the port in the *.env* file that is in the docker root of the project, before the build process of the  docker environment.

<img src="{{ '/images/picto-warning.png' | absolute_url }}" alt="Important!" height="16px"/> If the *.env* file is edited, PLEASE DO NOT PUSH OF THIS CHANGE in the repository.