# == Schema Information
#
# Table name: residents
#
#  id                   :bigint           not null, primary key
#  active               :boolean          default(TRUE), not null
#  balance_is_dirty     :boolean          default(TRUE), not null
#  bill_costs           :integer          default(0), not null
#  bills_count          :integer          default(0), not null
#  birthday             :date             default(Mon, 01 Jan 1900), not null
#  can_cook             :boolean          default(TRUE), not null
#  email                :string
#  multiplier           :integer          default(2), not null
#  name                 :string           not null
#  password_digest      :string           not null
#  reset_password_token :string
#  vegetarian           :boolean          default(FALSE), not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  community_id         :bigint           not null
#  unit_id              :bigint           not null
#
# Indexes
#
#  index_residents_on_community_id           (community_id)
#  index_residents_on_email                  (email) UNIQUE
#  index_residents_on_name_and_community_id  (name,community_id) UNIQUE
#  index_residents_on_reset_password_token   (reset_password_token) UNIQUE
#  index_residents_on_unit_id                (unit_id)
#
# Foreign Keys
#
#  fk_rails_...  (community_id => communities.id)
#  fk_rails_...  (unit_id => units.id)
#

class Resident < ApplicationRecord
  attr_reader :password

  scope :adult, -> { where("multiplier >= 2") }
  scope :active, -> { where(active: true) }

  belongs_to :community
  belongs_to :unit

  has_one :key, as: :identity
  has_one :resident_balance, dependent: :destroy
  has_many :bills, dependent: :destroy
  has_many :meal_residents, dependent: :destroy
  has_many :meals, through: :meal_residents
  has_many :guests, dependent: :destroy
  has_many :guest_room_reservations, dependent: :destroy
  has_many :common_house_reservations, dependent: :destroy

  counter_culture :unit

  validates :multiplier, numericality: { only_integer: true }
  validates :name, presence: true, uniqueness: { case_sensitive: false, scope: :community_id }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }, allow_nil: true
  validate :email_presence

  before_validation :set_email
  before_save { self.email = email.downcase unless email.nil? }
  before_save :update_token


  # PASSWORD STUFF
  def authenticate(unencrypted_password)
    SCrypt::Password.new(password_digest).is_password?(unencrypted_password) && self
  end

  def password=(unencrypted_password)
    @password = unencrypted_password
    self.password_digest = SCrypt::Password.create(unencrypted_password)
  end

  def update_token
    if password_digest_changed?
      if persisted?
        key.set_token
      else
        self.build_key
      end
    end
  end


  # HELPERS
  def email_presence
    errors.add(:email,'cannot be blank.') if active && can_cook && multiplier >= 2 && email.nil?
  end

  def set_email
    self.email = nil if email == ""
  end

  def age
    now = Time.now.utc.to_date
    now.year - birthday.year - ((now.month > birthday.month || (now.month == birthday.month && now.day >= birthday.day)) ? 0 : 1)
  end


  # DERIVED DATA
  def bill_reimbursements
    # return 0 if Meal.where(community_id: community_id).unreconciled.count == 0
    # FIXME: temp hack
    return 0 if Meal.where(community_id: community_id).where(reconciliation_id: 3).count == 0
    bills.joins(:meal).where({:meals => {:reconciliation_id =>  3}}).reduce(0) { |sum, bill| sum + bill.reimburseable_amount }
  end

  def meal_resident_costs
    # return 0 if Meal.where(community_id: community_id).unreconciled.count == 0
    # FIXME: temp hack
    return 0 if Meal.where(community_id: community_id).where(reconciliation_id: 3).count == 0
    meal_residents.joins(:meal).where({:meals => {:reconciliation_id =>  3}}).reduce(0) { |sum, meal_resident| sum + meal_resident.cost }
  end

  def guest_costs
    # return 0 if Meal.where(community_id: community_id).unreconciled.count == 0
    # FIXME: temp hack
    return 0 if Meal.where(community_id: community_id).where(reconciliation_id: 3).count == 0
    guests.joins(:meal).where({:meals => {:reconciliation_id =>  3}}).reduce(0) { |sum, guest| sum + guest.cost }
  end

  def calc_balance
    # return 0 if Meal.where(community_id: community_id).unreconciled.count == 0
    # FIXME: temp hack
    return 0 if Meal.where(community_id: community_id).where(reconciliation_id: 3).count == 0
    bill_reimbursements - meal_resident_costs - guest_costs
  end

  def balance
    return resident_balance.amount if resident_balance.present? && !balance_is_dirty
    record = ResidentBalance.find_or_initialize_by(resident_id: id)
    record.amount = calc_balance
    record.save!
    self.update_attribute(:balance_is_dirty, false)
    record.amount
  end

  def meals_attended
    return 0 if Meal.where(community_id: community_id).unreconciled.count == 0
    meal_residents.joins(:meal).where({:meals => {:reconciliation_id =>  nil}}).count
  end
end
