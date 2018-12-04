def coworkersMenu ()
  prompt = TTY::Prompt.new

  choices = []
  # Si no hay companeros de trabajo, estas opciones no haran nada
  # Es mejor ocultarlas hasta tener algo que mostrar
  if ($coworkers.length > 0)
    choices.push({name: 'Mostrar companeros de trabajo', value: 'showCoworkers'})
    choices.push({name: 'Buscar companeros de trabajo', value: 'searchCoworker'})
    choices.push({name: 'Editar informacion de companeros de trabajo', value: 'editCoworkers'})
  end
  choices.push({name: 'Agregar companero de trabajo', value: 'addCoworker'})
  choices.push({name: 'Atras', value: 'back'})

  # TODO: Menu para cambiar ubicacion de archivos. Util en un futuro
  #choices.push({name: 'Ubicacion de archivos', value: 'files'})

  selected = prompt.select("Companeros de trabajo", choices)

  if (selected == 'back')
    return systemConfig()
  end

  if (selected == 'addCoworker')
    return addCoworker()
  end

  if (selected == 'showCoworkers')
    return showCoworkers()
  end

  if (selected == 'searchCoworker')
    return searchCoworker()
  end

  if (selected == 'editCoworkers')
    return editCoworkers()
  end
end

def addCoworker ()
  coworker = {}

  prompt = TTY::Prompt.new

  coworker["id"] = SecureRandom.uuid
  coworker["name"] = prompt.ask('Nombre: ', default: '')
  coworker["email"] = prompt.ask('Email: ', default: '')
  coworker["phone"] = prompt.ask('Telefono: ', default: '')
  coworker["role"] = prompt.ask('Rol: ', default: '')

  $coworkers.push(coworker)
  saveData('./data/coworkers.json', JSON.generate($coworkers))

  # [Estilo] Aplicando color al texto
  pastel = Pastel.new
  puts pastel.green('Companero de trabajo agregado')

  coworkersMenu()
end

def editCoworkers ()
  prompt = TTY::Prompt.new

  coworkersList = []
  for i in 0..$coworkers.length-1
    c = $coworkers[i]
    coworkersList.push({
      name: c["name"] + " (" + c["email"] + ")",
      value: c["id"]
    })
  end

  # Ordenamiento
  coworkersList = orderCoworkers(coworkersList, :name)

  coworkerID = prompt.select('Seleccione un trabajador', coworkersList, filter: true)

  # Busqueda lineal en array temporal coworkersList
  for i in 0..$coworkers.length-1
    c = $coworkers[i]
    if (c["id"] == coworkerID)
      $coworkers[i]["name"] = prompt.ask('Nombre: ', default: $coworkers[i]["name"])
      $coworkers[i]["email"] = prompt.ask('Email: ', default: $coworkers[i]["email"])
      $coworkers[i]["phone"] = prompt.ask('Telefono: ', default: $coworkers[i]["phone"])
      $coworkers[i]["role"] = prompt.ask('Rol: ', default: $coworkers[i]["role"])
      
      saveData('./data/coworkers.json', JSON.generate($coworkers))

      # [Estilo] Aplicando color al texto
      pastel = Pastel.new
      puts pastel.green('Companero de trabajo editado')

      return coworkersMenu()
      
    end
  end
end

def searchCoworker ()
  prompt = TTY::Prompt.new

  choices = []
  choices.push({name: 'Nombre', value: 'name'})
  choices.push({name: 'Email', value: 'email'})
  choices.push({name: 'Telefono', value: 'phone'})
  choices.push({name: 'Rol', value: 'role'})
  choices.push({name: 'Ir al menu anterior', value: 'back'})

  selected = prompt.select("Buscar por: ", choices)
  if (selected == "back")
    return coworkersMenu()
  end

  queryText = prompt.ask('Valor a buscar: ', default: '')

  # Busqueda lineal
  result = []
  for i in 0..$coworkers.length-1
    c = $coworkers[i]
    if (c[selected].index(queryText) != nil)
      result.push(c)
    end
  end

  # Ordenamiento
  orderCoworkers(result, selected)

=begin
  Esta parte se puede hacer con un bucle normal,
  pero para la calificacion utilizaremos:
    - Una lista doblemente enlazada
    - Una funcion recursiva para recorrer la lista
=end

  coworkersList =  createCoworkersList(result)
  listCoworkersRecursive(coworkersList)
  searchCoworker()
end

#FIXME: Debe ser case insensitive
def orderCoworkers (arr, field)
  for i in 0..arr.length-2
    for j in (i+1)..arr.length-1
      if (arr[i][field] > arr[j][field] )
        arr[i], arr[j] = arr[j], arr[i]
      end
    end
  end
  return arr
end

def showCoworkers ()
=begin
  Esta parte se puede hacer con un bucle normal,
  pero para la calificacion utilizaremos:
    - Una lista doblemente enlazada
    - Una funcion recursiva para recorrer la lista
=end
  # Creando lista a partir del array global $coworkers
  coworkersList =  createCoworkersList($coworkers)
  # listCoworkers(coworkersList) # Recorrido normal
  listCoworkersRecursive(coworkersList) # Recorrido recursivo
  coworkersMenu()
end

def createCoworkersList(arr)
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

def listCoworkers(list)
  if (list == nil)
    return nil
  end

  # Obteniendo el primer valor y nodo de la lista
  nodo = list[2]
  valor = list[1]
  ultimoNodo = nil
  while (nodo != nil)      
    printCoworkerData(valor)
    ultimoNodo = nodo
    valor = nodo[1]
    nodo = nodo[2]
      
  end
  # Imprimiendo el ultimo valor
  printCoworkerData(valor)
end

def listCoworkersRecursive(list)
  if (list == nil)
    return nil
  end
  nextCoworker(list)
end

def nextCoworker (nodo)
  valor = nodo[1]
  nodo = nodo[2]
  printCoworkerData(valor)
  if (nodo != nil)
    nextCoworker(nodo)
  end
end

def printCoworkerData(coworker)
  puts "---------------------------------"
  puts "Codigo: " + coworker["id"]
  puts "Nombre: " + coworker["name"]
  puts "Email: " + coworker["email"]
  puts "Telefono: " + coworker["phone"]
  puts "Rol: " + coworker["role"]
  puts "---------------------------------"
end
