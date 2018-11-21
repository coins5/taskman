# gems
require 'tty-prompt'
require 'tty-config'
require 'tty-spinner'
require 'pastel'
require 'tty-file'

# built-ins
require 'securerandom'

# globals
require './app/utils/globals.rb'

# Application dependencies
require './app/loadApp.rb'
require './app/mainMenu.rb'
  require './app/tasks.rb'

# Startup
loadApp()
mainMenu()
