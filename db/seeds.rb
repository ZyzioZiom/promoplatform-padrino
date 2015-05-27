# Seed add you the ability to populate your db.
# We provide you a basic shell for interaction with the end user.
# So try some code like below:
#
#   name = shell.ask("What's your name?")
#   shell.say name
#

Level.create(name: "Clint Eastwood", description: "If you want a guarantee, buy a toaster", image: "http://expositio.wpshower.com/wp-content/uploads/2014/03/martin-schoeller-clint-eastwood-portrait-up-close-and-personal.jpg", points: 0, created_at: Time.now, updated_at: Time.now)

shell.say "Utworzono pierwszy poziom"

Theme.create(name: "default", welcome_heading: "Witaj na Promoplatformie Kraków", welcome_message: "", activity_confirmed: "Aktywność potwierdzona, a punkty przyznane", chat_title: "Czat", send_message_button: "Wyślij wiadomość", action_confirmed: "Aktywność potwierdzona")

shell.say "Domyślny wygląd wygenerowany"

email     = shell.ask "Podaj e-mail, którego chcesz użyć do logowania do panelu admina:"
password  = shell.ask "Podaj hasło do panelu admina:"

shell.say ""

user = User.create(:email => email, :firstname => "Pan", :lastname => "Administrator", :password => password, :password_confirmation => password, :role => "admin", :image => "/images/admin.png")

if user.valid?
  shell.say "================================================================="
  shell.say " Administrator utworzony pomyślnie."
  shell.say "================================================================="
  shell.say "   email: #{email}"
  shell.say "   hasło: #{password}"
  shell.say "================================================================="
  shell.say " PROMOPLATFORMA GOTOWA"

else
  shell.say "Coś poszło źle!"
  shell.say ""
  user.errors.full_messages.each { |m| shell.say "   - #{m}" }
end

shell.say ""
