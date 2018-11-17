# gems
require 'tty-prompt'

# local

def mainMenu ()
  prompt = TTY::Prompt.new
  
  choices = [
    {name: 'Tareas', value: 'tasks'},
    {name: 'Configuracion de sistema', value: 'sysConfig'},
    {name: 'Salir', value: 'exit'}
  ]

  selected = prompt.select("Menu principal", choices)

  if (selected == 'sysConfig') 
    return systemConfig()
  end

  if (selected == 'tasks')
    return tasksMenu()
  end
end

def tasksMenu ()

  tasksInProgress = 0
  prompt = TTY::Prompt.new
  
  choices = [
    {
      name: 'Ver status',
      value: 'status',
      disabled: tasksInProgress == 0 ? '(No hay tareas pendientes)': false
    },
    {name: 'Agregar tarea', value: 'addTask'},
    {name: 'Buscar tarea', value: 'searchTask'},
    {name: 'Historial de tareas', value: 'tasksHistory'},
    {name: 'Atras', value: 'back'}
  ]

  selected = prompt.select("Menu de tareas", choices, default: tasksInProgress == 0 ? 2 : 1)

  if (selected == 'back')
    return mainMenu()
  end
  
  if (selected == 'status') 
    return showStatus()
  end

end

def showStatus ()
  puts "show status"
end


def systemConfig ()
=begin
    Se puede reconfigurar...
    ... la ubicacion de los archivos
    ... usuarios
=end

  prompt = TTY::Prompt.new
    
  choices = [
    {name: 'Ubicacion de archivos', value: 'files'},
    {name: 'Usuarios', value: 'users'},
    {name: 'Atras', value: 'back'}
  ]

  selected = prompt.select("Configuracion de sistema", choices)

  if (selected == 'back')
    return mainMenu()
  end

end