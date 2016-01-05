require 'pry'
require 'launchy'
require_relative './wine_scraper.rb'

class Som_cli

  attr_accessor :wine

  def initialize(wine)
    @wine = wine
  end


  def welcome
    puts ""
    puts "                        _________"
    puts "                       |         |"
    puts "                       %         %"
    puts "                        \\       /"
    puts "                         '.   .'"
    puts "                           \\ /"
    puts "                           ( )"
    puts "                            |"
    puts "                         ===^=== " #ascii art credit: hjw
    puts "Good evening and welcome to the Sommeligem."
    puts ""
  end

  def wine_list
    list = wine.scrape
    puts "For tonight's wine list we have:"

    list.each do |bottle|
      puts "#{bottle[:ranking]}. #{bottle[:name]} from #{bottle[:region]}"
    end

    #Launchy.open("details link")




  end



end


a = Som_cli.new(Wine.new)

a.wine_list
