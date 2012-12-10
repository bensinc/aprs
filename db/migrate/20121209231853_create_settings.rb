class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
    	t.column :key, :string
    	t.column :value, :string
      t.timestamps
    end
  end
end
