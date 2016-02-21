class Profile < ActiveRecord::Base
  belongs_to :user

  validate :first_or_last_name_in

  validates :gender, inclusion: { in: %w(male female) }

  validate :no_sue

  def first_or_last_name_in
  	if first_name.nil? and last_name.nil?
  		errors.add(:first_name, "Must enter first or last name")
  		errors.add(:last_name, "Must enter first or last name")
	  end
  end

  def no_sue
  	if gender == "male" and first_name == "Sue"
  		errors.add(:first_name, "A male can't be called Sue")
	  end
  end

  def self.get_all_profiles(min_year, max_year)
    where("birth_year BETWEEN :min AND :max", min: min_year, max: max_year ).order(birth_year: :asc)
  end

end
