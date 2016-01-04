require 'pry'
require 'nokogiri'
require 'open-uri'


class Wine

  WINE_URL = "http://2015.top100.winespectator.com/lists/"

  attr_accessor :wine_url

  def initialize(wine_url = WINE_URL) #not sure if this is the correct thing to do, but I want to preserve the option of changing the year by changing the 2015 in the URL.
    @wine_url = WINE_URL
  end

  def scrape

    html = Nokogiri::HTML(open(wine_url))
    binding.pry

    

  end


end

Wine.new.scrape