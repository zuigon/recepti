class CategoriesRecepts < ActiveRecord::Migration
  def self.up
    create_table :categories_recepts, :id => false do |t|
      t.references :category, :recept
      t.timestamps
    end    
  end

  def self.down
    drop_table :categories_recepts
  end
end
