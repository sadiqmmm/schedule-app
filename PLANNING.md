# General idea of app structure
- An organizer can create an account for their company.
- The organizer can assign admins.
- The organizer or admins can assign managers.
- The organizer or admins can create a team.
- The organizer, admins, or managers can assign employees to their team.
- The organizer, admins, or managers can assign assistants to their team.
- The organizer, admins, or managers can create shifts for their team.
- The organizer, admins, managers, or assistants can update the employee's availability based on created shifts for their team.
- The organizer, admins, managers, or assistants can schedule an employee for a shift.
- The organizer, admins, managers, or assistants cannot schedule an employee for a shift the employee is not available for.
- The organizer, admins, managers, or assistants can finalize the schedule and download it as a PDF (ideally email to all employees on the team).

# Models
I think the way I want to do this is have the Devise user model, then using single table inheritance (STI) for the other user roles. Probably the best way with the associations I want each type of user to have. I will have the Devise `User` model and each of the "roles" will be models that inherite from `User` i.e. `Organizer < User`. [Reference](https://rails.devcamp.com/professional-rails-development-course/advanced-user-features/enabling-admin-users-using-single-table-inheritance)

The gem devise_invitable will allow users to invite. The user will have a `role_id` or `type` (see above reference link, `type` should work just as well as `role_id` for the invite) column that will be part of the invite and like the invited email, get set in the sign up form. [Reference](http://stackoverflow.com/questions/29616495/cannot-get-devise-invitable-to-assign-a-role-when-inviting)

Form example:
```
<%= simple_form_for(User.new, url: user_invitation_path,
                              html: { class: 'form-inline' }) do |f| %>
  <%= f.input :email, placeholder: 'Email', label: false %>
  <%= f.collection_select :role_id, Role.all, :id, :name, {} %>
  <%= f.button :submit, 'Invite User', class: 'btn-primary' %>
<% end %>
```

- User
  - Models that inherit from `User` will act as roles: organizer, admin, manager, assistant (find better term than assistant), employee
  - `first_name:string`, `last_name:string`, `email:string`, `title:string`, `role_id:integer` (or `type:string`)
  - Associations
    - `belongs_to :organization`
    - `belongs_to :team`
    - `has_many :user_schedules`
    - `has_many :schedules, through: :user_schedules`

- Role
  - I don't think this is necessary if I use `type`

- Organization
  - `name:string`, `email:string`
  - Associations
    - `has_many :teams`
    - `has_many :admins`, `has_many :managers`, `has_many :assistants`,      `has_many :employees`

- Team
  - `location:string`
  - Associations
    - `belongs_to :organization`
    - `has_many :schedules`

- UserSchedules
  - Associations
  - `belongs_to :user`
  - `belongs_to :schedule`

- Schedule
  - `year:integer`, `week:integer`, `date_range:string #don't call it date_range`
  - Associations
    - `belongs_to :team`
    - `has_many :user_schedules`
    - `has_many :users, through: :user_schedules`

- Shift

## Who gets to do what
### Adding users
```
Cascading permissions
├─ Organizer can create/invite admins
|  └─ Admins can create/invite managers
|   └─ Managers can create/invite assistants
|     └─ Managers can create/invite employees
└─ Once invited, any user can create their account
```

### Default user role
- When you create an organization, your account is also created and your role is defaulted to organizer.
- When you click an invite link, your role is defaulted to the role selected when your invite was created.
- You are not allowed to invite users with a higher role than you have.

### Removing users
```
Cascading permissions
└─ Organizer can remove admins
  └─ Admins can remove managers
    └─ Managers can remove assistants
      └─ Managers can remove employees
       └─ An employee cannot remove their account
```

# Controllers

# Views