feature 'Creating a space' do
  scenario "I can create a new space" do
    visit 'spaces/new'
    expect(page).to have_content("List a space")
    expect{ click_button('submit') }.to change{ Space.count }.by(1)
  end
end
