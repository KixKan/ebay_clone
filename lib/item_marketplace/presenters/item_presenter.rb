class ItemPresenter
  attr_reader :item

  def initialize(item, bid = nil)
    @item = item
    @bid = bid
  end

  def errors
    if @bid
      @bid.errors.full_messages
    end
  end

  def id
    @item.id
  end

  def name
    @item.name.capitalize
  end

  def description
    @item.description
  end

  def buy_it_now_price
    @item.buy_it_now_price
  end

  def starting_bid_price
    @item.starting_bid_price
  end

  def highest_bid
    @item.highest_bid
  end
end
