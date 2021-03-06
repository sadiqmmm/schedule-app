require 'rails_helper'

RSpec.feature 'admin can print a set schedule' do
  scenario 'by clicking a button to display a printable schedule' do
    admin = build(:admin)
    sign_in admin
    schedule = create(:schedule, admin: admin)
    schedule.employees << shift_lead  = create(:employee, admin: admin)
    schedule.employees << team_member = create(:employee,
                                               admin: admin,
                                               position: 'Team Member')
    # Note for below: employee_id is always 0 for admin shifts. This is to keep
    # the id for the admin separate from the ids of the employees. Since there
    # is only ever one admin per schedule, this works. It will need to be changed
    # in the future if there are multiple admins.
    schedule.shifts << build(:shift, employee_id: 0,
                                     start_time:  '7:30 am',
                                     end_time:    '4:00 pm')
    schedule.shifts << build(:shift, employee_id: shift_lead.id,
                                     start_time:  '2:30 pm',
                                     end_time:    '7:30 pm')
    schedule.shifts << build(:shift, employee_id: team_member.id,
                                     start_time:  '12:00 pm',
                                     end_time:    '6:00 pm')

    visit schedule_path(schedule)
    click_on t('schedules.show.print_schedule')

    expect(page).to have_content '7:30 am - 4:00 pm'
    expect(page).to have_content '2:30 pm - 7:30 pm'
    expect(page).to have_content '12:00 pm - 6:00 pm'
    expect(page).to have_content 'Printable schedule'
  end
end
