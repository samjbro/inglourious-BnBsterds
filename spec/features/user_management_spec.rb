feature 'user management' do

  scenario 'I am able to create a user account' do
    expect{ sign_up }.to change{ User.count }.by(1)
  end

  scenario "I am unable to create a user account if details are incorrect" do
    expect{ sign_up(password_confirmation: 'wrongpassword') }.not_to change{ User.count }
    expect{ sign_up(email: nil) }.not_to change{ User.count }
    expect{ sign_up(name: nil) }.not_to change{ User.count }
    sign_up
    expect{ sign_up }.not_to change{ User.count }
  end

  scenario 'I am able to see my user profile' do
    sign_up
    visit('/users/profile')
    expect(page).to have_content('Name: Joe Bloggs')
    expect(page).to have_content('Email: example@gmail.com')
  end




end
