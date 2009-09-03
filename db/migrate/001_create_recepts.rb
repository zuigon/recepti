class CreateRecepts < ActiveRecord::Migration
  def self.up
    create_table :recepts do |t|
      t.string  :naziv
      t.text    :body

      t.timestamps
    end
  end

  def self.down
    drop_table :recepts
  end
end
