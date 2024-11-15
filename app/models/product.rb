class Product < ApplicationRecord
  # Associations
  has_many :line_items

  # Callbacks
  before_destroy :ensure_not_referenced_by_any_line_item

  # Validations
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :image_url, presence: true, allow_blank: false, format: {
    with: %r{\.(gif|jpg|png)\z}i,
    message: 'must be a URL for GIF, JPG, or PNG image.'
  }
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }

  # Custom method to check if the product is affordable
  def affordable?
    price < 20.00
  end

  # Custom method to format the price
  def formatted_price
    "$#{'%.2f' % price}"
  end

  private

  # Ensure that the product is not referenced by any line item before destruction
  def ensure_not_referenced_by_any_line_item
    unless line_items.empty?
      errors.add(:base, 'Line Items present')
      throw :abort
    end
  end
end
