# gems
require 'tty-config'
require 'tty-spinner'
require 'pastel'

def createDirectory (path)
  require 'tty-file'
  TTY::File.create_dir(path)
end

def loadApp()
  # Cargando archivo de configuracion
  config = TTY::Config.new
  config.filename = 'config'
  config.extname = '.json'
  config.append_path(Dir.pwd)
  config.read()
  
  # [Estilo] Aplicando estilo para esta ejecucion
  spinner = TTY::Spinner.new("[:spinner] Verificando que exista directorio de datos. Caso contrario, crear uno nuevo")
  # Comprobando que el atributo "dataDirectory" exista, caso contrario, usar el valor "./data" por defecto 
  config.set_if_empty(:dataDirectory, value: './data')
  # Esta funcion determina si creara o no el directorio "./data"
  createDirectory( config.fetch(:dataDirectory) )
  # [Estilo] Aplicando color al texto
  pastel = Pastel.new
  spinner.success(pastel.green('(listo)'))

  # Sobreescribir la configuracion del programa
  config.write(force: true)
end
