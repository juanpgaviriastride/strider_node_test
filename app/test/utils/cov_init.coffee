path = require("path")

if process.env.COVERAGE 
    require('coffee-coverage').register({
        path: 'abbr',
        basePath: path.join(__dirname, "../../modules"),
        exclude: [path.join(__dirname, "../../test"), path.join(__dirname, "../../node_modules"), path.join(__dirname, "../../.git")],
        initAll: true,
    })
