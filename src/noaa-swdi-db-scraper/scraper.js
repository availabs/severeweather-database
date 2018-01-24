#!/usr/bin/env node

const { createWriteStream } = require('fs');
const { join } = require('path');
const { sync: mkdirpSync } = require('mkdirp');

const CONFIG = require('./config.json');

const SWDI_DATABASE_DIR = 'pub/data/swdi/database-csv/v2/';

const DATA_DIR = join(__dirname, '../../data/');

const SE_DIR = join(DATA_DIR, 'swdi-db');

var Client = require('ftp');

var c = new Client();

async function scrapeEventsCSVs() {
  await new Promise((resolve1, reject1) => {
    c.list(SWDI_DATABASE_DIR, async function(err, list) {
      if (err) return reject1(err);

      for (let i = 0; i < list.length; ++i) {
        const file = list[i];

        if (!(file.name && file.name.match)) {
          continue;
        }

        const dir = file.name.replace(/-\d{4}.*/, '');

        if (!dir) {
          continue;
        }

        const yearMatch = file.name.match(/-(\d{4})/);
        const year = yearMatch && parseInt(yearMatch[1]);

        if (dir && year >= 1990) {
          const ftpPath = join(SWDI_DATABASE_DIR, file.name);
          const csvPath = join(DATA_DIR, dir, file.name);

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

              mkdirpSync(join(DATA_DIR, dir));

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
