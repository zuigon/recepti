require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Recept do
  before(:each) do
    @valid_attributes = {
      :naziv => "value for naziv",
      :body => "value for body",
      :category_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Recept.create!(@valid_attributes)
  end
end
