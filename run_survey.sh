#!/bin/bash

# Install Ruby gem if not already installed
gem list | grep pstore || gem install pstore

# Run the Ruby program
ruby questionnaire.rb