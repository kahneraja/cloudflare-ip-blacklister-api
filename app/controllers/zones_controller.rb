class ZonesController < ApplicationController

  def index
    email = request.headers['HTTP_EMAIL']
    key = request.headers['HTTP_KEY']
    response = CloudflareGateway.get_zones(key, email)
    render json: response['result']
  end


end
