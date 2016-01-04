require 'pry'
require 'nokogiri'
require 'open-uri'


class Wine

  WINE_URL = "http://www.wine.com/v6/winemarketinglist.aspx?N=490%201251&pagelength=100&s=100&cid=100"

  attr_accessor :wine_url

  def initialize(wine_rul = WINE_URL)
    @wine_url = WINE_URL
  end

  def scrape

    html = Nokogiri::HTML(open(wine_url))
    doc = html.css(".detailsBlock")
    
    names = doc.css(".listProductName")

    names.each do |i|
     i.attribute("href").value
     i.text
     binding.pry

    end



  end


end

Wine.new.scrape

=begin
[{:rank => 2, :name => "Black Box", :varietal => "Red Blend" 
  :details => {:price => $5, :rating => 80, :vinatage => 2014}},{}]
=end

#ranks = having trouble with this, however I might not need to scapre this.  it's really just 1-100 based on the "name"
#names = doc.css(".listProductName")   #text   #pull this into an array and rank based on order.
#varietals = doc.css(".productAbstract").css("[href]")  #text
#description => link
#description = doc.css(".listProductName").attribute("href").value





