# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# app = Rpush::Apns::App.new
# app.name = "dev_apns"
# app.certificate = File.read(Rails.root.join('config', 'certificates','dev_apns.pem'))
# app.environment = 'sandbox' # APNs environment.
# app.password = ENV['APNS_CERTIFICATE_PASSWORD']
# app.connections = 1
# app.save!

User.create(email: 'admin@fakenewsquiz.de', password: ENV['DEFAULT_PASSWORD'], admin: true)
User.create(email: 'superadmin@fakenewsquiz.de', password: ENV['DEFAULT_PASSWORD'], admin: true, super_admin: true)

