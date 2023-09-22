class CreateScrapedData < ActiveRecord::Migration[7.0]
  def change
    create_table :scraped_data do |t|

      t.timestamps
    end
  end
end
