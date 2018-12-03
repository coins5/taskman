def showProfile ()
  puts "---------------------------------"
  puts "Nombre: " + $personalInfo["name"]
  puts "Email: " + $personalInfo["email"]
  puts "Telefono: " + $personalInfo["phone"]
  puts "Rol: " + $personalInfo["role"]
  puts "---------------------------------"
  showProfileMenu()
end

def editProfile()
  prompt = TTY::Prompt.new
  $personalInfo["name"] = prompt.ask('Nombre: ', '', default: $personalInfo["name"])
  $personalInfo["email"] = prompt.ask('Email: ', '', default: $personalInfo["email"])
  $personalInfo["phone"] = prompt.ask('Telefono: ', '', default: $personalInfo["phone"])
  $personalInfo["role"] = prompt.ask('Rol: ', '', default: $personalInfo["role"])

  saveData('./data/personalInfo.json', JSON.generate($personalInfo))
  
  # [Estilo] Aplicando color al texto
  pastel = Pastel.new
  puts pastel.green('Informacion personal cambiada')
  # showProfile()
  showProfileMenu()
end

def showProfileMenu()
  prompt = TTY::Prompt.new

  choices = [
    # TODO: Menu para cambiar ubicacion de archivos. Util en un futuro
    # {name: 'Ubicacion de archivos', value: 'files'},
    {name: 'Editar informacion', value: 'editProfile'},
    {name: 'Atras', value: 'back'}
  ]
  selected = prompt.select("Perfil de usuario", choices)

  if (selected == 'back')
    return systemConfig()
  end

  if (selected == 'editProfile')
    return editProfile()
  end
end