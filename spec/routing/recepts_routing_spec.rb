require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ReceptsController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "recepts", :action => "index").should == "/recepts"
    end

    it "maps #new" do
      route_for(:controller => "recepts", :action => "new").should == "/recepts/new"
    end

    it "maps #show" do
      route_for(:controller => "recepts", :action => "show", :id => "1").should == "/recepts/1"
    end

    it "maps #edit" do
      route_for(:controller => "recepts", :action => "edit", :id => "1").should == "/recepts/1/edit"
    end

    it "maps #create" do
      route_for(:controller => "recepts", :action => "create").should == {:path => "/recepts", :method => :post}
    end

    it "maps #update" do
      route_for(:controller => "recepts", :action => "update", :id => "1").should == {:path =>"/recepts/1", :method => :put}
    end

    it "maps #destroy" do
      route_for(:controller => "recepts", :action => "destroy", :id => "1").should == {:path =>"/recepts/1", :method => :delete}
    end
  end

  describe "route recognition" do
    it "generates params for #index" do
      params_from(:get, "/recepts").should == {:controller => "recepts", :action => "index"}
    end

    it "generates params for #new" do
      params_from(:get, "/recepts/new").should == {:controller => "recepts", :action => "new"}
    end

    it "generates params for #create" do
      params_from(:post, "/recepts").should == {:controller => "recepts", :action => "create"}
    end

    it "generates params for #show" do
      params_from(:get, "/recepts/1").should == {:controller => "recepts", :action => "show", :id => "1"}
    end

    it "generates params for #edit" do
      params_from(:get, "/recepts/1/edit").should == {:controller => "recepts", :action => "edit", :id => "1"}
    end

    it "generates params for #update" do
      params_from(:put, "/recepts/1").should == {:controller => "recepts", :action => "update", :id => "1"}
    end

    it "generates params for #destroy" do
      params_from(:delete, "/recepts/1").should == {:controller => "recepts", :action => "destroy", :id => "1"}
    end
  end
end
