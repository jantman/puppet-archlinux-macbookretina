#!/bin/bash -e -x

bundle install --path vendor
bundle exec rake beaker
