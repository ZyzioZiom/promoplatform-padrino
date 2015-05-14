# Seed add you the ability to populate your db.
# We provide you a basic shell for interaction with the end user.
# So try some code like below:
#
#   name = shell.ask("What's your name?")
#   shell.say name
#

level = Level.create(name: "Clint Eastwood", description: "If you want a guarantee, buy a toaster", image: "http://expositio.wpshower.com/wp-content/uploads/2014/03/martin-schoeller-clint-eastwood-portrait-up-close-and-personal.jpg", points: 0, created_at: Time.now, updated_at: Time.now)

shell.say "Created first level"

email     = shell.ask "Which email do you want use for logging into admin?"
password  = shell.ask "Tell me the password to use:"

shell.say ""

user = User.create(:email => email, :firstname => "Foo", :lastname => "Bar", :password => password, :password_confirmation => password, :role => "admin")

if user.valid?
  shell.say "================================================================="
  shell.say "User has been successfully created, now you can login with:"
  shell.say "================================================================="
  shell.say "   email: #{email}"
  shell.say "   password: #{password}"
  shell.say "================================================================="
else
  shell.say "Sorry but some thing went wrong!"
  shell.say ""
  user.errors.full_messages.each { |m| shell.say "   - #{m}" }
end

shell.say ""
