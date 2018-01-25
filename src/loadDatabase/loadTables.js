#!/usr/bin/env node

const { promisify } = require('util');
const { join, basename } = require('path');
const { exec } = require('child_process');
const { readdir } = require('fs');
const findit = require('findit');

const CSV_DIR = join(__dirname, '../../data/');

const MAX_NUM_DB_CONNECTIONS = 10;

var cleanExit = function() {
  process.exit();
};
process.on('SIGINT', cleanExit); // catch ctrl-c
process.on('SIGTERM', cleanExit); // catch kill

const envFile = require('node-env-file');
envFile(join(__dirname, '../../config/postgres.env'));

const pgEnv = Object.keys(process.env)
  .filter(k => k.match(/^PG/))
  .reduce((acc, k) => {
    acc[k] = process.env[k];
    return acc;
  }, {});

const execOptions = { env: pgEnv };

const finder = findit(CSV_DIR);

finder.on('file', (file, stat) => {
  if (file.match(/.gz$/)) {
    createTable(file);
  }
});

const semaphore = (function() {
  let available = MAX_NUM_DB_CONNECTIONS;
  const queue = [];

  function releaser() {
    let executed = false;
    return () => {
      if (!executed) {
        executed = true;
        ++available;
        process.nextTick(manageQueue);
      }
    };
  }

  function manageQueue() {
    if (available) {
      const res = queue.shift();

      if (res) {
        --available;
        process.nextTick(() => res(releaser()));
      }
    }
  }

  return {
    aquire: async () =>
      new Promise(resolve => {
        queue.push(resolve);
        manageQueue();
      })
  };
})();

async function createTable(filePath) {
  const fileName = basename(filePath);
  const fileNameRE = new RegExp(`/${fileName}`);
  const dirName = basename(filePath.replace(fileNameRE, ''));
  const tableName = dirName.replace(/-/, '_');

  const release = await semaphore.aquire();
  exec(
    `
    gunzip -c "${filePath}" |\
    sed '/^#.* .*$/d; s/^#//g; s/\\"\\"//g' |\
    psql -c "COPY ${tableName} FROM STDIN CSV HEADER"`,
    execOptions,
    (err, stdout, stderr) => {
      if (err) {
        console.log('ERROR');
        console.error(err);
        process.exit(1);
      }

      release();
      console.log(`===== Loaded ${fileName} into ${tableName} =====`);
      if (stdout) {
        console.log(stdout);
      }

      if (stderr) {
        console.log(stderr);
      }
    }
  );
}
