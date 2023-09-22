namespace :scrape do
  desc 'Scrape player stats from ESPN'
  task :players_stats => :environment do
    ScraperService.scrape_and_save_data
  end
end
