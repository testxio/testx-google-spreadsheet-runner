# testx-google-spreadsheet-runner
Google Spreadsheet Runner for [TestX](https://github.com/greyarch/testx)

## Installation

    npm i testx-google-spreadsheet-runner --save

## How to use

First of all, you need to know how to create and run a TestX test project. If you don't know how, check out the the TestX documentation.

To use test scripts from a Google spreadsheet, import the runner:

    runner = require 'testx-google-spreadsheet-runner'

Then, create a normal Jasmine test and pass the id of the spreadsheet to the runner:

    describe 'Google search', ->
      it 'should display relevant results', ->
        runner.runGoogleSpreadsheet '1xLNhRCq3BuOA2Ve7C8xRcM7VpmeCgKv4Bkyhd494T7I'

or to run only one specific sheet:

    describe 'Google search', ->
      it 'should display relevant results', ->
        runner.runGoogleSpreadsheet '1xLNhRCq3BuOA2Ve7C8xRcM7VpmeCgKv4Bkyhd494T7I', 'Sheet2'

The following spreadsheet is used in both examples: https://docs.google.com/spreadsheets/d/1xLNhRCq3BuOA2Ve7C8xRcM7VpmeCgKv4Bkyhd494T7I.

## Caveat

Currently the runner only supports public spreadsheets as authentication is not yet implemented. Make sure your spreadsheets are public by publishing them to the web (File -> Publish to web).
