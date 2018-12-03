# gems
require 'tty-prompt'
require 'tty-spinner'
require 'pastel'
require 'tty-file'

# built-ins
require 'securerandom'
require 'json'

# globals
require './app/utils/globals.rb'

# Application dependencies
require './app/utils/dataSaver.rb'
require './app/appLoader.rb'

# Application
require './app/mainMenu.rb'

require './app/lib/profile.rb'
require './app/lib/coworkers.rb'
require './app/lib/tasks.rb'

# Startup
loadApp()
mainMenu()
