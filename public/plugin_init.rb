my_routes = [File.join(File.dirname(__FILE__), "routes.rb")]
ArchivesSpacePublic::Application.config.paths['config/routes'].concat(my_routes)

module ApplicationHelper

  # record should be a resource or archival object
  # returns true if the record or any of its ancestors has an associated
  # location, otherwise false
  def display_aeon_request_links_for(record)
    any_locations_in_ancestry_for(record)
  end

  private

  # crawls the record and its ancestry checking for at least one location
  def any_locations_in_ancestry_for(record)
    records = ancestry_for(record).reverse

    records.each do |record|
      return true if any_locations_for(record)
    end

    false
  end

  # returns the ancestry chain of the record
  def ancestry_for(record)
    case record["jsonmodel_type"]
    when "archival_object"
      archival_object = ArchivalObjectView.new(record)
      tree_view       = Search.tree_view(archival_object.uri)

      breadcrumbs = []

      tree_view["path_to_root"].each do |node|
        raise RecordNotFound.new if not node["publish"] == true

        if node["node_type"] == "resource"
          r = JSONModel(:resource).find(node["id"], repo_id: params[:repo_id])
          breadcrumbs << r
        elsif node["node_type"] == "archival_object"
          ao = JSONModel(:archival_object).find(node["id"], repo_id: params[:repo_id])
          breadcrumbs << ao
        end
      end

      breadcrumbs << record
    when "resource"
      [record]
    end
  end

  # checks for the presence of a location for the record
  def any_locations_for(record)
    record["instances"].each do |instance|
      next unless instance["container"].present?
      next unless instance["container"]["container_locations"].present?

      instance["container"]["container_locations"].each do |container_location|
        next unless container_location["ref"].present?

        return true
      end
    end

    false
  end

end
