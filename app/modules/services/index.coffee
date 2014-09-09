CronService = require "./cron_jobs/server"


#cron jobs
cron = new CronService()
cron.run()

module.exports.CronService = cron
