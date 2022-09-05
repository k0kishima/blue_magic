#! /bin/sh -eu

bundle update --bundler
rm -f tmp/pids/*
bundle install

exec "$@"
