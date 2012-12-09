class CreatePackets < ActiveRecord::Migration
  def change
    create_table :packets do |t|

    	t.column :date, :datetime
    	t.column :from, :string
    	t.column :to, :string
    	t.column :kind, :string
    	t.column :raw, :string
    	
    	t.column :lat, :double
    	t.column :lon, :double
    	
    	t.column :destination, :string
    	t.column :comment, :string
    	t.column :symbol_table, :string
    	t.column :symbol, :string
    	
    	t.column :power, :string
    	t.column :height, :string
    	t.column :gain, :string

    	t.column :temperature, :string
    	t.column :wind_dir, :string
    	t.column :wind_speed, :string
    	t.column :humidity, :string
    	t.column :rain_1hr, :string
    	t.column :rain_12hr, :string

    	t.column :path, :string
    	t.column :telemetry, :string

        t.column :object_name, :string


      t.timestamps
    end
  end
end
