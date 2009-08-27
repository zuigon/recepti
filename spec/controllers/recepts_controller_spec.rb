require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ReceptsController do

  def mock_recept(stubs={})
    @mock_recept ||= mock_model(Recept, stubs)
  end

  describe "GET index" do
    it "assigns all recepts as @recepts" do
      Recept.stub!(:find).with(:all).and_return([mock_recept])
      get :index
      assigns[:recepts].should == [mock_recept]
    end
  end

  describe "GET show" do
    it "assigns the requested recept as @recept" do
      Recept.stub!(:find).with("37").and_return(mock_recept)
      get :show, :id => "37"
      assigns[:recept].should equal(mock_recept)
    end
  end

  describe "GET new" do
    it "assigns a new recept as @recept" do
      Recept.stub!(:new).and_return(mock_recept)
      get :new
      assigns[:recept].should equal(mock_recept)
    end
  end

  describe "GET edit" do
    it "assigns the requested recept as @recept" do
      Recept.stub!(:find).with("37").and_return(mock_recept)
      get :edit, :id => "37"
      assigns[:recept].should equal(mock_recept)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created recept as @recept" do
        Recept.stub!(:new).with({'these' => 'params'}).and_return(mock_recept(:save => true))
        post :create, :recept => {:these => 'params'}
        assigns[:recept].should equal(mock_recept)
      end

      it "redirects to the created recept" do
        Recept.stub!(:new).and_return(mock_recept(:save => true))
        post :create, :recept => {}
        response.should redirect_to(recept_url(mock_recept))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved recept as @recept" do
        Recept.stub!(:new).with({'these' => 'params'}).and_return(mock_recept(:save => false))
        post :create, :recept => {:these => 'params'}
        assigns[:recept].should equal(mock_recept)
      end

      it "re-renders the 'new' template" do
        Recept.stub!(:new).and_return(mock_recept(:save => false))
        post :create, :recept => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested recept" do
        Recept.should_receive(:find).with("37").and_return(mock_recept)
        mock_recept.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :recept => {:these => 'params'}
      end

      it "assigns the requested recept as @recept" do
        Recept.stub!(:find).and_return(mock_recept(:update_attributes => true))
        put :update, :id => "1"
        assigns[:recept].should equal(mock_recept)
      end

      it "redirects to the recept" do
        Recept.stub!(:find).and_return(mock_recept(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(recept_url(mock_recept))
      end
    end

    describe "with invalid params" do
      it "updates the requested recept" do
        Recept.should_receive(:find).with("37").and_return(mock_recept)
        mock_recept.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :recept => {:these => 'params'}
      end

      it "assigns the recept as @recept" do
        Recept.stub!(:find).and_return(mock_recept(:update_attributes => false))
        put :update, :id => "1"
        assigns[:recept].should equal(mock_recept)
      end

      it "re-renders the 'edit' template" do
        Recept.stub!(:find).and_return(mock_recept(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested recept" do
      Recept.should_receive(:find).with("37").and_return(mock_recept)
      mock_recept.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the recepts list" do
      Recept.stub!(:find).and_return(mock_recept(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(recepts_url)
    end
  end

end
