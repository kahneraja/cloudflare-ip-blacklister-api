require 'json'

class RulesController < ApplicationController

  def index
    email = request.headers['HTTP_EMAIL']
    key = request.headers['HTTP_KEY']
    zone_id = request.headers['HTTP_ZONE_ID']
    rules = CloudflareGateway.get_all_rules(key, email, zone_id)
    render json: rules
  end

  def create
    email = request.headers['HTTP_EMAIL']
    key = request.headers['HTTP_KEY']
    zone_id = request.headers['HTTP_ZONE_ID']
    body = params['rule'].to_json
    puts body
    response = CloudflareGateway.create_block_rule(key, email, zone_id, body)
    render json: response
  end

end
