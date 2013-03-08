class Phone < ActiveRecord::Base
  belongs_to :contact
  attr_accessible :phone, :phone_type

  validates :phone, uniqueness: { scope: :contact_id }
end
