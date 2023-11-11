# Redis

![Redis logo](../assets/img/redis.png)

Your LibOps site is automatically configured to use a Redis server for Drupal cache and queues thanks to [the Drupal redis module](https://drupal.org/project/redis).

You can disable using redis for cache by removing the redis settings from your sites git repository at `assets/sites/default/libops.settings.php`. If you do this, you should also disable the redis module from your site.
