def coworkersMenu ()
  prompt = TTY::Prompt.new

  choices = []
  if ($coworkers.length > 0)
    choices.push({name: 'Mostrar companeros de trabajo', value: 'showCoworkers'})
  end
  choices.push({name: 'Agregar companeros de trabajo', value: 'addCoworkers'})
  choices.push({name: 'Atras', value: 'back'})

  # TODO: Menu para cambiar ubicacion de archivos. Util en un futuro
  #choices.push({name: 'Ubicacion de archivos', value: 'files'})
  
  selected = prompt.select("Configuracion de sistema", choices)

  if (selected == 'back')
    return systemConfig()
  end

  if (selected == 'addCoworkers')
    return addCoworkers()
  end
end

def addCoworkers ()
  coworker = {}

  prompt = TTY::Prompt.new

  coworker[:id] = SecureRandom.uuid
  coworker[:name] = prompt.ask('Nombre: ', default: '')
  coworker[:email] = prompt.ask('Email: ', default: '')
  coworker[:phone] = prompt.ask('Telefono: ', default: '')
  coworker[:role] = prompt.ask('Rol: ', default: '')

  $coworkers.push(coworker)

  $tasks.push(task)
  saveData('./data/tasks.json', JSON.generate($tasks))

  # [Estilo] Aplicando color al texto
  pastel = Pastel.new
  puts pastel.green('Tarea agregada')
end