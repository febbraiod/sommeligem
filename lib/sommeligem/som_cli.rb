require 'pry'
require 'launchy'
require_relative './wine_scraper.rb'

class Som_cli

  attr_accessor :wine, :list

  def initialize(wine)
    @wine = wine
    @list = wine.scrape
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
    puts "For tonight's wine list we have:"
    sleep(1)


    list.each do |bottle|
      puts "#{bottle[:ranking]}. #{bottle[:name]} from #{bottle[:region]}"
      sleep(1/8.to_f)
    end
  end

  def interface
    puts ""
    puts "How may I assist you? If you are unfamiliar with Sommeligem, please ask for 'help'."
    
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
        details(guest_choice)
      elsif guest_choice.downcase == 'list'
        wine_list
        interface
      elsif guest_choice.downcase == 'pairing'
        #write pairing method and call it here
      elsif guest_choice.downcase == 'exit'
        puts "Please come again!"
        return 
      else
        puts "Im sorry I do not understand your request, please try again"
        interface
      end
  end

  def details(user_input)
    wine = user_input.to_i - 1
    puts "A very fine selection, the #{list[wine][:name]}"
    puts "The #{list[wine][:name]} is a #{list[wine][:varietal]} from #{list[wine][:region]}"
    puts "It will pair well with #insert pairing method here"

    if list[wine][:price] == "Price not available"
      puts "I'm sorry to inform you that the price on the #{list[wine][:name]} is not available. Please check the details link for more information."
    else
      puts "The cost of this bottle will be #{list[wine][:price]}"
    end

    puts "Would you like more information?"

    response = gets.chomp

    while true
      if response.downcase == "yes" || response.downcase == "y"
        Launchy.open("#{list[wine][:detail_link]}")
        interface
        break
      elsif response.downcase == "no" || response.downcase == "n"
        interface
        break
      else
        puts "Im sorry I do not understand your request, please try again"
        response = gets.chomp
      end
    end

  end

  def pairings 

=begin
  I wonder if this should be done with a Food class, 
  where foods belong to wines and vice versa, 
  but i'm not sure how I'd get all this info assigned properly. 
  Ask at assestment
=end

=begin      
      wine to food => 
      {Cabernet Sauvignon => Red meats, especially short ribs and rare steaks. Mushroom sauces. Also goes with strong cheese and lamb.
      Other Red Blend => Roasted white meats, Hamburger, veal, risotto
      Chardonnay => fatty fish or fish in a rich sauce, lobster, ripe fruit, hard cheeses, sushi rolls, with mayo
      Non-Vintage Sparkling Wine => salty foods, oysters, chinese food, smoked fish, and lean fish
      Sauvignon Blanc => lean fish, nigiri sushi, lobster fresh fruit, light cheese
      Malbec => Steak, Roast beef or venison, Barbecued lamb, beef or pork with smokey, chilli-based rubs, Chili con Carne     
      Pinot Noir => Glazed ham, pork tenderloin, roasted vegatables, poutry and fowl, duck, rabbit, and dishes with light flavorful sauses.
      Tempranillo => Cured ham, tapas, rabbit, Lasagna, Pizza and dishes with tomato-based sauces, tacos, nachos, mole sauces
      Bordeaux Red Blend => braised lamb, mussels, quiche, beef stew and smoked duck
      Pinot Gris/Grigio => fatty fish, tuna, salmon, shellfish, lobster, light chicken dishes, pasta with light sauces or olive oil and fresh herbs, mild Asian dishes
      Rhone Red Blend = pizza, pork belly, sausages, charcuterrie, stir fry, and pork chops
      Sangiovese =>  Lasagna, Pizza, Tomatos, Tomato sauce, any acidic italian dishes
      RosÃ => grilled cheese, aparagus, cheese souflet, goat cheese, lobster, roasted beets, summer salads
      Syrah/Shiraz => Lamb chops, sausages, steak, spicy chicken dishes, paella, barbecued meats, and venison
      Zinfandel => Indian food, chocolate, duck, chili, curry pork, hard cheese, bacon, and spicy BBQ
      Chenin Blanc => Sweet and Sour chicken or pork(chinese), soft cheeses, smoked fish, and fowl
      Grenache => skrit steak, charcuterrie, Stuffed Mushrooms, young hard cheese, dark chocolate, stews, braises and ratatouille
      Muscat => blue cheese, Melon and prosciutto, fresh fruit, dried fruit, desserts
      Other White Blend => mild to strong cheese, poultry, seafood
      Petite Sirah => Roasted or Grill Beef and Pork, Lamb, Barbeque, hard and strong cheeses, mexican food
      Riesling => risotto, grilled fish, nigiri sushi, spicy dishes, mexican, indian, chinese
      Vintage Sparkling Wine => salty foods, oysters, chinese food, smoked fish, and lean fish}

      food to wine => 
      { Beef => [Cabernet Sauvignon, Other Red Blend, Malbec, Bordeaux Red Blend, Syrah/Shiraz, Grenache, Petite Sirah]
        Chicken => [Pinot Gris/Grigio, Syrah/Shiraz, Chenin Blanc, Other Red Blend]
        Pork => [Malbec, Pinot Noir, Zinfandel, Petite Sirah, Other Red Blend, Tempranillo]
        Veggies
        Fruit
        BBQ
        Mexican
        Indian
        Chinese
        Roasted
        Hard cheese
        Soft Cheese
        dessert
        Italian => Are you having pizza?
        fatty fish
        lean fish
        sushi => rolls or nigiri?
        risotto
        lamb
        duck
        poultry
        fowl
        venison
        other seafood
        spicy
        salty
        sweet
      }

=end
  end

   




end


a = Som_cli.new(Wine.new)

a.welcome
a.wine_list
a.interface
