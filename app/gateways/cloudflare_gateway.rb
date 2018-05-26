class CloudflareGateway

  def self.get_zones(key, email)
    url = "https://api.cloudflare.com/client/v4/zones"
    headers = auth_headers(key, email)
    response = HTTParty.get(url, headers: headers).response
    JSON.parse(response.body)
  end

  def self.get_all_rules(key, email, zone_id)
    page = 1
    response = get_rules(key, email, zone_id, page)
    page = response['result_info']['page'].to_i
    total_pages = response['result_info']['total_pages'].to_i
    data = response['result']
    while (page < total_pages)
      page += 1
      page_response = get_rules(key, email, zone_id, page)
      page_data = page_response['result']
      data.concat page_data
    end
    data
  end

  def self.get_rules(key, email, zone_id, page=1)
    url = "https://api.cloudflare.com/client/v4/zones/#{zone_id}/firewall/access_rules/rules?configuration.target=ip&page=#{page}"
    puts url
    headers = auth_headers(key, email)
    response = HTTParty.get(url, headers: headers).response
    JSON.parse(response.body)
  end

  def self.create_block_rule(key, email, zone_id, body)
    url = "https://api.cloudflare.com/client/v4/zones/#{zone_id}/firewall/access_rules/rules"
    headers = auth_headers(key, email)
    response = HTTParty.post(url, body: body, headers: headers).response
    JSON.parse(response.body)
  end

  def self.delete_rule(key, email, zone_id, rule_id)
    url = "https://api.cloudflare.com/client/v4/zones/#{zone_id}/firewall/access_rules/rules/#{rule_id}"
    headers = auth_headers(key, email)
    response = HTTParty.delete(url, headers: headers).response
    JSON.parse(response.body)
  end

  # private

  def self.auth_headers(key, email)
    {
      'Content-Type' => 'application/json',
      'X-Auth-Email' => email,
      'X-Auth-Key' => key
    }
  end

end
