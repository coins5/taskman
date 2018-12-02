def loadInitialFiles ()
  tree = {
    'data' => [
      ['coworkers.json', JSON.generate($coworkers)], # Load default data if not exists
      ['taskPriorities.json', JSON.generate($taskPriorities)], # Load default data if not exists
      ['taskStatus.json', JSON.generate($taskStatus)], # Load default data if not exists
      ['personalInfo.json', JSON.generate($personalInfo)] # Load default data if not exists
    ]
  }
  TTY::File.create_dir(tree, skip:true, verbose: false, force: true)
end

def loadFile (path)
  linesInFile = ''
  File.open(path, "r") do |f|
    f.each_line do |line|
      linesInFile += line
    end
  end
  return linesInFile
end

def loadApp()
  # Cargando archivos y carpetas iniciales
  loadInitialFiles()
 
  # [Estilo] Aplicando estilo para esta ejecucion
  spinner = TTY::Spinner.new("[:spinner] Verificando archivos de datos")
  loadInitialFiles()
  $coworkers = JSON.parse(loadFile('./data/coworkers.json'))
  $taskPriorities = JSON.parse(loadFile('./data/taskPriorities.json'))
  $taskStatus = JSON.parse(loadFile('./data/taskStatus.json'))
  $personalInfo = JSON.parse(loadFile('./data/personalInfo.json'))
  # [Estilo] Aplicando color al texto
  pastel = Pastel.new
  spinner.success(pastel.green('(listo)'))

end
