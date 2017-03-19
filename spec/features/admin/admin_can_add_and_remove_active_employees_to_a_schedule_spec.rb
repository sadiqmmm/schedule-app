require 'rails_helper'

RSpec.feature 'admin can add and remove active employees to a schedule' do
  scenario 'by clicking button on schedule page to add' do
    admin = create(:admin)
    sign_in admin
    schedule = create(:schedule, admin: admin)
    shift_lead = create(:employee, admin: admin)

    visit schedule_path(schedule)
    click_on t('schedules.add_remove_employees.add_employees')

    expect(page).to have_content shift_lead.first_name_last_initial
  end

  scenario 'by clicking button on schedule page to remove' do
    admin = create(:admin)
    sign_in admin
    schedule = create(:schedule, admin: admin)
    shift_lead = create(:employee, admin: admin)

    visit schedule_path(schedule)
    click_on t('schedules.add_remove_employees.add_employees')

    visit schedule_path(schedule)
    click_on t('schedules.add_remove_employees.remove_employees')

    expect(page).to_not have_content shift_lead.first_name_last_initial
  end
end