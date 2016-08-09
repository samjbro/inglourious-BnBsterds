describe User do

  it 'authenticates the correct password' do
    user = User.create(email: 'example@gmail.com',
                name: 'Joe Bloggs',
                password: 'password123',
                password_confirmation: 'password123')

    expect(User.password_authentication('example@gmail.com', 'password123')).to eq user
  end

  it 'does not authenticate the incorrect password' do
    user = User.create(email: 'example@gmail.com',
                name: 'Joe Bloggs',
                password: 'password123',
                password_confirmation: 'password123')

    expect(User.password_authentication('example@gmail.com', 'wrongpassword')).to eq nil
  end

end
