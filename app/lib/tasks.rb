def tasksMenu ()

  tasksInProgress = 1
  prompt = TTY::Prompt.new
  
  choices = []
  if ($tasks.length > 0)
    choices.push({name: 'Ver status', value: 'status'})
    choices.push({name: 'Buscar tarea', value: 'searchTask'})
    choices.push({name: 'Editar tarea', value: 'editTask'})
  end
  choices.push({name: 'Agregar tarea', value: 'addTask'})
  choices.push({name: 'Atras', value: 'back'})

  selected = prompt.select("Menu de tareas", choices, default: tasksInProgress == 0 ? 2 : 1)

  # in ./app/tasks.rb
  case selected
    when 'status'
      return showStatus()
    when 'addTask'
      return addTask()
    when 'searchTask'
      return searchTask()
    when 'editTask'
      return editTask()
    when 'back'
      return mainMenu()
  end
end

def addTask ()
  # Loading priorities
  priorities = []
  for i in 0..$taskPriorities.length-1
    p = $taskPriorities[i]
    priorities.push({
      name: p["name"],
      value: p["id"]
    })
  end

  #Loading task status
  taskStatus = []
  for i in 0..$taskStatus.length-1
    t = $taskStatus[i]
    taskStatus.push({
      name: t["name"],
      value: t["id"]
    })
  end

  # Loading coworkers
  coworkersList = []
  coworkersList.push({
    name: $personalInfo["name"] + " (" + $personalInfo["email"] + ")",
    value: $personalInfo["id"]
  })

  for i in 0..$coworkers.length-1
    c = $coworkers[i]
    coworkersList.push({
      name: c["name"] + " (" + c["email"] + ")",
      value: c["id"]
    })
  end

  # Task details
  task = {}
  prompt = TTY::Prompt.new
  task["id"] = SecureRandom.uuid
  task["title"] = prompt.ask('Titulo de la tarea', '')
  task["description"] = prompt.multiline("Descripcion de la tarea").join("")
  task["taskPriority"] = prompt.select('Establezca prioridad', priorities, filter: true)
  task["taskStatus"] = prompt.select('Indique estado inicial de la tarea', taskStatus, filter: true)
  task["coworkerID"] = prompt.select('Seleccione un trabajador', coworkersList, filter: true)

  $tasks.push(task)
  saveData('./data/tasks.json', JSON.generate($tasks))

  # [Estilo] Aplicando color al texto
  pastel = Pastel.new
  puts pastel.green('Tarea agregada')
  tasksMenu()
end
def showStatus ()
  puts "Show status"
end

def searchTask ()
  puts "Search Task"
  # TODO: replace coworkers reference with task
  prompt = TTY::Prompt.new

  choices = []
  choices.push({name: 'Companero de trabajo', value: 'coworkerID'})
  choices.push({name: 'Titulo', value: 'title'})
  choices.push({name: 'Descripcion', value: 'description'})
  choices.push({name: 'Prioridad', value: 'taskPriority'})
  choices.push({name: 'Status', value: 'taskStatus'})
  choices.push({name: 'Ir al menu anterior', value: 'back'})

  selected = prompt.select("Buscar por: ", choices)
  if (selected == "back")
    return tasksMenu()
  end
  
  if (selected == 'coworkerID')
    # Show coworkers and assign to queryText
  end

  if (selected == 'taskPriority')
    # Show tasksPriorities and assign to queryText
  end

  if (selected == 'taskStatus')
    # Show task status and assign to queryText
  end



  queryText = prompt.ask('Valor a buscar: ', default: '')

  # Busqueda lineal
  result = []
  for i in 0..$tasks.length-1
    t = $tasks[i]
    if (t[selected].index(queryText) != nil)
      result.push(t)
    end
  end

  # Ordenamiento
  orderTasks(result, selected)

=begin
  Esta parte se puede hacer con un bucle normal,
  pero para la calificacion utilizaremos:
    - Una lista doblemente enlazada
    - Una funcion recursiva para recorrer la lista
=end

  tasksList =  createTasksList(result)
  listTasksRecursive(tasksList)
  searchTask()
end

#FIXME: Debe ser case insensitive
def orderTasks (arr, field)
  for i in 0..arr.length-2
    for j in (i+1)..arr.length-1
      if (arr[i][field] > arr[j][field] )
        arr[i], arr[j] = arr[j], arr[i]
      end
    end
  end
  return arr
end

def createTasksList(arr)
  lista = nil
  ultimoNodo = nil

  for i in 0..arr.length-1
      nodo = [nil, arr[i], nil]
      if (lista == nil)
          lista = nodo
      else
          nodo[0] = ultimoNodo
          ultimoNodo[2] = nodo
      end
      ultimoNodo = nodo
  end
  return lista
end

def listTasksRecursive(list)
  if (list == nil)
    return nil
  end
  nextTask(list)
end

def nextTask (nodo)
  valor = nodo[1]
  nodo = nodo[2]
  printTaskData(valor)
  if (nodo != nil)
    nextTask(nodo)
  end
end

def printTaskData(task)
=begin
  "id": "e845da9c-f52d-4acf-be7e-0b4f1e15ed43",
  "title": "iiiii"
  "description": "jjasd\n",
  "coworkerID": 0,
  "taskPriority": 0,
  "taskStatus": 0,
=end
  puts "---------------------------------"
  puts "Codigo: " + task["id"]
  puts "Titulo: " + task["title"]
  puts "Descripcion: " + task["description"]
  puts "Companero de trabajo: " + "" # task["phone"] reemplazar por name (email@example.com) (Rol)
  puts "Prioridad: " + "" # task["role"] Reemplazar por prioridad (Media, baja | 1,2)
  puts "Status: " + "" # reemplazar por status como en prioridad
  puts "---------------------------------"
end

def editTask ()
  puts "Edit task"
end

def editTask ()
  puts "Tasks History"
  puts $taskStatus
end
