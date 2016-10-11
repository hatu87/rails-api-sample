Book.delete_all
User.delete_all

User.create!(name: 'ken', email: 'hatu87@gmail.com', password: '12345678', token: '123')

10.times do
  author = Author.create!(name: FFaker::Name.name, email: FFaker::Internet.email)

  3.times do

    Book.create!(title: FFaker::Lorem.sentence, description: FFaker::Lorem.paragraph, author_id: author.id)


  end

end
