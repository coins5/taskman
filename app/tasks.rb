def showStatus ()
  puts "show status"
end

def addTask ()
  #TODO: Completar esta parte
  task = {}
  prompt = TTY::Prompt.new

  coworkersList = $coworkersList.clone
  coworkersList << {id: 0, name: 'me'}
  task[:id] = SecureRandom.uuid
  task[:title] = prompt.ask('Titulo de la tarea', '')
  task[:description] = prompt.multiline("Descripcion de la tarea").join("")
  
  warriors = %w(Scorpion Kano Jax Kitana Raiden)


  prompt.select('Choose your destiny?', warriors, filter: true)
# =>
# Choose your destiny? (Use arrow keys, press Enter to select, and letter keys to filter)
# ‣ Scorpion
#   Kano
#   Jax
#   Kitana
#   Raiden


  puts task
end

def searchTask ()
  puts "search Task"
end

def tasksHistory ()
  puts "tasks History"
  puts $taskStatus
end
