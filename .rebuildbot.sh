#!/bin/bash -ex

set +x
. ~/.rvm/scripts/rvm
rvm use $(cat .ruby-version)
rvm info
which ruby
ruby -v
set -x

bundle install --path vendor
bundle exec rake spec_prep
bundle exec rake beaker
