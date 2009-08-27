require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/recepts/show.html.erb" do
  include ReceptsHelper
  before(:each) do
    assigns[:recept] = @recept = stub_model(Recept,
      :naziv => "value for naziv",
      :body => "value for body",
      :category_id => 1
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ naziv/)
    response.should have_text(/value\ for\ body/)
    response.should have_text(/1/)
  end
end
