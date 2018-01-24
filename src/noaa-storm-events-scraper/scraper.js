#!/usr/bin/env node

const { createWriteStream } = require('fs');
const { join } = require('path');
const { sync: mkdirpSync } = require('mkdirp');

const CONFIG = require('./config.json');

const STORM_EVENTS_DIR = 'pub/data/swdi/stormevents/csvfiles';

const DATA_DIR = join(__dirname, '../../data/');

const SE_DIR = join(DATA_DIR, 'stormevents');

const SE_DETAILS_DIR = join(DATA_DIR, 'details');
const SE_FATALITIES_DIR = join(DATA_DIR, 'fatalities');
const SE_LOCATIONS_DIR = join(DATA_DIR, 'locations');

mkdirpSync(SE_DETAILS_DIR);
mkdirpSync(SE_FATALITIES_DIR);
mkdirpSync(SE_LOCATIONS_DIR);

const eventToDir = {
  details: SE_DETAILS_DIR,
  fatalities: SE_FATALITIES_DIR,
  locations: SE_LOCATIONS_DIR
};

const eventRE = new RegExp(Object.keys(eventToDir).join('|'));

var Client = require('ftp');

var c = new Client();

async function scrapeEventsCSVs() {
  await new Promise((resolve1, reject1) => {
    c.list(STORM_EVENTS_DIR, async function(err, list) {
      if (err) return reject1(err);

      for (let i = 0; i < list.length; ++i) {
        const file = list[i];

        if (!(file.name && file.name.match)) {
          continue;
        }

        const dir = eventToDir[file.name.match(eventRE)];

        if (!dir) {
          continue;
        }

        const yearMatch = file.name.match(/_d(\d{4})/);
        const year = yearMatch && parseInt(yearMatch[1]);

        if (dir && year >= 1990) {
          const ftpPath = join(STORM_EVENTS_DIR, file.name);
          const csvPath = join(dir, file.name);

          console.log(file.name);

          await new Promise((resolve2, reject2) => {
            c.get(ftpPath, function(err, stream) {
              if (err) {
                console.error(err);
                process.exit(1);
              }

              stream.once('close', function() {
                setTimeout(resolve2, 500);
              });
              stream.pipe(createWriteStream(csvPath));
            });
          });
        }
      }
      resolve1();
    });
  });
}

c.on('ready', async function() {
  await scrapeEventsCSVs();
  c.end();
});

c.connect(CONFIG);
