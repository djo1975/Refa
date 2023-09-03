# chip.rb
class Chip < ApplicationRecord
    belongs_to :player
  
    validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  
    # Dodajte metode za dodavanje i oduzimanje čipova
    def add_chips(amount)
      self.amount += amount
      save
    end
  
    def remove_chips(amount)
      return false if self.amount < amount
  
      self.amount -= amount
      save
    end

    def refund_chips(amount)
      self.amount += amount
      save
    end
end
  