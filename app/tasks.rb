# gems
require 'tty-prompt'

# local

def tasksMenu ()
  prompt = TTY::Prompt.new
  
  choices = [
    {name: 'Ver status', value: 'status'},
    {name: 'Agregar tarea', value: 'addTask'},
    {name: 'Buscar tarea', value: 'searchTask'}
    {name: 'Historial de tareas', value: 'tasksHistory'}
    {name: 'Atras', value: 'back'}
  ]

  selected = prompt.select("Menu de tareas", choices)

  if (selected == 'back')
    return 
  end
  if (selected == 'status') 
    return showStatus()
  end

  if (selected == 'tasks')
    return tasks()
  end
end

def showStatus ()
  puts "show status"

end
