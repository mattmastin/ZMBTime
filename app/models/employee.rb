class Employee < ActiveRecord::Base
  attr_accessible :city, :email, :first_name, :last_name, :state, :street_address, :telephone_number, :zip_code
end
