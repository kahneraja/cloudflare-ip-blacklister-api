class CloudflareGateway

  def self.get_zones(key, email)
    url = "https://api.cloudflare.com/client/v4/zones"
    headers = auth_headers(key, email)
    puts headers
    response = HTTParty.get(url, headers: headers).response
    JSON.parse(response.body)
  end

  def self.get_rules(key, email, zone_id)
    puts key
    puts email
    puts zone_id
    url = "https://api.cloudflare.com/client/v4/zones/#{zone_id}/firewall/access_rules/rules?configuration.target=ip"
    headers = auth_headers(key, email)
    puts headers
    response = HTTParty.get(url, headers: headers).response
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
