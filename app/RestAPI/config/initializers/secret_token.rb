# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
RestAPI::Application.config.secret_key_base = '3cb7c10085aea7a37bdcc6d1fdbac89b386e784f5b9688ba54c4311e3d6fb12714c76d9cbd58570679daf0aec6aadd06be17ba717e5934994af49a51a9173379'
