require 'tty-prompt'

def mainMenu ()
  prompt = TTY::Prompt.new
  
  choices = [
    {name: 'Tareas', value: 'tasks'},
    {name: 'Configuracion de sistema', value: 'sysConfig'},
    {name: 'Salir', value: 'exit'}
  ]

  selected = prompt.select("Menu principal", choices)

  if (selected == 'sysConfig') 
    systemConfig()
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
    {name: 'Usuarios', value: 'users'},
    {name: 'Atras', value: 'back'}
  ]

  selected = prompt.select("Configuracion de sistema", choices)

  if (selected == 'back')
    mainMenu()
  end
end