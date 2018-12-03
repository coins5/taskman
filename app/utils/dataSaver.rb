def saveData (path, data)
  f = File.new(path, 'w')
  f.write(data)
  f.close
end