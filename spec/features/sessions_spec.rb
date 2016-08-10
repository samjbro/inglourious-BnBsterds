feature "Sessions" do

  scenario 'As a signed-up user, I can sign-in' do
    user = User.create(email: 'example@gmail.com',
                name: 'Joe Bloggs',
                password: 'password123',
                password_confirmation: 'password123')
    visit('/')
    click_link('Sign-in')
    fill_in(:email, with: 'example@gmail.com')
    fill_in(:password, with: 'password123')
    click_button('Sign-in')
    expect(page).to have_content("You are signed in as Joe Bloggs")
  end

  scenario 'As a signed-in user, I can sign-out' do
    sign_up
    click_button('Sign-out')
    expect(page).to have_content("Sign-in")
    expect(page).to have_content("Sign-up")
  end

  scenario 'I cannot log in with the wrong credentials' do
    visit ('/')
    click_link('Sign-in')
    fill_in(:email, with: 'example@gmail.com')
    fill_in(:password, with: 'abc')
    click_button('Sign-in')
    expect(page).to have_content("Sign-in Failed")
  end

end
