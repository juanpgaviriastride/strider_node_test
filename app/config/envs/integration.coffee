module.exports = {
  "debug": true
  "auth_token_secret": "8SAvCBIR1XV2DL6Aay4bvF1P1RUBWTLb3YJBU8ER",
  "app": {
    "baseUrl": "http://localhost:3000/"
    "host": "localhost",
    "port": 3000
  },
  "media_root": 'modules/webserver/public/userdata',
  "media_url": 'userdata',
  "mongo": {
    "host": "162.209.94.221",
    "port": 27017,
    "db": "cs_integration"
  },
  "redis": {
    "host": "162.209.94.221",
    "port": 6379,
    "options": {
      "auth": "adfbb423-a9af-4494-9ee0-418c707f4457"
    }
  },
  "mail": {
    "apiUser" : "contextsurgery",
    "apiKey"  : "abc123qwerty"
  }
  "elasticsearch": {
    "hosts": [{
      host: "162.209.94.221",
      "port": 9200
    }]
    "index_name": "cs_integration"
  },
  "google_maps": {
    "key": "AIzaSyDNls3JPEGa3uPSCjdPEzEvtkURk5PRWjc"
  },
}
