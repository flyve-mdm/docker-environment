# Docker Environment

![Flyve MDM banner](https://user-images.githubusercontent.com/663460/26935464-54267e9c-4c6c-11e7-86df-8cfa6658133e.png)

[![License](https://img.shields.io/github/license/flyve-mdm/docker-environment.svg?&label=License)](https://github.com/flyve-mdm/docker-environment/blob/master/LICENSE.md)
[![Follow twitter](https://img.shields.io/twitter/follow/FlyveMDM.svg?style=social&label=Twitter&style=flat-square)](https://twitter.com/FlyveMDM)
[![Telegram Group](https://img.shields.io/badge/Telegram-Group-blue.svg)](https://t.me/flyvemdm)
[![IRC Chat](https://img.shields.io/badge/IRC-%23flyvemdm-green.svg)](http://webchat.freenode.net/?channels=flyve-mdm)
[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-yellow.svg)](https://conventionalcommits.org)
[![Project Status: Concept](http://www.repostatus.org/badges/latest/concept.svg)](http://www.repostatus.org/#concept)
[![GitHub release](https://img.shields.io/github/release/flyve-mdm/docker-environment.svg)](https://github.com/flyve-mdm/docker-environment/releases)

Flyve MDM is a Mobile device management software that enables you to secure and manage all the mobile devices of your business or family via a web-based console.

To get started, check out [Flyve MDM Website](https://flyve-mdm.com/)!

## Table of contents

* [Synopsis](#synopsis)
* [Build Status](#build-status)
* [Compatibility Matrix](#compatibility-matrix)
* [Documentation](#documentation)
* [Versioning](#versioning)
* [Contribute](#contribute)
* [Contact](#contact)
* [Professional Services](#professional-services)
* [Copying](#copying)

## Synopsis

Get your own instance of Flyve MDM plugin for GLPI by using Docker.

**Important notes**

* This docker project is for development uses and not for real production environments. 

* When the docker is built the PHP-GLPI container gets the latest version of the development version of Flyve MDM plugin, 
so it could be normal to get some bugs once in a while because it has different features and fixes from the official release. 

* For security reasons, it also does not include a mail service container to deliver emails needed for GLPI

## Build Status

| **LTS** | **Bleeding Edge** |
|:---:|:---:|
| [![Build Status](https://travis-ci.org/flyve-mdm/docker-environment.svg?branch=master)](https://travis-ci.org/flyve-mdm/docker-environment) | [![Build Status](https://travis-ci.org/flyve-mdm/docker-environment.svg?branch=develop)](https://travis-ci.org/flyve-mdm/docker-environment) |

## Compatibility Matrix

| **OS** | **Tested Version** | **Docker Environment** |
|:---:|:---:|:---:|
| MacOS | Sierra 10.12.6 | X |
| Linux (Ubuntu) | 16.04 | X |
| Windows | 7 Home Basic, 10 Professional| X |

## Documentation

We maintain a detailed documentation of the project on the website, check the [How-tos](http://flyve.org/docker-environment/howtos/) and [Development](http://flyve.org/docker-environment/) section.

## Versioning

In order to provide transparency on our release cycle and to maintain backward compatibility, Flyve MDM is maintained under [the Semantic Versioning guidelines](http://semver.org/). We are committed to following and complying with the rules, the best we can.

See [the tags section of our GitHub project](http://github.com/flyve-mdm/docker-environment/tags) for changelogs for each release version of Flyve MDM. Release announcement posts on [the official Teclib' blog](http://www.teclib-edition.com/en/communities/blog-posts/) contain summaries of the most noteworthy changes made in each release.

## Contribute

Want to file a bug, contribute some code, or improve documentation? Excellent! Read up on our
guidelines for [contributing](./CONTRIBUTING.md) and then check out one of our issues in the [Issues Dashboard](https://github.com/flyve-mdm/docker-environment/issues).

## Contact

For notices about major changes and general discussion of Flyve MDM development, subscribe to the [/r/FlyveMDM](http://www.reddit.com/r/FlyveMDM) subreddit.
You can also chat with us via IRC in [#flyve-mdm on freenode](http://webchat.freenode.net/?channels=flyve-mdm) or [@flyvemdm on Telegram](https://t.me/flyvemdm).

## Professional Services

The Flyve MDM and GLPI Network services are available through our [Partner's Network](http://www.teclib-edition.com/en/partners/). We provide special training, bug fixes with editor subscription, contributions for new features, and more.

Obtain a personalized service experience, associated with benefits and opportunities.

## Copying

* **Name**: [Flyve MDM](https://flyve-mdm.com/) is a registered trademark of [Teclib'](http://www.teclib-edition.com/en/).
* **Code**: you can redistribute it and/or modify
    it under the terms of the GNU General Public License ([GPLv3](https://www.gnu.org/licenses/gpl-3.0.en.html)).
* **Documentation**: released under Attribution 4.0 International ([CC BY 4.0](https://creativecommons.org/licenses/by/4.0/)).
