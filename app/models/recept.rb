class Recept < ActiveRecord::Base

  acts_as_textiled :body

  # has_one :category, :class_name => "Category", :foreign_key => "category_id"

  has_many :categories_recepts
  has_many :category, :through => :categories_recepts
  
  # has_and_belongs_to_many :category, :join_table => "categories_recepts"


  validates_presence_of :naziv, :on => :create, :message => "ne smije ostati prazan"
  validates_length_of :body, :within => 10..10240, :on => :create, :message => "ne smije ostati prazan"

  attr_accessor :new_category_name

  before_save :create_category_from_name

  def create_category_from_name
    if not new_category_name.to_s.empty?
      # Category.create!(:name => new_category_name)
      # c = Category.create(:name => new_category_name)
      self.category << Category.create(:name => new_category_name)
      self.save
      # new_category_id = Category.find(:all, :conditions => [ "name = ?", new_category_name ], :select => "id")[0].id
      # self.category_id = new_category_id
    end
  end

end
