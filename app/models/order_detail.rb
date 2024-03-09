class OrderDetail < ApplicationRecord
  enum making_status: { not_possible: 0, waiting_production: 1, in_production: 2, production_completed: 3 }

  belongs_to :order
  belongs_to :item
end
