set +e

source ~/.bash_profile
source ~/.bashrc

cd /home/ec2-user/ActorConnection/

bundle install --without test development

bundle exec rails assets:precompile RAILS_ENV=production

bundle exec rails db:migrate RAILS_ENV=production

cat tmp/pids/server.pid |xargs kill -9

bundle exec rails s -e production
