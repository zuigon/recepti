class Category < ActiveRecord::Base
  belongs_to :recept
  validates_presence_of :name
  validates_length_of :name, :within => 2..30

  # def self.to_list
  #   to_list = ""
  #   to_list += "<ul>\n"
  #   find(:all).each { |category| to_list += "<li>" + category.name +  }
  #   
  #   to_list += 
  # end

end
