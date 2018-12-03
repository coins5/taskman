=begin
    Valores por defecto de la aplicacion.
    Solo se cargaran estos valores si no existen en config.json
=end

$tasks = [] # Ejemplo: {id: 'JSncsnui2udna', title: 'Agregar cosas', description: 'long description', coworker: 1, priority: 1, status: 0, created: 'yyyymmdd', expires: 'yyymmdd', dependencies: [tasksIds]}, ...
$coworkers = [] # Ejemplo: {id: 'kja8sdjhas98dh', name: 'Pepito', email: 'pepito@yopmail.com', phone: '+51922913739', role: 'developer'}
$taskStatus = [{id: 0, name: 'En espera'}, {id: 1, name: 'En proceso'}, {id: 2, name: 'Terminado'}]
$taskPriorities = [{id: 0, name: 'Baja'}, {id: 1, name: 'Media'}, {id: 2, name: 'Alta'}]
$personalInfo = {id: 0, name: 'Me', email: 'me@example.com', phone: '+51922913739', role: 'developer'}
