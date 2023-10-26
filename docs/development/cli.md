# LibOps CLI

The [LibOps CLI](https://github.com/LibOps/homebrew-cli) is a useful utility to interact with your LibOps site.

## Basic overview

The LibOps CLI should also be ran from the root of your GitHub repository. This is so the CLI can know the name of your site automatically without having to pass it in with the `--site` flag.

After installing, you can see the list of commands by running `libops --help`

```
$ libops --help
Interact with your libops site

Usage:
  libops [command]

Available Commands:
  backup      Backup your libops environment
  completion  Generate the autocompletion script for the specified shell
  config-ssh  Populate ~/.ssh/config with LibOps development environment
  drush       Run drush commands on your libops environment
  get         Display information about your LibOps environment.
  help        Help about any command
  import      Import resources to your LibOps environment.
  sequelace   Connect to your LibOps database using Sequel Ace (Mac OS only)
  sync-db     Transfer the database from one environment to another
```

## Default environment
By default, any command you run with `libops` will be against your development environment. This can be changed by passed the `-e` or `--environment` flag. e.g.

```
libops backup -e production
```

## Commands

### sequelace

On Mac OS with[Sequel Ace](https://sequel-ace.com/) installed, running `libops sequelace` will open a connection to your LibOps site's database. You could connect to production similarly via

```
libops sequelace -e production
```

![Example sequelace command](/assets/img/sequelace.gif)

### get config

Running `libops get config` will run `drush cex` on your environment, download the contents of the config export, and save that content into your local checked out copy. So you can export your config from production and push the config with something like

```
cd /path/to/your/libops/site
libops get config -e production
git add --all config
git commit -m "drush cex"
git push origin development
```

### import db

Running `libops import db` can get a SQL file on your local machine imported into a LibOps environment. For example, to import a SQL file called "drupal.sql" from your local machine to development you can run:

```
libops import db --file drupal.sql
```

### sync-db

Running `libops sync-db` can get the database from one environment into another. For example, to import the production database into development you can run:

```
libops sync-db --source production --target development
```
