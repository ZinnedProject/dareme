require 'spec_helper'

describe EventsController do
  login_user  

  describe "GET index" do
    
    it "assigns all events as @events" do
      event = FactoryGirl.create(:event)

      events = Event.all
      get :index, {}
      assigns(:events).should eq(events)
    end
  end

  describe "GET show" do
    
    it "assigns the requested event as @event" do
      event = FactoryGirl.create(:event)
      get :show, :slug => event.slug
      assigns(:event).should eq(event)
    end
  end

  describe "GET new" do
    
    it "assigns a new event as @event" do
      get :new, {}
      assigns(:event).should be_a_new(Event)
    end
  end

  describe "GET edit" do
    
    it "assigns the requested event as @event" do
      event = FactoryGirl.create(:event)
      get :edit, :id => event.id
      assigns(:event).should eq(event)
    end
  end

  describe "POST create" do
    
    describe "with valid params" do
      it "creates a new Event" do
        expect {
          event = FactoryGirl.create(:event)          
          post :create, :event => event.attributes
        }.to change(Event, :count).by(1)
      end

      it "assigns a newly created event as @event" do
        event = FactoryGirl.create(:event)          
        post :create, :event => event.attributes
        assigns(:event).should be_a(Event)
      end

    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved event as @event" do
        # Trigger the behavior that occurs when invalid params are submitted
        Event.any_instance.stub(:save).and_return(false)
        post :create, {:event => {}}
        assigns(:event).should be_a_new(Event)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Event.any_instance.stub(:save).and_return(false)
        post :create, {:event => {}}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
  
    describe "with valid params" do
      it "updates the requested event" do
        event = FactoryGirl.create(:event)          
        Event.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => event.to_param, :event => {'these' => 'params'}}
      end

      it "assigns the requested event as @event" do
        event = FactoryGirl.create(:event)          
        put :update, {:id => event.to_param, :event => event.attributes}
        assigns(:event).should eq(event)
      end

    end

    describe "with invalid params" do

      it "assigns the event as @event" do
        event = FactoryGirl.create(:event)          
        # Trigger the behavior that occurs when invalid params are submitted
        Event.any_instance.stub(:save).and_return(false)
        put :update, {:id => event.to_param, :event => {}}
        assigns(:event).should eq(event)
      end

      it "re-renders the 'edit' template" do
        event = FactoryGirl.create(:event)          
        # Trigger the behavior that occurs when invalid params are submitted
        Event.any_instance.stub(:save).and_return(false)
        put :update, {:id => event.to_param, :event => {}}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
  
    it "destroys the requested event" do
      event = FactoryGirl.create(:event)       
      expect {
        delete :destroy, {:id => event.id}
      }.to change(Event, :count).by(-1)
    end
  end

end
