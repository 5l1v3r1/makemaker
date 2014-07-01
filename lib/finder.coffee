fs = require 'fs'
path = require 'path'
env = require './environment'

class Finder
  constructor: ->
    @cppSources = []
    @cSources = []
    @asmSources = []
  
  search: (dir) ->
    return if not fs.existsSync dir
    files = fs.readdirSync dir
    for file in files
      continue if file[0] is '.'
      newPath = path.join dir, file
      if fs.lstatSync(newPath).isDirectory()
        @search newPath
      else
        @found newPath
  
  found: (fullPath) ->
    ext = path.extname fullPath
    assoc =
      '.c': @cSources
      '.cc': @cppSources
      '.cpp': @cppSources
      '.s': @asmSources
    assoc[ext]?.push? fullPath

module.exports = Finder
