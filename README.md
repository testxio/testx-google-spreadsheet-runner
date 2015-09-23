# testx-google-spreadsheet-runner
Google Spreadsheet Runner for [TestX](https://github.com/greyarch/testx)

## Installation

    npm i testx-google-spreadsheet-runner --save

## How to use

First of all, you need to know how to create and run a TestX test project. If you don't know how, check out the the TestX documentation.

To use test scripts from a Google spreadsheet, import the runner:

    runner = require 'testx-google-spreadsheet-runner'

Then, create a normal Jasmine test:

    describe 'Google search', ->
      it 'should display relevant results', ->
        runner.runGoogleSpreadsheet '1xLNhRCq3BuOA2Ve7C8xRcM7VpmeCgKv4Bkyhd494T7I'

or to run only one specific sheet:

    describe 'Google search', ->
      it 'should display relevant results', ->
        runner.runGoogleSpreadsheet '1xLNhRCq3BuOA2Ve7C8xRcM7VpmeCgKv4Bkyhd494T7I', 'Sheet2'
