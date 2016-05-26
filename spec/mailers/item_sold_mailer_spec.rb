require "rails_helper"
require "spec_helper"

describe ItemSoldMailer do
  context "an item is sold" do
    let (:seller) { double "seller", id: 3, email: "hey@you.com" }
    let (:purchaser) { double "purchaser", id: 3, email: "areyouthere@email.com" }
    let (:purchase) { double "purchase", id: 3, purchaser: purchaser, purchaser_id: purchaser.id, item_id: item.id }
    let (:item) { double "item", id: 3, seller: seller, name: "phone", description: "smart", price: 3, seller_id: seller.id }
    let (:presenter) { NewPurchasePresenter.new(purchase, item) }
    let(:mail) { described_class.notify_seller(purchase, item).deliver_now }

    it "it has a subject" do

      expect(mail.subject).to eq("Item Sold")
    end

    it "it is sent to the item's seller email" do

      expect(mail.to).to eq(["hey@you.com"])
    end

    it "it is sent from the ebay_clone default email" do

      expect(mail.from).to eq(["ebaycloneacjg@gmail.com"])
    end

    it "the body of the email contains the email of the buyer" do

      expect(mail.body).to include(purchase.purchaser.email)
    end

    it "the body of the email contains the item details" do

      expect(mail.body).to include(item.name)
      expect(mail.body).to include(item.price)
    end
  end
end

