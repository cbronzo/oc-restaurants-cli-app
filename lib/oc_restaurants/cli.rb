#CLI Controller

class OCRestaurants::CLI
  attr_accessor :name

  def initailize(name)
    @name = name
  end

  def start
    puts "Welcome to 'Orange County's 21 Hottest Restaurants' Guide! "
    OCRestaurants::Scraper.new.scrape_restaurants
    menu
  end


  def menu
    puts "Type 'guide' to see the list of OC Restaurants."
    puts "Otherwise, type 'exit'."
    input = gets.strip
      if input == "guide"
        list_restaurant_name
      elsif input == "exit"
        puts "You are now exiting the program. Thank you, goodbye!"
        exit
      else
        error
        menu
      end
  end


  def list_restaurant_name
    puts "YUM! Here are 21 of the OC's best & hottest restaurants! Dig in!"
    puts "Please select a restaurant by entering its number (1-21) to learn more!"
    puts "To exit, type 'exit'."
    OCRestaurants::Best_Restaurant.all.with_index(1) do |restaurant, index|
      puts "#{index}. #{restaurant.name}"
    end
    input = gets.strip
      if input.to_i.between?(1,21)

        index = input.to_i - 1
        restaurant_attributes(index)
      elsif input == "exit"
        puts "You are now exiting the program. Thank you, goodbye!"
        exit
      else
        error
        list_restaurant_name
      end
  end


  def restaurant_attributes(index)
    restaurant_info = OCRestaurants::Best_Restaurant.all[index]
    puts "Below, you will find the details for #{restaurant_info.name}."
    puts "Description: #{restaurant_info.description}"

        if restaurant_info.address == ""
          puts "Address: Sorry, no address available."
        else
          puts "Address: #{restaurant_info.address}"
        end

        if restaurant_info.phone == ""
          puts "Phone: Sorry, no phone number available."
        else
          puts "Phone Number: #{restaurant_info.phone}"
        end

        if restaurant_info.website == ""
          puts "Website: Sorry, no website available."
        else
          puts "Website: #{restaurant_info.website}"
        end

      puts "To select another restaurant, please enter its number, or enter 'back' to go back to the guide."
      puts "To exit, type 'exit'."
      input = gets.strip
        if input == "back"
          list_restaurant_name
        elsif input.to_i.between?(1,21)
          index = input.to_i - 1
          restaurant_attributes(index)
        elsif input == "exit"
          exit
        else
          error
          restaurant_attributes(index)
        end
    end


  def error
    puts "~ERROR, PLEASE TRY AGAIN~"
  end

end
