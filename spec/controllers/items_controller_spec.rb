require 'rails_helper'

describe ItemsController do

  context "request for home page" do
    it "response is successful" do
      get :index

      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq("text/html")
    end

    it "renders the index template" do
      get :index

      expect(response).to render_template(:index)
    end
  end

  context "request for new item" do
    it "response is successful" do
      get :new

      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq("text/html")
    end

    it "renders the new template" do
      get :new

      expect(response).to render_template(:new)
    end
  end

  context "new item is created successfully" do
    before(:each) do
      user =  User.create(username: "dreamteam", email: "us@dream.com", password_hash: "zzzzzzz")
      session[:user_id] = user.id
    end

    it "response is successful" do
      post :create, :item => {name: "a", description: "A", price: 1, user_id: User.last.id}

      expect(response).to have_http_status(:redirect)
      expect(response.content_type).to eq("text/html")
    end

    it "redirects to items index" do
      post :create, :item => {name: "a", description: "some description", price: 1, user_id: User.last.id}

      expect(response).to redirect_to items_path
    end

    it "adds the item to the database" do
      post :create, :item => {name: "ping-pong paddle", description: "you beat Alex with it", price: 1, user_id: User.last.id}

      expect(Item.first.name).to eq("ping-pong paddle")
      expect(Item.count).to eq(1)
    end
  end

  context "new item is invalid and not created" do
    before(:each) do
      user =  User.create(username: "dreamteam", email: "us@dream.com", password_hash: "zzzzzzz")
      session[:user_id] = user.id
    end

    it "response is successful" do
      post :create, :item => {name: "", description: "some description", price: 1, user_id: User.last.id}

      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq("text/html")
    end

    it "renders the new template" do
      post :create, :item => {name: "", description: "A", price: 1, user_id: User.last.id}

      expect(response).to render_template(:new)
    end

    it "does not save the item to the database" do
      post :create, :item => {name: "", description: "A", price: 1, user_id: User.last.id}

      expect(Item.count).to eq(0)
    end
  end

  context "no current_user" do
    before(:each) do
      user =  User.create(username: "dreamteam", email: "us@dream.com", password_hash: "zzzzzzz")
    end

    it "renders new template" do
      post :create, :item => {name: "", description: "A", price: 1, user_id: User.last.id}

      expect(response).to render_template("sessions/new")
    end

    it "flashes a notice" do
      post :create, :item => {name: "", description: "A", price: 1, user_id: User.last.id}

      expect(flash[:notice]).to eq("You need to be logged in to add an item")
    end
  end
end
