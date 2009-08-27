class Recept < ActiveRecord::Base

  acts_as_textiled :body

  has_one :category, :class_name => "Category", :foreign_key => "category_id"
  validates_presence_of :naziv, :on => :create, :message => "Ne smije ostati prazan"
  validates_length_of :body, :within => 10..1024, :on => :create, :message => "Ne smije ostati prazan"

  attr_accessor :new_category_name

  before_save :create_category_from_name

  def create_category_from_name
    create_category(:name => new_category_name) unless new_category_name.empty?
  end

end
