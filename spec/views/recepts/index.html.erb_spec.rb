require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/recepts/index.html.erb" do
  include ReceptsHelper

  before(:each) do
    assigns[:recepts] = [
      stub_model(Recept,
        :naziv => "value for naziv",
        :body => "value for body",
        :category_id => 1
      ),
      stub_model(Recept,
        :naziv => "value for naziv",
        :body => "value for body",
        :category_id => 1
      )
    ]
  end

  it "renders a list of recepts" do
    render
    response.should have_tag("tr>td", "value for naziv".to_s, 2)
    response.should have_tag("tr>td", "value for body".to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
  end
end
