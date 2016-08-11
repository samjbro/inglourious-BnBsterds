feature 'user management' do

  scenario 'I am able to create a user account' do
    expect{ sign_up }.to change{ User.count }.by(1)
  end

  scenario "I am unable to create a user account if details are incorrect" do
    expect{ sign_up(password_confirmation: 'wrongpassword') }.not_to change{ User.count }
    expect{ sign_up(email: nil) }.not_to change{ User.count }
    expect{ sign_up(name: nil) }.not_to change{ User.count }
    User.create(email: 'example@gmail.com',
                name: 'Joe Bloggs',
                password: 'password123',
                password_confirmation: 'password123')
    expect{ sign_up }.not_to change{ User.count }
    expect(page).to have_content("Email is already taken")
  end

  scenario 'I am able to see my user profile' do
    sign_up
    visit('/users/profile')
    expect(page).to have_content('Name: Joe Bloggs')
    expect(page).to have_content('Email: example@gmail.com')
  end




end
