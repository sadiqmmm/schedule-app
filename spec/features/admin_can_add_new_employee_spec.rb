require 'rails_helper'

RSpec.feature 'Admin can create new employee' do
  scenario 'they can see the employee\'s page' do
    admin = create(:admin)
    sign_in admin

    visit admin_path(admin)
    click_on 'Add new employee'
    fill_in 'employee_first_name', with: employee_first_name
    fill_in 'employee_last_name', with: employee_last_name
    fill_in 'employee_position', with: employee_position
    click_on 'Add employee'

    expect(page).to have_content employee_first_name
  end
end