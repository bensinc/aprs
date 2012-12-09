class UpdatePackets < ActiveRecord::Migration
  def up
  	add_column :packets, :course, :integer
  	add_column :packets, :speed, :integer
  	add_column :packets, :altitude, :integer
  end

  def down
  end
end
