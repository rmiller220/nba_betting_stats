# require 'nokogiri'
# require 'csv'
# require 'watir'

# class ScraperService
#   def self.scrape_and_save_data
#     browser = Watir::Browser.new(:chrome)

#     browser.goto "https://www.nba.com/stats/players/boxscores"

#     loop do
#       player_links = browser.links(class: "AnchorLink")
#       player_links.each do |player_link|
#         player_name = player_link.text
#         player_link.click

#         element = browser.button(text: "See All")
#         element.wait_until(&:present?).click

#         page_content = Nokogiri::HTML(browser.html)
#         player_stats = page_content.css("table.Table.Table--align-right.Table--fixed.Table--fixed-left").css("tbody").css("tr.Table__TR.Table__TR--sm.Table__even").css("td.Table__TD").map(&:text)
#         # player_stats = page_content.css('.Tablestyles__Scroller-x8t60w-2').text

#         csv_path = Rails.root.join('public', 'csv', 'player_stats.csv')
#         CSV.open(csv_path, "a") do |csv|
#           csv << [player_name, player_stats]
#         end

#         browser.back
#       end

#       show_more_button = browser.button(text: "Show More")
#       break unless show_more_button.exists?
#       show_more_button.click

#     end
#     browser.close
#   end
# end

# class ScraperService
#   def self.scrape_and_save_data
#     browser = Watir::Browser.new(:chrome)

#     # browser.goto "https://www.espn.com/nba/stats/player"
#     browser.goto "https://www.nba.com/stats/players/boxscores"

#     loop do
#       player_links = browser.links(class: "AnchorLink")

#       player_links.each do |player_link|
#         player_name = player_link.text
#         player_link.wait_until(&:present?)
#         player_link.wait_until(&:visible?)
#         player_link.wait_until(&:enabled?)
#         player_link.click

#         # player_link.wait_until(&:present?).wait_until(&:enabled?).click
#         # player_link.click
#         puts "Found player link: #{player_name}"

#         # Wait for the player's individual page to load
#         browser.wait_until { browser.url.include?("player/gamelog/_/id/") }

#         # Find and click the "See All" link on the player's individual page
#         see_all_link = browser.link(class: "AnchorLink Card__Header__SubLink")
#         see_all_link.wait_until(&:present?).click

#         # Wait for the expanded section to load
#         expanded_section = browser.div(class: "your-expanded-section-class")
#         expanded_section.wait_until(&:present?)

#         # Extract player statistics from the expanded section
#         player_stats = expanded_section.table(class: "your-table-class").text

#         # Save player data to CSV or process it as needed
#         csv_path = Rails.root.join('public', 'csv', 'player_stats.csv')
#         CSV.open(csv_path, "a") do |csv|
#           csv << [player_name, player_stats]
#         end

#         # Return to the main player list page
#         browser.back
#       end

#       show_more_button = browser.button(text: "Show More")
#       break unless show_more_button.exists?
#       show_more_button.click
#     end

#     browser.close
#   end
# end

# app/services/nba_stats_scraper_service.rb

# require 'nokogiri'
# require 'csv'
# require 'watir'

# class ScraperService
#   # def initialize
#   # end
  
#   def self.scrape_and_save_data
#     browser = Watir::Browser.new
#     # Navigate to the NBA stats page
#     browser.goto('https://www.nba.com/stats/players/boxscores')

#     # Click the dropdown menu and select "All"
#     sleep(15)
#     close_button = browser.button(aria_label: 'Close')
#     close_button.click if close_button.present?
#     sleep(15)

#     select_element = browser.select(class: 'DropDown_select__4pIg9')
#     select_element.wait_until(&:present?)

#     select_element.select_list('-1')

#     # Wait for the page to load (you may need to adjust the wait time)
#     sleep(15)

#     # Get the HTML source of the page
#     page_source = browser.html

#     # Parse the HTML source with Nokogiri
#     doc = Nokogiri::HTML(page_source)

#     # Initialize an array to store the table headers (categories)
#     categories = []

#     # Find the table headers row
#     headers_row = doc.css('tr.Crom_headers__mzI_m')[0]

#     # Extract table headers (categories)
#     headers_row.css('th').each do |header|
#       categories << header.text.strip
#     end

#     # Define the CSV file path (you may need to adjust the path)
#     csv_file_path = "#{Rails.root}/public/nba_stats_data.csv"

#     # Write data to the CSV file
#     CSV.open(csv_file_path, 'w') do |csv|
#       # Write the categories as the header row
#       csv << categories

#       # Find all table rows containing data
#       data_rows = doc.css('table').first.css('tr').drop(1)

#       # Iterate through data rows
#       data_rows.each do |row|
#         # Extract data from each cell in the row
#         row_data = row.css('td').map(&:text)

#         # Write each row of data to the CSV file
#         csv << row_data
#       end
#     end

#     # Close the browser
#     @browser.close

#     csv_file_path # Return the path to the saved CSV file
#   end
# end
require 'nokogiri'
require 'csv'
require 'watir'

class ScraperService
  def self.scrape_and_save_data
    # Create a new Watir browser instance
    # browser = Watir::Browser.new
    # retry_attempts = 3 # Number of retry attempts
    # retry_delay = 5 # Delay between retries (in seconds)

    # Retry loop
    # retry_attempts.times do |attempt|
    #   begin
         # Set the Watir default timeout (adjust as needed)
         Watir.default_timeout = 60

        # Create a new Watir browser instance with an increased timeout
        browser = Watir::Browser.new
    # Navigate to the NBA stats page
    browser.goto('https://www.nba.com/stats/players/boxscores')
    
    sleep(20) # You might need to adjust this sleep time
    if
     browser.button(aria_label: 'Decline Offer; close the dialog').present?
      browser.button(aria_label: 'Decline Offer; close the dialog').click
      sleep(10) # You might need to adjust this sleep time
    end
      # You can add a sleep here to give the action time to complete if needed
      # You can add a sleep here to give the action time to complete if needed
      
      if
     browser.button(aria_label: 'No Thanks; close the dialog').present?
      browser.button(aria_label: 'No Thanks; close the dialog').click
      sleep(10) # You might need to adjust this sleep time
      end
      
      close_button = browser.button(aria_label: 'Close')
      close_button.click if close_button.present?
      sleep(30) # You might need to adjust this sleep time
      if
     browser.button(aria_label: 'No Thanks; close the dialog').present?
      browser.button(aria_label: 'No Thanks; close the dialog').click
      sleep(5) # You might need to adjust this sleep time
      end
    # Click the "Decline Offer" button
    dropdown_section = browser.section(class: 'Block_block__62M07 nba-stats-content-block')
    
    # Find the dropdown element within the section
    dropdown_element = dropdown_section.select_list(css: '.DropDown_select__4pIg9')
    dropdown_element.wait_until(&:present?)
    
    # Select the option with value "-1" (All)
    dropdown_element.select('-1')
    sleep(180)
    if browser.button(aria_label: 'Decline Offer; close the dialog').present?
      browser.button(aria_label: 'Decline Offer; close the dialog').click
      sleep(10) # You might need to adjust this sleep time
      # You can add a sleep here to give the action time to complete if needed
    end
    if browser.button(aria_label: 'No Thanks; close the dialog').present?
      browser.button(aria_label: 'No Thanks; close the dialog').click
      sleep(10) # You might need to adjust this sleep time
      # You can add a sleep here to give the action time to complete if needed
    end
    sleep(30) # You might need to adjust this sleep time
    # Get the HTML source of the page
    page_source = browser.html
    require 'pry'; binding.pry
    # Parse the HTML source with Nokogiri
    doc = Nokogiri::HTML(page_source)

    # Initialize an array to store the table headers (categories)
    categories = []

    # Find the table headers row
    headers_row = doc.css('tr.Crom_headers__mzI_m').first

    # Extract table headers (categories)
    headers_row.css('th').each do |header|
      categories << header.text.strip
    end

    # Define the CSV file path (you may need to adjust the path)
    csv_file_path = "#{Rails.root}/public/nba_stats_data.csv"

    # Write data to the CSV file
    CSV.open(csv_file_path, 'w') do |csv|
      # Write the categories as the header row
      csv << categories

      # Find all table rows containing data
      data_rows = doc.css('table').first.css('tr').drop(1)

      # Iterate through data rows
      data_rows.each do |row|
        # Extract data from each cell in the row
        row_data = row.css('td').map(&:text)

        # Write each row of data to the CSV file
        csv << row_data
      end
    end

    # Close the browser
    browser.close
    csv_file_path # Return the path to the saved CSV file
    # break # Exit the loop if successful
    #   rescue Net::ReadTimeout
    #     puts "Retry attempt #{attempt + 1} due to timeout..."
    #     sleep(retry_delay)
    #   ensure
    # # Ensure the browser is closed even if there's an exception
    # browser&.close
    end
  end
# end
# end
