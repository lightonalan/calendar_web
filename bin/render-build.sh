#!/usr/bin/env bash
set -o errexit

bundle install
mkdir -p storage tmp/cache
bundle exec rails db:prepare
bundle exec rails assets:precompile
