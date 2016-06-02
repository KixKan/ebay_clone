require 'rails_helper'
require 'item_marketplace/presenters/item_presenter'

describe ItemPresenter do

  let(:bid) { double 'bid' }
  let(:item) { double 'item', id: 2, name: "table", description: "pong", buy_it_now_price: 11, starting_bid_price: 1, highest_bid: 7 }
  let(:presenter) { ItemPresenter.new(item, bid) }

  it "returns a new item" do

    expect(presenter.item).to eq(item)
  end

   it "returns the error" do
    allow(bid).to receive_message_chain(:errors, :full_messages) { "That's a no-no!" }

    expect(presenter.errors).to eq("That's a no-no!")
  end

   it "returns the item id" do

    expect(presenter.id).to eq(item.id)
   end
   it "returns the item name" do

     expect(presenter.name).to eq(item.name.capitalize)
   end

   it "returns the item description" do

    expect(presenter.description).to eq(item.description)
   end

   it "returns the item buy_it_now_price" do

    expect(presenter.buy_it_now_price).to eq(item.buy_it_now_price)
   end

   it "returns the item starting_bid_price" do

    expect(presenter.starting_bid_price).to eq(item.starting_bid_price)
   end

   it "returns the item highest_bid" do

    expect(presenter.highest_bid).to eq(item.highest_bid)
   end

   it "parses the countdown to the auction" do
     allow_any_instance_of(ItemPresenter).to receive(:duration).and_return(359926)

     expect(presenter.days).to  eq(4)
     expect(presenter.hours).to eq(3)
     expect(presenter.minutes).to eq(58)
     expect(presenter.seconds).to eq(46)
   end

end
