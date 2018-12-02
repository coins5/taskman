def addTask ()
  # Loading priorities
  priorities = []
  for i in 0..$taskPriorities.length-1
    p = $taskPriorities[i]
    priorities.push({
      name: p["name"],
      id: p["id"]
    })
  end

  #Loading task status
  taskStatus = []
  for i in 0..$taskStatus.length-1
    t = $taskStatus[i]
    taskStatus.push({
      name: t["name"],
      id: t["id"]
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

  task[:id] = SecureRandom.uuid
  task[:title] = prompt.ask('Titulo de la tarea', '')
  task[:description] = prompt.multiline("Descripcion de la tarea").join("")
  task[:taskPriority] = prompt.select('Establezca prioridad', priorities, filter: true)
  task[:taskStatus] = prompt.select('Indique estado inicial de la tarea', taskStatus, filter: true)
  task[:coworkerID] = prompt.select('Seleccione un trabajador', coworkersList, filter: true)

  $tasks.push(task)
  # [Estilo] Aplicando color al texto
  pastel = Pastel.new
  puts pastel.green('Tarea agregada')
  tasksMenu()
end

def searchTask ()
  puts "search Task"
end

def tasksHistory ()
  puts "tasks History"
  puts $taskStatus
end
