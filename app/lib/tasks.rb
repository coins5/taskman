def tasksMenu ()

  tasksInProgress = 1
  prompt = TTY::Prompt.new
  
  choices = []
  if ($tasks.length > 0)
    #choices.push({name: 'Ver status', value: 'status'})
    choices.push({name: 'Buscar tarea', value: 'searchTask'})
    choices.push({name: 'Editar tarea', value: 'editTask'})
  end
  choices.push({name: 'Agregar tarea', value: 'addTask'})
  choices.push({name: 'Atras', value: 'back'})

  selected = prompt.select("Menu de tareas", choices, default: tasksInProgress == 0 ? 2 : 1)

  # in ./app/tasks.rb
  case selected
    #when 'status'
    #  return showStatus()
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
  
  queryText = ''
  if (selected == 'coworkerID')
    # Show coworkers and assign to queryText
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
    queryText = prompt.select("Elija un companero de trabajo: ", coworkersList, filter: true)
  end

  if (selected == 'taskPriority')
    # Show tasksPriorities and assign to queryText
    tasksPrioritiesList = []
    for i in 0..$taskPriorities.length-1
      c = $taskPriorities[i]
      tasksPrioritiesList.push({
        name: c["name"],
        value: c["id"]
      })
    end
    queryText = prompt.select("Elija una prioridad: ", tasksPrioritiesList)
  end

  if (selected == 'taskStatus')
    # Show task status and assign to queryText
    tasksStatusList = []
    for i in 0..$taskStatus.length-1
      c = $taskStatus[i]
      tasksStatusList.push({
        name: c["name"],
        value: c["id"]
      })
    end
    queryText = prompt.select("Elija una prioridad: ", tasksStatusList)
  end

  # para companeros de trabajo, titulos y descripcion
  if (queryText == '')
    queryText = prompt.ask('Valor a buscar: ', default: '')
  end
  

  # Busqueda lineal
  result = []
  for i in 0..$tasks.length-1
    t = $tasks[i]
    if (t[selected].to_s.downcase.index(queryText.to_s.downcase) != nil)
      result.push(t)
    end
  end

  if (result.length > 0)
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
  else
    puts "---------------------------------"
    puts 'Nada que mostrar'
    puts "---------------------------------"
  end

  searchTask()
end

def orderTasks (arr, field)
  for i in 0..arr.length-2
    for j in (i+1)..arr.length-1
      if (arr[i][field].to_s.downcase > arr[j][field].to_s.downcase )
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
  coworkerName = task["coworkerID"]
  taskPriority = task["taskPriority"]
  taskStatus = task["taskStatus"]

  # Busquedas lineales
  if (task["coworkerID"] == 0)
    coworkerName = $personalInfo["name"] + " (" + $personalInfo["email"] + ")"
  else
    for i in 0..$coworkers.length-1
      c = $coworkers[i]
      if (c["id"].to_s == task["coworkerID"].to_s)
        coworkerName = c["name"] + " (" + c["email"] + ")"
        break
      end
    end
  end

  for i in 0..$taskPriorities.length-1
    c = $taskPriorities[i]
    if (c["id"].to_s == task["taskPriority"].to_s)
      taskPriority = c["name"]
      break
    end
  end

  for i in 0..$taskStatus.length-1
    c = $taskStatus[i]
    if (c["id"].to_s == task["taskStatus"].to_s)
      taskStatus = c["name"]
      break
    end
  end

  puts "---------------------------------"
  puts "Codigo: " + task["id"].to_s
  puts "Titulo: " + task["title"].to_s
  puts "Descripcion: " + task["description"].to_s
  puts "Companero de trabajo: " + coworkerName.to_s # task["phone"] reemplazar por name (email@example.com) (Rol)
  puts "Prioridad: " + taskPriority.to_s # task["role"] Reemplazar por prioridad (Media, baja | 1,2)
  puts "Status: " + taskStatus.to_s # reemplazar por status como en prioridad
  puts "---------------------------------"
end

def editTask ()
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

