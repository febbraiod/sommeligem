require 'pry'
require 'launchy'
require_relative './wine_scraper.rb'

class Som_cli

  attr_accessor :wine, :list

  def initialize(wine)
    @wine = wine
    @list = wine.scrape
    self.add_foods
  end

  def add_foods
    food_pairs = {"Cabernet Sauvignon" => "red meats, especially short ribs and rare steaks, and dishes with mushroom sauces. It also goes well with strong cheese and lamb",
      "Other Red Blend" => "roasted white meats, hamburger, veal, or risotto",
      "Chardonnay" => "fatty fish or lean fish in a rich sauce, lobster, sushi rolls with mayo, ripe fruit and hard cheeses",
      "Non-Vintage Sparkling Wine" => "salty foods, oysters, chinese food, smoked fish and lean fish",
      "Sauvignon Blanc" => "lean fish, nigiri sushi, lobster, fresh fruits and veggies or light cheeses",
      "Malbec" => "steak, roast beef or venison, barbecued lamb, beef or pork with smokey, chili-based rubs. Also goes nicely with Chili con Carne",     
      "Pinot Noir" => "glazed ham, pork tenderloin, roasted vegatables, poutry and fowl, duck, rabbit, and dishes with light flavorful sauces",
      "Tempranillo" => "cured ham, tapas, rabbit, Lasagna, Pizza and dishes with tomato-based sauces, tacos, nachos, mole sauces",
      "Bordeaux Red Blend" => "braised lamb, mussels, quiche, beef stew and smoked duck",
      "Pinot Gris/Grigio" => "fatty fish, tuna, salmon, shellfish, lobster, light chicken dishes, fresh veggies, pasta with light sauces or olive oil and fresh herbs, as well as mild Asian dishes",
      "Rhone Red Blend" => "pizza, pork belly, sausages, charcuterrie, stir fry, and pork chops",
      "Sangiovese" => "lasagna, pizza, tomatos, tomato sauce, any acidic Italian dish",
      "RosÃ" => "artisinal grilled cheese sandwiches, aparagus, cheese souflet, goat cheese, lobster, roasted beets and summer salads",
      "Syrah/Shiraz" => "lamb chops, sausages, steak, spicy chicken dishes, paella, barbecued meats, and venison",
      "Zinfandel" => "Indian food especially curries, chocolate, duck, chili, pork, hard cheese, bacon, and spicy BBQ",
      "Chenin Blanc" => "sweet and sour chicken or pork, most Chinese foods, soft cheeses, smoked fish, fowl and fresh veggies",
      "Grenache" => "skirt steak, charcuterrie, stuffed mushrooms, young hard cheese, dark chocolate, stews, braises and ratatouille",
      "Muscat" => "blue cheese, melon with prosciutto, fresh fruit, dried fruit, desserts",
      "Other White Blend" => "mild to strong cheese, chicken, seafood, fresh veggies",
      "Petite Sirah" => "roasted or grill beef and pork, lamb, barbeque, hard and strong cheeses, Mexican food",
      "Riesling" => "risotto, grilled fish, nigiri sushi, spicy dishes, Mexican, Indian, Chinese foods",
      "Vintage Sparkling Wine" => "salty foods, oysters, chinese food, smoked fish, and lean fish"}

     
      list.each do |wine|
        wine[:pairing] = food_pairs[wine[:varietal]]
      end

    list  
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

  def wine_list #should only happen at request

    puts ""
    puts "You like to see the wine list?"
    response = gets.chomp.downcase

      if response == "yes" || response == "y"
        puts "For tonight's wine list we have:"
        sleep(1)

        list.each do |bottle|
          puts "#{bottle[:ranking]}. #{bottle[:name]} from #{bottle[:region]}"
          sleep(1/8.to_f)
        end
      end
  
  end

  def interface

    puts ""
    puts "How may I assist you? If you are unfamiliar with Sommeligem, please ask for 'help'."

    guest_choice = gets.chomp
      if guest_choice.downcase == 'help'
        puts ""
        sleep(1.to_f)
        puts "You may ask to see the wine list by typing 'list'."
        sleep(3/2.to_f)
        puts "You may choose a number 1-100 for more details on the corresponding wine of your choice."
        sleep(3/2.to_f)
        puts "Or if you'd like, I could suggest wines from our list to pair with your meal by typing 'pairing'."
        sleep(2.to_f)
        puts "If you no longer need my assistance you may type 'exit.'"
        puts ""
        sleep(3/4.to_f)
        interface
      elsif (1..100).include?(guest_choice.to_i)
        if details(guest_choice) == exit
          puts "Have a good evening!"
          return
        end
      elsif guest_choice.downcase == 'list'
        wine_list
        interface
      elsif guest_choice.downcase == 'pairing'
        if pairing_food_to_wine == "exit"
          puts "Have a nice night!"
          return
        end
        puts "For more information on any of these wines please enter the wine number."
        wine_num = gets.chomp
        if wine_num == "exit"
          puts "Have a nice night!"
          return
        end
        details(wine_num)
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
    puts "This wine will pair well with #{list[wine][:pairing]}."

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
      elsif response.downcase == "exit"
        puts "Good Evening."
        return
      else
        puts "Im sorry I do not understand your request, please try again"
        response = gets.chomp
      end
    end

  end

=begin
  I wonder if this should be done with a Food class, 
  where foods belong to wines and vice versa, 
  but I'm not sure how I'd get all this info assigned properly. 
  Ask at assessment.
=end

  def pairing_food_to_wine
    food_to_wine = 
      {"beef" => ["Cabernet Sauvignon", "Other Red Blend", "Malbec", "Bordeaux Red Blend", "Syrah/Shiraz", "Grenache", "Petite Sirah"],
      "chicken" => ["Pinot Gris/Grigio", "Syrah/Shiraz", "Chenin Blanc", "Other Red Blend", "Other White Blend"],
      "pork" => ["Malbec", "Pinot Noir", "Zinfandel", "Petite Sirah", "Other Red Blend", "Tempranillo"],
      "veggies" => ["Pinot Noir", "Other White Blend", "Pinot Gris/Grigio", "Chenin Blanc", "Sauvignon Blanc", "RosÃ"],
      "fruit" => ["Chardonnay", "Sauvignon Blanc", "Muscat"],
      "bbq" => ["Zinfandel", "Malbec", "Syrah/Shiraz", "Petite Sirah"],
      "mexican" => ["Petite Sirah", "Riesling", "Syrah/Shiraz", "Tempranillo"],
      "indian" => ["Riesling", "Zinfandel"],
      "chinese" => ["Non-Vintage Sparkling Wine", "Chenin Blanc", "Riesling", "Vintage Sparkling Wine"],
      "roasted" =>  ["Other Red Blend", "Malbec", "RosÃ", "Petite Sirah", "Sangiovese"],
      "hard cheese" => ["Chardonnay", "Zinfandel", "Grenache", "Petite Sirah", "Rhone Red Blend"],
      "soft cheese" => ["Chenin Blanc", "Rhone Red Blend", "Grenache"],
      "dessert" => ["Muscat", "Zinfandel", "Grenache"],
      "sweets" => ["Muscat", "Zinfandel", "Grenache"],
      "italian" => ["Sangiovese", "Other Red Blend"],
      "pizza" => ["Tempranillo", "Rhone Red Blend", "Sangiovese"],
      "fatty fish" => ["Chardonnay", "Pinot Gris/Grigio"],
      "lean fish" => ["Sauvignon Blanc", "Non-Vintage Sparkling Wine", "Vintage Sparkling Wine", "Riesling"],
      "sushi rolls" => ["Chardonnay"],
      "nigiri sushi" => ["Sauvignon Blanc", "Riesling"],
      "lamb" => ["Malbec", "Bordeaux Red Blend", "Syrah/Shiraz", "Petite Sirah"],
      "duck" => ["Pinot Noir", "Zinfandel", "Bordeaux Red Blend"],
      "fowl" => ["Pinot Noir", "Chenin Blanc"],
      "venison" => ["Malbec", "Syrah/Shiraz"],
      "lobster" => ["Vintage Sparkling Wine", "Non-Vintage Sparkling Wine", "Chardonnay", "Sauvignon Blanc", "Pinot Gris/Grigio", "RosÃ", "Bordeaux Red Blend"],
      "shellfish" => ["Vintage Sparkling Wine", "Non-Vintage Sparkling Wine", "Chardonnay", "Sauvignon Blanc", "Pinot Gris/Grigio", "RosÃ", "Bordeaux Red Blend"],
      "spicy" => ["Syrah/Shiraz", "Zinfandel", "Riesling"],
      "salty" => ["Non-Vintage Sparkling Wine", "Vintage Sparkling Wine"]
      }

    while true
      puts "What are you considering for dinner? For a list of foods and flavors I can pair please enter 'foods'" # use in CLI not in hash(lobster, shellfish ect)
     
      input = gets.chomp.downcase
      if input == "foods"
        food_to_wine.each do |food, wine|
          puts food
        end
      elsif input == "exit"
        return "exit"
      elsif food_to_wine.has_key?(input)
        list.each do |bottle|
          if food_to_wine[input].include?(bottle[:varietal]) && input != "sushi"
            puts "#{bottle[:ranking]}. #{bottle[:name]} from #{bottle[:region]}"
            sleep(1/8.to_f)
          end
        end
        break  
      else
        puts "I'm sorry I'm not familar with that dish."
      end
    end

  end

   




end

