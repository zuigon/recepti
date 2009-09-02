class CategoriesRecept < ActiveRecord::Base

  belongs_to :category
  belongs_to :recept

end
