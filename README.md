Add AEON request links to ArchivesSpace
=====================================

**NOTE: This plugin is currently under active development and is not yet complete.**

This plugin extends ArchivesSpace by adding links on record pages which redirect to an AEON request form, populating request data.

[ArchivesSpace](http://www.archivesspace.org/) is the next-generation open source archives information management application designed by archivists for describing, managing, and providing access to archives, manuscripts, and digital objects.

[AEON](http://www.atlas-sys.com/aeon/) is an online request system designed for special collections and archives.

**To use with ArchivesSpace you must:**

- Copy or clone this repository to a folder under the plugins directory. I would suggest naming the folder `aeon_requests`.

- Edit config.rb to:
  - activate the `aeon_requests` plugin
  - specify the AEON endpoint

For example, in config.rb:

```
# You may have other plugins
AppConfig[:plugins] = ['local', 'aeon_requests']
AppConfig[:aeon_request_endpoint] = 'https://aeon.myinstitution.edu'
```

- Start, or restart ArchivesSpace to pick up the configuration.

