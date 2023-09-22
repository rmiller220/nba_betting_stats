require 'nokogiri'
require 'csv'
require 'watir'

class ScraperService
  def self.scrape_and_save_data
    browser = Watir::Browser.new(:chrome)

    browser.goto "https://www.espn.com/nba/stats/player"

    loop do
      player_links = browser.links(class: "AnchorLink")
      player_links.each do |player_link|
        player_name = player_link.text
        player_link.click

        element = browser.button(text: "See All")
        element.wait_until(&:present?).click

        page_content = Nokogiri::HTML(browser.html)
        player_stats = page_content.css("table.Table.Table--align-right.Table--fixed.Table--fixed-left").css("tbody").css("tr.Table__TR.Table__TR--sm.Table__even").css("td.Table__TD").map(&:text)
        # player_stats = page_content.css('.Tablestyles__Scroller-x8t60w-2').text

        csv_path = Rails.root.join('public', 'csv', 'player_stats.csv')
        CSV.open(csv_path, "a") do |csv|
          csv << [player_name, player_stats]
        end

        browser.back
      end

      show_more_button = browser.button(text: "Show More")
      break unless show_more_button.exists?
      show_more_button.click

    end
    browser.close
  end
end