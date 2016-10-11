FactoryGirl.define do
  factory :user do
    name 'hatu'
    email { "#{name}@bookstore.com" }
    password '12345678'
  end
end
