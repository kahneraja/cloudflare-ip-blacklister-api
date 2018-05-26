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
    response = CloudflareGateway.create_block_rule(key, email, zone_id, body)
    render json: response
  end

  def destroy
    email = request.headers['HTTP_EMAIL']
    key = request.headers['HTTP_KEY']
    zone_id = request.headers['HTTP_ZONE_ID']
    rule_id = params['id']
    response = CloudflareGateway.delete_rule(key, email, zone_id, rule_id)
    render json: response
  end

end
