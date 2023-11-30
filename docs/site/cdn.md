# Google Cloud CDN

All production LibOps sites are behind a fully managed [Google Cloud CDN](https://cloud.google.com/cdn).

> Google's Cloud CDN scale to bring content closer to a global audience. Cloud CDN accelerate web and video content delivery by using Google's global edge network to bring content as close to your users as possible. Latency, cost, and load on your backend servers is reduced, making it easy to scale to millions of users.

Your site content stays fresh thanks to [the Drupal purge module](https://www.drupal.org/project/purge) and a custom purge invalidator that's automatically deployed for your production site. This functionality updates the cache when you update your content.

This feature increases site uptime ([Google's SLA is 99.95%](https://cloud.google.com/cdn/sla)) and reduces latency for your site visitors.
