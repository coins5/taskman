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

def systemConfig ()
  prompt = TTY::Prompt.new

  choices = [
    # TODO: Menu para cambiar ubicacion de archivos. Util en un futuro
    # {name: 'Ubicacion de archivos', value: 'files'},
    {name: 'Companeros de trabajo', value: 'coworkers'},
    {name: 'Informacion personal', value: 'profile'},
    {name: 'Atras', value: 'back'}
  ]

  selected = prompt.select("Configuracion de sistema", choices)

  if (selected == 'back')
    return mainMenu()
  end

  if (selected == 'profile')
    return showProfile()
  end
  
  if (selected == 'coworkers')
    return coworkersMenu()
  end

end
