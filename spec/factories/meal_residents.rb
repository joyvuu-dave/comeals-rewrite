# == Schema Information
#
# Table name: meal_residents
#
#  id           :integer          not null, primary key
#  meal_id      :integer          not null
#  resident_id  :integer          not null
#  community_id :integer          not null
#  multiplier   :integer          not null
#  vegetarian   :boolean          default(FALSE), not null
#  late         :boolean          default(FALSE), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_meal_residents_on_community_id             (community_id)
#  index_meal_residents_on_meal_id                  (meal_id)
#  index_meal_residents_on_meal_id_and_resident_id  (meal_id,resident_id) UNIQUE
#  index_meal_residents_on_resident_id              (resident_id)
#
# Foreign Keys
#
#  fk_rails_...  (community_id => communities.id)
#  fk_rails_...  (meal_id => meals.id)
#  fk_rails_...  (resident_id => residents.id)
#

FactoryBot.define do
  factory :meal_resident do
    meal
    resident
    community
    multiplier { 2 }
  end
end
