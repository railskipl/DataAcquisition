class HomeController < ApplicationController
  require 'nokogiri'
  require 'open-uri'
  include HomeHelper
    
  def index
    page_num = params[:page].present? ? params[:page] : 1
    get_otc_company_press_releases(page_num)
    render :status =>200,:json => Hash[ "data" => @company_press_release ]
  end

  def otc_press_release
    market_id = params[:id]
    get_otc_press_release(market_id)
    render :status =>200,:json => Hash[ "press_release" => @data.css(".newsDetail").to_s ]
  end

  def otc_markets_profile
  	market = params[:market].present? ? params[:market] : "TXHD"
    get_otc_markets_profile(market)

    if @data.at_css("h3").present?
      company_name = @data.css('#xcompanyInfo').at_css('h3').text if @data.css('#xcompanyInfo').at_css('h3').present?
      market = @data.css(".compInfo").at_css("span").text.strip if @data.css(".compInfo").at_css("span").present?

      render :status =>200,:json => Hash[ "symbol" => @data.at_css("h3").text.strip, "name" => company_name, "market" => market, "market_value" => @data.css(".table-small").css("tr")[0].css("td")[2].text, "authorized_shares" => @data.css(".table-small").css("tr")[1].css("td")[2].text, "outstanding_shares" =>@data.css(".table-small").css("tr")[2].css("td")[2].text, "outstanding_shares_restricted" => @data.css(".table-small").css("tr")[3].css("td")[2].text, "outstanding_shares_unrestricted" => @data.css(".table-small").css("tr")[4].css("td")[2].text, "held_at_dtc" => @data.css(".table-small").css("tr")[5].css("td")[2].text, "float" => @data.css(".table-small").css("tr")[6].css("td")[2].text, "par_value" => @data.css(".table-small").css("tr")[7].css("td")[2].text.strip ]
    end
  end

end
