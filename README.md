Add AEON request links to ArchivesSpace
=====================================

**NOTE: This plugin is currently under active development and is not yet complete**

[ArchivesSpace](http://www.archivesspace.org/) is the next-generation open source archives information management application designed by archivists for describing, managing, and providing access to archives, manuscripts, and digital objects.

**To use with ArchivesSpace you must:**

- Copy or clone this repository to a folder under the plugins directory. I would suggest naming the folder `aeon_requests`.

- Edit config.rb to:
  - activate the `aeon_requests` plugin

For example, in config.rb:

```
# You may have other plugins
AppConfig[:plugins] = ['local', 'aeon_requests']
```

- Start, or restart ArchivesSpace to pick up the configuration.
  When viewing archival objects from the public facing site, you should see **Request via AEON** links for non-digital instance objects.
