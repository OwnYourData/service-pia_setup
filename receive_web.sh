#!/bin/bash
# called from oydhook in /etc/postfix/master.cf
export PATH=/home/user/.rvm/gems/ruby-2.2.4/wrapper:/home/user/.rvm/gems/ruby-2.2.4/bin:/home/user/.rvm/gems/ruby-2.2.4@global/bin:$PATH
export GEM_HOME=/home/user/.rvm/gems/ruby-2.2.4
export GEM_PATH=/home/user/.rvm/gems/ruby-2.2.4:/home/user/.rvm/gems/ruby-2.2.4@global 
export MY_RUBY_HOME=/home/user/.rvm/rubies/ruby-2.2.4
export HOME=/home/user
source /home/user/.bash_profile # set ENV variable for mailer password
/home/user/oyd/service-pia_setup/bin/rails runner 'NewPiaMailer.receive(STDIN.read)'
