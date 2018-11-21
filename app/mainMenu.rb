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

  tasksInProgress = 1
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

  # in ./app/tasks.rb
  case selected
    when 'status'
      return showStatus()
    when 'addTask'
      return addTask()
    when 'searchTask'
      return searchTask()
    when 'tasksHistory'
      return tasksHistory()
    when 'back'
      return mainMenu()
  end
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
    {name: 'Companeros de trabajo', value: 'coworkers'},
    {name: 'Atras', value: 'back'}
  ]

  selected = prompt.select("Configuracion de sistema", choices)

  if (selected == 'back')
    return mainMenu()
  end

end