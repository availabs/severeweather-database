#!/usr/bin/env node

/* eslint no-unused-expressions: 0, camelcase: 0 */

const { spawn } = require('child_process');

const yargs = require('yargs');

yargs
  .parserConfiguration({
    'camel-case-expansion': false,
    'flatten-duplicate-arrays': false
  })
  .option({
    pg_env: {
      type: 'string',
      demand: false,
      choices: ['production', 'development'],
      default: 'development'
    }
  })
  .command({
    command: 'scrape_storm_events_details',
    desc:
      "Download the specified country's shapefile for the specified conflation year",
    builder: {
      dataStartYear: {
        type: 'date',
        demand: false,
        desc: 'Data startYear',
        default: 1990
      },
      dataEndYear: {
        type: 'date',
        demand: false,
        desc: 'Data startYear',
        default: new Date().getFullYear()
      },
      updatedSince: {
        type: 'date',
        demand: false,
        desc: 'Date in YYYY-MM-DD format.',
        default: null
      }
    },
    handler: ({ startYear, updatedSince }) => {
      spawn(
        './src/noaa-storm-events-scraper/scraper.js',
        [`"${startYear} ${updatedSince}"`],
        {
          cwd: __dirname,
          stdio: 'inherit'
          // env: { YEAR: year, COUNTRY: country, PG_ENV: pg_env }
        }
      );
    }
  })
  .demandCommand()
  .recommendCommands()
  .strict()
  .wrap(yargs.terminalWidth() / 1.618).argv;
