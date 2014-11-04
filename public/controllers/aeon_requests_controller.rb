class AeonRequestsController < ApplicationController

  skip_before_filter :unauthorised_access
  before_filter :get_repository

  def archival_object
    archival_object = JSONModel(:archival_object).find(params[:id], repo_id: params[:repo_id])
    raise RecordNotFound.new if (!archival_object || archival_object.has_unpublished_ancestor || !archival_object.publish)

    location = fetch_location_for(archival_object)

    result = {
      archival_object: archival_object,
      location: location
    }

    render text: result.to_json
  end

  def resource
    resource = JSONModel(:resource).find(params[:id], repo_id: params[:repo_id])
    raise RecordNotFound.new if (!resource || !resource.publish)

    location = fetch_location_for(resource)

    result = {
      resource: resource,
      location: location
    }

    render text: result.to_json
  end

  private

  def get_repository
    @repository = @repositories.select{|repo| JSONModel(:repository).id_for(repo.uri).to_s === params[:repo_id]}.first
  end

  def fetch_location_for(record)
    location_id = record[:instances].first["container"]["container_locations"].first["ref"].split("/").last
    JSONModel(:location).find(location_id)
  end

end
