# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# email='tyarbrough@zmbdna.com'

# password_salt=BCrypt::Engine.generate_salt

# password_hash=BCrypt::Engine.hash_secret("BigMoney12", password_salt)

# admin=true


password_salt = BCrypt::Engine.generate_salt
password = 'BigMoney12'
email = ['apicht@zmbdna.com','nwalters@zmbdna.com','lyarbrough@zmbdna.com','nchandler@zmbdna.com','jdahlquist@zmbdna.com']
first_names = ['Aaron','Nathan','Lee','Nathan','Joe']
last_names = ['Picht','Walters','Yarbrough','Chandler','Dahlquist']
i = 0
email.each do |e|


  User.create!(:email => e,:password => password,:password_salt => password_salt, :password_hash => BCrypt::Engine.hash_secret(password, password_salt), :admin => false)
  Employee.create!(:email => e, :first_name => first_names[i], :last_name => last_names[i])
  i = i + 1
end

User.create!(:email => 'mmastin@zmbdna.com',:password => password,:password_salt => password_salt, :password_hash => BCrypt::Engine.hash_secret(password, password_salt), :admin => true)
Employee.create!(:email => 'mmastin@zmbdna.com',:first_name => 'Matt',:last_name => 'Mastin')

User.create!(:email => 'tyarbrough@zmbdna.com',:password => password,:password_salt => password_salt, :password_hash => BCrypt::Engine.hash_secret(password, password_salt), :admin => true)
Employee.create!(:email => 'tyarbrough@zmbdna.com',:first_name => 'Terry', :last_name => 'Yarbrough')

ProjectInfo.create!(:client => 'ZMB DnA',:project_name => 'Bench', :open => true)
ProjectInfo.create!(:client => 'ZMB DnA',:project_name => 'Internal Project', :open => true)
