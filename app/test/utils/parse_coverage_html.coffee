fs = require('fs')
lineReader = require('line-reader')

html = ""
record = false

lineReader.eachLine('test/coverage/coverage.html', (line) ->
  if line.match(/^<!DOCTYPE html>/)
    record = true
    
  if record
    html += line
    
).then(() ->
  fs.writeFile('test/coverage/coverage.html', html, (err) ->
    if err
      process.exit(1)
    else
      process.exit(0)
  )
) 
