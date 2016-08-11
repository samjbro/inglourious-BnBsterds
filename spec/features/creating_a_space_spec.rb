feature 'Creating a space' do
  scenario "I can create a new space" do
    sign_up
    expect{ create_space }.to change{ Space.count }.by(1)
    expect(page).to have_content("Inglorious Apartment")
    expect(page).to have_content("Beautiful bachelor pad for the whole squad")
    expect(page).to have_content("£150")
    expect(page).to have_content("")
  end

  scenario "I cannot create a new space if I am not signed in" do
    create_space
    expect(page).to have_content "You must be signed-in to create a space!"
  end
  
end
