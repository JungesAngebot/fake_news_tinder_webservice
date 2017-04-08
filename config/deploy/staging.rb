# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary
# server in each group is considered to be the first
# unless any hosts have the primary property set.
# Don't declare `role :all`, it's a meta role
set :domain, 'fm-staging.fluidmobile.de'

role :web, fetch(:domain)                          # Your HTTP server, Apache/etc
role :app, fetch(:domain)                         # This may be the same as your `Web` server
role :db, fetch(:domain)    # This is where Rails migrations will run

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server
# definition into the server list. The second argument
# something that quacks like a hash can be used to set
# extended properties on the server.
server fetch(:domain),
       user: 'deployment',
       roles: %w{web app},
       port: 22248

set :deploy_to, -> { '/var/www/fm_webservice/staging/' }
set :branch, 'develop'
set :rails_env, 'staging'

set :rvm_ruby_version, '2.3-latest@fm_webservice_staging'


# you can set custom ssh options
# it's possible to pass any option but you need to keep in mind that net/ssh understand limited list of options
# you can see them in [net/ssh documentation](http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start)
# set it globally
#  set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
# and/or per server
# server 'example.com',
#   user: 'user_name',
#   roles: %w{web app},
#   ssh_options: {
#     user: 'user_name', # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: 'please use keys'
#   }
# setting per server overrides global ssh_options
