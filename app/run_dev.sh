#!/usr/bin/env bash

NODE_ENV=dev 
NODE_PATH=modules 

grunt && grunt watch &

nodemon -w config -w modules -w app.coffee -w lib -i modules/webserver/frontend -i modules/webserver/public app.coffee

