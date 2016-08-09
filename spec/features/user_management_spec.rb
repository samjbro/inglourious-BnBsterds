feature 'user management' do

  scenario 'I am able to create a user account' do
    expec{ sign_up }.to change{ User.count }.by(1)
  end

  scenario 'I am able to see my user profile' do
    sign_up
    visit('/users/profile')
    expect(page).to have_content('Name: Joe Bloggs')
    expect(page).to have_content('Email: example@gmail.com')
  end

end
