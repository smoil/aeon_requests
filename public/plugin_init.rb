my_routes = [File.join(File.dirname(__FILE__), "routes.rb")]
ArchivesSpacePublic::Application.config.paths['config/routes'].concat(my_routes)

module ApplicationHelper

  # record should be a resource or archival object
  # returns true if the record or any of its ancestors has an associated
  # location, otherwise false
  def display_aeon_request_links_for(record)
    record.present? && !record_has_children?(record)
  end

  private

  # record should be a resource or archival object
  # returns true if a record has children, otherwise false
  def record_has_children?(record)
    Search.tree_view(record.uri)["self"]["has_children"]
  end

end
