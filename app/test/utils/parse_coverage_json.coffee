lineReader = require('line-reader')

coverage = 0

lineReader.eachLine('test/coverage/coverage.json', (line, last) ->
  if line.match(/.coverage.:/)
    coverage = parseFloat(line.replace(/.*:/, ''))
    console.log "Coverage: #{coverage}"
    process.exit(0)
)
