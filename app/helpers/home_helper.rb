module HomeHelper

	def get_otc_company_press_releases(page_num)
		url = "http://www.otcmarkets.com/news/otc-market-headlines?page=#{page_num}&pageSize=50"
	    data = Nokogiri::XML(open(url))
	    values = Array.new
	    data.css("tr").each_with_index do |news, index|
	      if index > 0
	        values.push("id" => news.css('td')[3].to_s.match(/id=(\d+)/)[1], "release_date" => news.css("td")[0].text, "symbol" => news.css("td")[1].text,"source"=>news.css("td")[2].text,"title"=>news.css("td")[3].text,"url"=>news.css('td')[3].at('a').first[1])
	      end
	    end
	    @company_press_release = values
	end

	def get_otc_press_release(id)
		url = "http://www.otcmarkets.com/news/otc-market-headline?id=#{id}"
    	@data = Nokogiri::XML(open(url))
	end

	def get_otc_markets_profile(market)
		url = "http://www.otcmarkets.com/stock/#{market}/profile"
    	@data = Nokogiri::XML(open(url))
	end

end
