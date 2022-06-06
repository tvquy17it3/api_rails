Role.create!([
  {name: :admin, slug: "admin"},
  {name: :manager, slug: "manager"},
  {name: :user, slug: "user"}]
)

5.times do |n|
  email = "test-#{rand(252...4350)}@branch.com"
  password = "password#{rand(2102...9350)}"
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

passw = "abc@12345#{rand(252...4350)}"
User.create!(email: "tvquy.17it3@vku.udn.vn", role_id: 1,
             password: passw, password_confirmation: passw)

Shift.create!([
  {name: "Morning", check_in: "07:30:00", check_out: "11:30:00"},
  {name: "Afternoon", check_in: "13:00:00", check_out: "15:00:00"}
])
