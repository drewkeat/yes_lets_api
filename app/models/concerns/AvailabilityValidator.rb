class AvailabilityValidator < ActiveModel::Validator
  def validate(availability)
    
    # BEFOREDEPLOY: Uncomment method below vvvv
    # if availability.start.day != availability.end.day
    #   availability.errors.add :base, :invalid, message: "Availability must start and end on the same day."
    # end

    if availability.start > availability.end
      availability.errors.add :base, :invalid, message: "Availability must start before it ends."
    end

    # if Availability.all.matches(availability)
    #   availability.errors.add :base, :invalid, message: "An availability for this time already exists."
    # end
  end
end