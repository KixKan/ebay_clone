require 'rails_helper'

describe PurchasesController do

  let (:seller) { User.create(username: "bagel", email: "bringitback", password: "plaincreamcheese") }
  let (:item) { Item.create(name: "gloves", description: "they fit", price: 89, seller_id: seller.id) }
  let (:purchaser) { User.create(username: "oatmeal", email: "brownsugar@melt.com", password: "noquinoa") }

  before(:each) do
    session[:user_id] = purchaser.id
  end

  context "purchase successful" do
    it "response successful" do
      post :create, :item_id => item.id, :purchase => {purchaser_id: purchaser.id, item_id: item.id}

      expect(response).to have_http_status(:redirect)
      expect(response.content_type).to eq("text/html")
    end

    it "redirects to the purchase confirmation page" do
      post :create, :item_id => item.id, :purchase => {purchaser_id: purchaser.id, item_id: item.id}

      expect(response).to redirect_to(action: "show", item_id: item.id, id: Purchase.last.id)
    end

    it "send a confirmation email to seller" do

      expect{ post :create, :item_id => item.id, :purchase => { purchaser_id: purchaser.id, item_id: item.id } }.to change{Sidekiq::Worker.jobs.size }.by(1)
    end

    it "sets the item to unavailable" do
      post :create, :item_id => item.id, :purchase => {purchaser_id: purchaser.id, item_id: item.id}

      expect(Item.find(item.id).available).to eq(false)
    end
  end

  xcontext "purchase invalid because it lacks buyer purchaser_id" do
    it "renders purchase form page" do
      post :create, :item_id => item.id, :purchase => { item_id: item.id }

      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq("text/html")
      expect(response).to render_template(:new)
    end
  end

  xcontext "purchase invalid because item is not available" do
    it "does not increase the purchase count if an item is unavaiable" do
      post :create, :item_id => item.id, :purchase => {purchaser_id: purchaser.id, item_id: item.id}
      purchase_count = Purchase.all.count
      post :create, :item_id => item.id, :purchase => {purchaser_id: purchaser.id, item_id: item.id}

      expect(Purchase.all.count).to eq(purchase_count)
    end

    it "renders the new purchase form" do
      post :create, :item_id => item.id, :purchase => {purchaser_id: purchaser.id, item_id: item.id}
      post :create, :item_id => item.id, :purchase => {purchaser_id: purchaser.id, item_id: item.id}

      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq("text/html")
      expect(response).to render_template(:new)
    end
  end
end
