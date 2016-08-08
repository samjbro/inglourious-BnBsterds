feature 'user management' do

  scenario 'I am able to create a user account' do
    visit '/users/new'
    fill_in(:email, with: 'example@gmail.com')
    fill_in(:name, with: 'Joe Bloggs')
    fill_in(:password, with: 'password123')
    fill_in(:password_confirmation, with: 'password123')
    click_button('submit')
    expect(page).to have_content('You are signed in as Joe Bloggs.')
  end

end
