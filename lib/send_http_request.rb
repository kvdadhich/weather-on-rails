class SendHttpRequest
  BASE_URL = 'http://api.openweathermap.org/data/2.5'
	def initialize(url, request_type, data, headers = {})
		@url = url
		@request_type = request_type
		@data = data
		@headers = headers
	end

	def http_process
		url_initialization
		http_initialization
		request_initialization
		send_request
	end

	def url_initialization
		@uri = URI.parse(BASE_URL+@url)
	end

	def http_initialization
		@http = Net::HTTP.new(@uri.host, @uri.port)
  end

  def request_initialization
    @uri.query = URI.encode_www_form(@data)
		@request = Net::HTTP::Get.new(@uri, @headers)
  end

	def send_request
		@res = @http.request(@request).body
    puts"====response====#{@res}======="
    @res = JSON.parse(@res) rescue @res
	end

end