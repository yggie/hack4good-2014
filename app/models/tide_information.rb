require 'net/http'
require 'json'

class TideInformation
  CLIENT_ID = 'p8zMYHwotokeODV3jkDl1'
  CLIENT_SECRET = '7GUcdw467apEh24tTnFCAQScODUrt8mri38M0AQu'

  attr_accessor :lat, :lon, :time

  def initialize (lat, lon, time)
    @lat = lat
    @lon = lon
    @time = time
  end

  def get_data
    uri = URI.parse("http://api.aerisapi.com/tides/closest")#?p=#{@lat},#{@lon}&from=#{@time}&client_id=#{CLIENT_ID}&client_secret=#{CLIENT_SECRET}")
    params = { p: "#{@lat},#{@lon}", client_id: self.class::CLIENT_ID,
      client_secret: self.class::CLIENT_SECRET, from: @time
    }
    uri.query = URI.encode_www_form(params)
    req = Net::HTTP::Get.new(uri.to_s)
    res = Net::HTTP.start(uri.host, uri.port) do |http| 
      http.request(req)
    end
    parse(res.body)
  end

  def parse(data)
    json = JSON.parse(data)
    return nil if json["success"] == false || !json["error"].nil?
    puts json
    return

    sum = json["response"].inject(0) { |acc, entry| acc += entry }
    sum / json["response"].count
  end
end
#
# info = TideInformation.new(25.7783, -80.185, 1410627840)
#
# info.get_data
