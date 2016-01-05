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
    sleep(1)

    list.each do |bottle|
      puts "#{bottle[:ranking]}. #{bottle[:name]} from #{bottle[:region]}"
      sleep(1/8.to_f)
    end
  end

  def interface
    puts ""
    puts "How many I assist you? If you are unfamilar with Sommeligem, please enter 'help'."
    
    guest_choice = gets.chomp
      if guest_choice.downcase == 'help'
        puts ""
        sleep(1.to_f)
        puts "You may choose a number 1-100 for more details on the wine of your choice."
        sleep(3/2.to_f)
        puts "You may also repeat this list by typing 'list'."
        sleep(3/2.to_f)
        puts "Or if you'd like, I could suggest wines from our list to pair with your meal this evening by typing 'pairing'."
        sleep(2.to_f)
        puts "If you no longer need my assitance you may type 'exit.'"
        puts ""
        sleep(3/4.to_f)
        interface
      elsif (1..100).include?(guest_choice.to_i)
        #write details method and call it here
      elsif guest_choice.downcase == 'list'
        self.wine_list
        interface
      elsif guest_choice.downcase == 'pairing'
        #write pairing method and call it here
      elsif guest_choice.downcase == 'exit'
        puts "Please come again!"
        return 
      else
        puts "Im sorry I do not understand you request, please try again"
        interface
      end
  end

    #Launchy.open("details link")




  end



end


a = Som_cli.new(Wine.new)

a.wine_list
a.interface
