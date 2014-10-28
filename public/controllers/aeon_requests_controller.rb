class AeonRequestsController < ApplicationController

  skip_before_filter :unauthorised_access
  before_filter :get_repository

  def archival_object
    archival_object = JSONModel(:archival_object).find(params[:id], :repo_id => params[:repo_id])
    raise RecordNotFound.new if (!archival_object || archival_object.has_unpublished_ancestor || !archival_object.publish)

    render text: archival_object.to_json
  end

  def resource
    resource = JSONModel(:resource).find(params[:id], :repo_id => params[:repo_id])
    raise RecordNotFound.new if (!resource || !resource.publish)

    render text: resource.to_json
  end

  private

  def get_repository
    @repository = @repositories.select{|repo| JSONModel(:repository).id_for(repo.uri).to_s === params[:repo_id]}.first
  end

end
