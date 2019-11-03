class WeatherService
  
  def by_city(city, url)
    params = { APPID: ENV['OWM_APP_ID'], units: "imperial", q: city}
    SendHttpRequest.new(url, 'GET', params).http_process
  end


  def by_lat_long(lat, long, url)
    params = { APPID: ENV['OWM_APP_ID'], units: "imperial", lat: lat, lon: long}
    res = SendHttpRequest.new(url, 'GET', params).http_process
    {name: res["name"], temp: res["main"]["temp"]}
  end

  def forecast_report(lat, long, url)
    params = { APPID: ENV['OWM_APP_ID'], units: "imperial", lat: lat, lon: long}
    parse_response(SendHttpRequest.new(url, 'GET', params).http_process["list"])
  end

  def parse_response(lists)
    lists.reject! { |h| h["dt_txt"].include? Date.today().to_s }
    res = []
    (1..5).each do |i|
      day_list = lists.select { |h| h["dt_txt"].include? (Date.today()+i.days).to_s }
      res.push({day: (Date.today()+i.days).strftime("%A"), avg_temp: get_avg_temp(day_list)})
    end
    return res
  end
  
  def get_avg_temp(lists)
    i = 0
    total_temp = 0
    lists.each do |list|
      total_temp += list["main"]["temp"]
      i+=1
    end
    return total_temp/i
  end
end
