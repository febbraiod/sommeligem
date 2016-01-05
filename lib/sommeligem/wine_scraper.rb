require 'nokogiri'
require 'open-uri'
require 'launchy'


class Wine

  WINE_URL = "http://www.wine.com/v6/winemarketinglist.aspx?N=490%201251&pagelength=100&s=100&cid=100"

  @@wines = []

  attr_accessor :wine_url


  def initialize(wine_url = WINE_URL)
    @wine_url = WINE_URL
  end


  def scrape

    html = Nokogiri::HTML(open(wine_url))
    doc = html.css(".detailsBlock")
    
    names_and_links = doc.css(".listProductName")
    prices = html.css(".priceBoxHeader")
    regions = doc.css(".productAbstract").css("span + span [href]")
    varietals = doc.css("div.productAbstract").css("span:first-child [href]")

    idx = 1
    names_and_links.each do |wine|
      wine_hash = {}
      wine_hash[:ranking] = idx
      wine_hash[:name] = wine.text
      wine_hash[:detail_link] = "wine.com" + wine.attribute("href").value
      @@wines << wine_hash
      idx += 1 #for ranking
    end

    idx2 = 0
    prices.each do |price|
      if price.css(".soldOutPrice").text != ""
        @@wines[idx2][:price] = price.css(".soldOutPrice").text
      elsif price.css(".salesPrice").text != ""
        @@wines[idx2][:price] = price.css(".salesPrice").text
      else
        @@wines[idx2][:price] = "We're sorry. Price not available for this wine. Please check the detail link for more information."
      end
      idx2 += 1
    end

    idx3 = 0
    regions.each do |region|
      @@wines[idx3][:region] = region.text
      idx3 += 1
    end
    
    idx4 = 0
    varietals.each do |grape|
      @@wines[idx4][:varietal] = grape.text.chomp("s")
      idx4 += 1
    end

    @@wines
  end


  def self.all
    @@wines
  end



end







