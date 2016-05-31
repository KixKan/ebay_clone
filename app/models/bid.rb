class Bid < ActiveRecord::Base
  validates :item_id, :bidder_id, :amount, presence: true
  validate :verify_amount, :verify_availability
  belongs_to :bidder, class_name: "User", foreign_key: :bidder_id
  belongs_to :item

  def verify_amount
    if amount < Item.find(item_id).current_bid
      errors.add(:amount, "Please bid higher than the current bid")
    end
  end

  def verify_availability
    if !Item.find(item_id).available
      errors.add(:unavailable_item, "The item is no longer available")
    end
  end
end
