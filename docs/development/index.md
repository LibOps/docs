# Developer Documentation

Here you will find all you need to know about developing and managing your site on LibOps.

## Initial setup

### LibOps CLI

If you haven't already, install the [libops CLI](https://github.com/LibOps/homebrew-cli) on your local machine.

The LibOps CLI has many useful commands to interact with your site. You can learn more about them by visiting [the docs for the CLI](./cli.md) or by running this command in your terminal:

```
libops --help
```

### Firewall Settings

Until your site goes live, all your LibOps environments are behind a firewall so only you and your team can access the sites.

Ensure the public IPv4 address of the machine(s) you're working from is in the `ssh-firewall` and `https-firewall` lists in [libops.yml](./libops-yml.md). If the IP address you're visiting the site is not configured in libops.yml, you will not be able to access your site.

If you do not know your public IP you can run this command in your terminal:

```
curl ifconfig.me
```

### SFTP Connection

Ensure your gcloud email and **public** SSH key(s) (i.e. `~/.ssh/id_rsa.pub`) are added to `developers` in [libops.yml](./libops-yml.md)

The email being set in libops.yml is required to run LibOps CLI commands. Please ensure the email you set here is the same as the one you setup your LibOps CLI with.

The public SSH keys are required to SFTP to your environment and/or run interactive drush commands.

## Environments

By default, your LibOps site has a development and production environment.

You can make code changes in development, then deploy them to production once they're ready.

If you have several features you're developing at any given time, you may want to have separate branches off of development to do so. Each branch you create off of the development branch automatically creates its own new environment.

GitHub branches equate to individual environments on LibOps. The exception to this is your production environment. Production code is pushed using GitHub releases/tags.

### Branch Naming Rules

Branch names must follow [the docker tag naming convention](https://docs.docker.com/engine/reference/commandline/tag/). i.e.

> The tag must be valid ASCII and can contain lowercase and uppercase letters, digits, underscores, periods, and hyphens. It cannot start with a period or hyphen and must be no longer than 128 characters.

### URLs

Your GitHub repository will have the URLs for your development and production environments in the README.

When you create a new environment, this will create another URL to access the given environment. Once you create a branch in GitHub, you can get the URL to your environment by running

```
libops -e BRANCH_NAME get info | jq -r .drupal.url
```

Opening a PR will automatically add a comment to the PR with the URL to the environment, too.

### Lifecycle

Once you're done developing a feature on a given branch, you can merge the branch into the main development branch. Then you can follow [the normal deployment process](#deployment).

Deleting the branch will delete the environment, including all files and the database in that environment.

## Making code changes

Any commit pushed to GitHub will automatically deploy to the respective environment. Typically from the time the commit was received by GitHub until it's deployed and running in the environment takes around 2-3 minutes.

While only using git to make code changes is certainly supported, often it's easier to use SFTP to quickly iterate on a new feature in a LibOps environment. To do so, you will want to configure your IDE.

### Configure your IDE for SFTP

To help you quickly iterate on new features for your site, you can use an SFTP plugin in your IDE to automatically upload code changes from your local machine to any non-production LibOps environment.

First, you'll need to configure you local machine to connect to your environment. The `libops` CLI has an easy utility to configure your `~/.ssh/config` for LibOps. To do so, you can run the command

```
cd path/to/your/libops/site
libops config-ssh -e development
```

This will populate your `~/.ssh/config` so any SSH client can establish a connection to your LibOps development environment at the hostname `development.YOUR-LIBOPS-ID.site`.

An example SFTP config for VSCode for your development environment is already configured in your site's GitHub repository. If you're using VSCode, and followed the instructions above, you should now be able to make edits on your LibOps development environment. Other SFTP Plugins can be configured similarly. The values needed to connect are

```
user: coder
host: development.YOUR-LIBOPS-ID.site
port: 2222
path: /code
```

### Commit changes

After you're done making edits over SFTP, from your local machine you can `git commit && git push` your changes to the `development` branch, or create a new branch/PR then merge.

## Deployment

To deploy your development branch to production, you can publish a new release in your GitHub repository.

After the new release is published a GitHub Action will deploy your code into production.
