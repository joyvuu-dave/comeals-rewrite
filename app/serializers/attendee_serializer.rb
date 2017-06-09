class AttendeeSerializer < ActiveModel::Serializer
  attributes :resident_id,
             :meal_id,
             :name,
             :attending,
             :late,
             :vegetarian,
             :guests

  def resident_id
    object.id
  end

  def meal_id
    scope.id
  end

  def attending
    meal_resident.present?
  end

  def late
    meal_resident.present? ? meal_resident.late : false
  end

  def vegetarian
    meal_resident.present? ? meal_resident.vegetarian : object.vegetarian
  end

  def guests
    Guest.where(meal_id: scope.id, resident_id: object.id).count
  end

  private
  def meal_resident
    @meal_resident ||= MealResident.find_by(meal_id: scope.id, resident_id: object.id)
  end
end
