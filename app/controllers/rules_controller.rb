class RulesController < ApplicationController

  def index
    email = request.headers['HTTP_EMAIL']
    key = request.headers['HTTP_KEY']
    zone_id = request.headers['HTTP_ZONE_ID']
    response = CloudflareGateway.get_rules(key, email, zone_id)
    render json: response['result']
  end


end
