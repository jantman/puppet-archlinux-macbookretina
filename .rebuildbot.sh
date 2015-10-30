#!/bin/bash -ex

bundle install --path vendor
bundle exec rake beaker
