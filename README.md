# Nginx config files generator

Generate nginx config files according from a template and a simple conf and subdomains.
* Handle stage and prod servers, based on domain and port
    * stage run on port: 4000 + port
    * prod run on port: 3000 + port

Build to handle Meteor and Docker, but may be useful for other platforms

## Setup

Copy config.sample.yml to config.sample and fill it appropriately

## Start!

`bundle install`
`rake nginx:gerenate_all`

Your files are generated to "generated" folder

This tool can also:
* Generate the crontab for SSL renewing
* Convert CSV school list into importable JSON for mongo

Use 'rake -T' for a complete list
