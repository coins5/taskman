def loadApp()
  # Cargando archivo de configuracion
  config = TTY::Config.new
  config.filename = 'config'
  config.extname = '.json'
  config.append_path(Dir.pwd)
  begin
    config.read()
  rescue
    puts "Archivo config.json no existe. Creando uno nuevo"
  end
  # [Estilo] Aplicando estilo para esta ejecucion
  spinner = TTY::Spinner.new("[:spinner] Verificando que exista directorio de datos. Caso contrario, crear uno nuevo")
  # Comprobando que el atributo "dataDirectory" exista, caso contrario, usar el valor "./data" por defecto 
  config.set_if_empty(:dataDirectory, value: './data')
  # Esta funcion determina si creara o no el directorio "./data"
  TTY::File.create_dir( config.fetch(:dataDirectory), verbose: false )
  # [Estilo] Aplicando color al texto
  pastel = Pastel.new
  spinner.success(pastel.green('(listo)'))


  # [Estilo] Aplicando estilo para esta ejecucion
  spinner = TTY::Spinner.new("[:spinner] Verificando datos de Status")
  # Comprobando que el atributo "taskStatus" exista, caso contrario, usar el valor de la variable global $taskStatus 
  config.set_if_empty(:taskStatus, value: $taskStatus)
  # Cargando los datos a la variable global $taskStatus 
  $taskStatus = config.fetch(:taskStatus)
  # [Estilo] Aplicando color al texto
  pastel = Pastel.new
  spinner.success(pastel.green('(listo)'))

  
  # [Estilo] Aplicando estilo para esta ejecucion
  spinner = TTY::Spinner.new("[:spinner] Verificando datos de prioridades")
  # Comprobando que el atributo "taskPriorities" exista, caso contrario, usar el valor de la variable global $taskPriorities
  config.set_if_empty(:taskPriorities, value: $taskPriorities)
  # Cargando los datos a la variable global $taskPriorities
  $taskPriorities = config.fetch(:taskPriorities)
  # [Estilo] Aplicando color al texto
  pastel = Pastel.new
  spinner.success(pastel.green('(listo)'))

  # Sobreescribir la configuracion del programa
  config.write(force: true)
end
