module LocalRepository
  class LocalItem

    attr_reader :name, :description, :price, :email, :image

    def initialize(item_details)
      @name = item_details[:name]
      @description = item_details[:description]
      @price = item_details[:price]
      @email = item_details[:email]
      @image = item_details[:image]
    end
  end
end
