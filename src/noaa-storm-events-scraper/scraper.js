#!/usr/bin/env node

/* eslint no-await-in-loop: 0, no-console: 0 */

const { createWriteStream } = require('fs');
const { join } = require('path');
const yargs = require('yargs');
const { sync: mkdirpSync } = require('mkdirp');

const { argv } = yargs
  .strict()
  .parserConfiguration({
    'camel-case-expansion': false,
    'flatten-duplicate-arrays': false
  })
  .wrap(yargs.terminalWidth() / 1.618)
  .option({
    dataStartYear: {
      type: 'number',
      demand: false,
      desc: 'Data startYear',
      default: 1990
    },
    dataEndYear: {
      type: 'number',
      demand: false,
      desc: 'Data startYear',
      default: new Date().getFullYear()
    },
    updatedSince: {
      type: 'string',
      demand: false,
      desc: 'Date in YYYY-MM-DD format.',
      default: null
    }
  });

const { dataStartYear, dataEndYear, updatedSince } = argv;

const CONFIG = require('./config.json');

const STORM_EVENTS_DIR = 'pub/data/swdi/stormevents/csvfiles';

const DATA_DIR = join(__dirname, '../../data/');

const SE_DETAILS_DIR = join(DATA_DIR, 'details');

mkdirpSync(SE_DETAILS_DIR);

const Client = require('ftp');

const c = new Client();

const updatedSinceDate =
  updatedSince && new Date(`${updatedSince}T00:00:00.000Z`);
if (updatedSinceDate && Number.isNaN(updatedSinceDate.valueOf())) {
  console.error(`INVALID updatedSince: ${updatedSince}`);
  process.exit(1);
}

async function scrapeEventsCSVs() {
  const list = await new Promise((resolve, reject) => {
    c.list(STORM_EVENTS_DIR, (err, d) => {
      if (err) {
        return reject(err);
      }

      return resolve(d);
    });
  });

  const details = list.filter(({ name, date }) => {
    const isDetailsFile = name.match(/StormEvents_details-ftp/);
    const dataRecentEnough = date >= updatedSinceDate;
    const [, yearMatch] = name.match(/_d(\d{4})/) || [];
    const year = yearMatch && Number.parseInt(yearMatch, 10);
    const withinYearRange = year >= dataStartYear && year <= dataEndYear;

    return isDetailsFile && dataRecentEnough && withinYearRange;
  });

  console.table(details.map(({ name, date, size }) => ({ name, date, size })));

  for (let i = 0; i < details.length; ++i) {
    const file = details[i];
    const ftpPath = join(STORM_EVENTS_DIR, file.name);
    const csvPath = join(SE_DETAILS_DIR, file.name);

    console.log(file.name);

    await new Promise((resolve, reject) => {
      c.get(ftpPath, (err, stream) => {
        if (err) {
          return reject(err);
        }

        stream.once('close', () => setTimeout(resolve, 500));

        stream.pipe(createWriteStream(csvPath));

        return null;
      });
    });
  }
}

c.connect(CONFIG);

c.on('ready', async () => {
  await scrapeEventsCSVs();
  c.end();
});
