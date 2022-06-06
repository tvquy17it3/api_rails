Role.create!([
  {name: :admin, slug: :admin},
  {name: :manager, slug: :manager},
  {name: :user, slug: :user}]
)

5.times do |n|
  email = "test-#{rand(252...4350)}@branch.com"
  password = "password123"
  name = Faker::Name.unique.name
  phone = Faker::PhoneNumber.phone_number
  address = Faker::Address.full_address
  role = Role.find_by slug: "user"
  gender = Faker::Gender.binary_type

  u = User.create!(email: email,
                   password: password,
                   role_id: role.id,
                   password_confirmation: password)

  u.create_contact(name: name,
                    phone: phone,
                    gender: gender,
                    address: address)
  u.save!
end

pass = "abc@12345=="
User.create!(email: "tvquy.17it3@vku.udn.vn", role_id: 1, password: pass, password_confirmation: pass)

Shift.create!([
  {name: "Morning", check_in: "07:30:00", check_out: "11:30:00"},
  {name: "Afternoon", check_in: "13:00:00", check_out: "15:00:00"}
])
