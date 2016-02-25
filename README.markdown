#### Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup](#setup)
    * [What druid affects](#what-druid-affects)
    * [Setup requirements](#setup-requirements)
4. [Usage](#usage)
5. [Limitations.](#limitations)
6. [Development](#development)

## Overview

Puppet module to manage Druid based on the Imply.io stack. This module manage all the Druid daemons and Bard.

## Module Description

This module will deploy the Imply.io tarball (See: http://imply.io/download) and will give you the possibility to start the different Druid services, including Bard (Bundle for Pivot, Plywood, and
PlyQL).

More information about the Imply.io bundle here: http://imply.io.

## Setup

### What druid affects

Files managed by this module:

* Deploy the imply tarball using Archive: https://forge.puppetlabs.com/nanliu/archive
* Modify configuration in: /opt/imply/conf (default)
* Manage all Druid and Bard services: /etc/init.d/druid-*

If asked, the module will also deploy Java and Nodejs.

### Setup Requirements


## Usage

Deploy the tarball and the common configuration:

```
class { 'druid':
  imply_version => '1.1.0'
}
```

If you also want to install Java :

```
class { 'druid':
  install_java => true,
}
```

By default, the package 'openjdk-8-jdk' from the PPA ppa:openjdk-r/ppa' will be deployed. You can override this configuration.


Configure a Master node:

```
class { 'druid': }
class { 'druid::coordinator': }
class { 'druid::overlord': }
```

Configure a Data node:

```
class { 'druid': }
class { 'druid::middle_manager': }
class { 'druid::historical': }
```

Configure a Query node:

```
class { 'druid': }
class { 'druid::broker': }
class { 'druid::bard': }
```

By default the class `druid::bard` will deploy Nodejs. If you want to manage Nodejs from another class, you can disable it :

```
class { 'druid::bard':
  install_nodejs => false,
}
```

## Limitations

This module has only been tested with Ubuntu 14.04 and Puppet 3.8.x

## Development

See CONTRIBUTING.md
