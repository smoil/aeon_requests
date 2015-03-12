Add AEON request links to ArchivesSpace
=====================================

**NOTE: This plugin is currently under active development and is not yet complete.**

This plugin extends ArchivesSpace by adding links on record pages which redirect to an AEON request form, populating request data.

[ArchivesSpace](http://www.archivesspace.org/) is the next-generation open source archives information management application designed by archivists for describing, managing, and providing access to archives, manuscripts, and digital objects.

[AEON](http://www.atlas-sys.com/aeon/) is an online request system designed for special collections and archives.

## Installation

- Copy or clone this repository to a folder under the plugins directory. I would suggest naming the folder `aeon_requests`.

- Edit config.rb to:
  - activate the `aeon_requests` plugin
  - specify the AEON endpoint
  - optionally provide repository name translations (default will be used if no translation found)

For example, in config.rb:

```ruby
# (required) You may have other plugins
AppConfig[:plugins] = ['local', 'aeon_requests']
# (required) The URL of the AEON endpoint
AppConfig[:aeon_request_endpoint] = 'https://aeon.myinstitution.edu'
# (optional) Translations for repository codes, and a default code to use
AppConfig[:aeon_request_repository_mappings] = {
  'Special Collections' => 'specol',
  'Cinema/TV'           => 'cinema',
  'Gov Docs'            => 'gov_docs'
}
# (required if translations are used) Use this value if no translations found
AppConfig[:aeon_request_repository_mappings_default] = 'specol'
```

- Start, or restart ArchivesSpace to pick up the configuration.

## How it maps

For records (resources or archival objects) that have no child records, a link to request the record will be added to the top of the record navigation menu.

This link will redirect to the AEON request page passing the following mapped values:

AEON attribute  | Description
--------------- | -------------
Title           | The records title concatenated with the titles of records in its ancestry in order from root to leaf.
Site            | The respository code associated to the record. If the `aeon_request_repository_mappings` option has been set in the application configuration, the code will be translated according to the mapping. Note that the `'default'` mapping will be used if no matching mapping is found.
Location        | This is a concatenation of the title and container details for locations associated with the record in hierarchical order.
ItemVolume      | The container details for the record.
Callnum         | The id_0 attribute for the record.
