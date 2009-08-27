require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/recepts/edit.html.erb" do
  include ReceptsHelper

  before(:each) do
    assigns[:recept] = @recept = stub_model(Recept,
      :new_record? => false,
      :naziv => "value for naziv",
      :body => "value for body",
      :category_id => 1
    )
  end

  it "renders the edit recept form" do
    render

    response.should have_tag("form[action=#{recept_path(@recept)}][method=post]") do
      with_tag('input#recept_naziv[name=?]', "recept[naziv]")
      with_tag('textarea#recept_body[name=?]', "recept[body]")
      with_tag('input#recept_category_id[name=?]', "recept[category_id]")
    end
  end
end
