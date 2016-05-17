class ItemSoldMailer < ActionMailer::Base
  default from: "ebaycloneacjg@gmail.com"

  def notify_seller(item, purchase)
    mail(to: item.email, subject: "Item Sold")
  end
end

