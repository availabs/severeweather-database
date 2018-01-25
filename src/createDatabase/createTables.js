#!/usr/bin/env node

const { promisify } = require('util');
const { join, basename } = require('path');
const { exec } = require('child_process');
const { readdir } = require('fs');
const findit = require('findit');

const SQL_DIR = join(__dirname, '../../sql/');

const envFile = require('node-env-file');
envFile(join(__dirname, '../../config/postgres.env'));

const pgEnv = Object.keys(process.env)
  .filter(k => k.match(/^PG/))
  .reduce((acc, k) => {
    acc[k] = process.env[k];
    return acc;
  }, {});

const execOptions = { env: pgEnv };

const finder = findit(SQL_DIR);

finder.on('file', (file, stat) => {
  const fileName = basename(file);
  if (fileName.match(/^create/)) {
    createTable(file);
  }
});

function createTable(filePath) {
  exec(`psql -f "${filePath}"`, execOptions, (err, stdout, stderr) => {
    if (err) {
      console.log('ERROR');
      console.error(err);
      process.exit(1);
    }

    if (stdout) {
      console.log(stdout);
    }

    if (stderr) {
      console.log(stderr);
    }
  });
}
