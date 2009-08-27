class Category < ActiveRecord::Base
  belongs_to :recept
  validates_presence_of :name
  validates_length_of :name, :within => 2..30
  validates_uniqueness_of :name, :on => :create, :message => "već postoji"

end
