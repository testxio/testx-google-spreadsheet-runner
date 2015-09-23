_                   = require 'underscore'
q                   = require 'q'
GoogleSpreadsheets  = require 'google-spreadsheets'
testx               = require 'testx'

exports.runGoogleSpreadsheet = runner = (spreadSheetKey, sheetName, context) ->
  flow = protractor.promise.controlFlow()
  flow.execute(-> getScript(spreadSheetKey, sheetName)).then (script) =>
    console.log 'script', JSON.stringify(script, undefined, 2)
    console.log JSON.stringify(script, undefined, 2) if browser.params.testx.logScript
    testx.runScript script, context

getScript = (spreadSheetKey, sheetName) ->
  deferred = q.defer()
  GoogleSpreadsheets {key: spreadSheetKey}, (err, spreadsheet) ->
    for worksheet in spreadsheet.worksheets when not sheetName or worksheet.title == sheetName
      worksheet.cells null, (err, data) ->
        deferred.resolve steps: getSteps data.cells
  deferred.promise

getSteps = (grid) ->
  steps = []
  for rowIndex of grid
    columns = grid[rowIndex]
    if columns[1]
      [match, name, ignore, comment] = /([^\[|\]]*)(\[(.*)\])?/.exec columns[1].value
      steps.push x =
        name: name.trim()
        arguments: mergeObjectArray (getArguments rowIndex, grid)
        meta:
          Row: rowIndex
          "Full name": columns[1].value
          Comment: comment?.trim() or ''
  steps

getArguments = (keyWordRowIndex, grid) ->
  argNameColumns = grid[keyWordRowIndex - 1]
  argValueColumns = grid[keyWordRowIndex]
  (keyValueObject argNameColumns[colIdx].value, colValue(argValueColumns[colIdx]) for colIdx of argNameColumns when colIdx > 1)

colValue = (col) -> if col then col.value else ''
keyValueObject = (key, value) -> obj = {}; obj[key] = value; obj;
mergeObjectArray = (objectArray, dest = {}) ->
  _.extend dest, obj for obj in objectArray
  dest
