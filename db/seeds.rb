User.create(email: ENV['DEFAULT_USER_EMAIL'], password: ENV['DEFAULT_USER_PASSWORD']) unless User.where(email: ENV['DEFAULT_USER_EMAIL'])
