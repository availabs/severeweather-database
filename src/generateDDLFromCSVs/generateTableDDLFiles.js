#!/usr/bin/env node

const { writeFile, readdir, lstat, existsSync } = require('fs');
const { exec } = require('child_process');
const { promisify } = require('util');
const { join } = require('path');
const { sync: mkdirpSync } = require('mkdirp');

const DATA_DIR = join(__dirname, '../../data/');

const SQL_DIR = join(__dirname, '../../generated-sql/');

const writeFileAsync = promisify(writeFile);
const readdirAsync = promisify(readdir);
const lstatAsync = promisify(lstat);

async function generateDDL() {
  const dirs = await readdirAsync(DATA_DIR);

  for (let i = 0; i < dirs.length; ++i) {
    const tableName = dirs[i];

    const csvDir = join(DATA_DIR, tableName);

    const sqlDir = join(SQL_DIR, tableName);
    if (existsSync(sqlDir)) {
      console.log(`${tableName} SQL exists.`);
      continue;
    }

    mkdirpSync(sqlDir);

    const dropTableFilePath = join(sqlDir, `drop_${tableName}.sql`);

    const dropTableSQL = `DROP TABLE IF EXISTS ${tableName} CASCADE;`;

    await writeFileAsync(dropTableFilePath, dropTableSQL);

    const fileNames = (await readdirAsync(csvDir)).filter(n =>
      n.match(/\.gz$/)
    );

    const fileStats = await Promise.all(
      fileNames.map(async f => await lstatAsync(join(csvDir, f)))
    );

    const idxOfLargestCSV = Array.from(Array(fileStats.length).keys()).reduce(
      (prev, cur) => (fileStats[prev].size > fileStats[cur].size ? prev : cur),
      0
    );

    const largestCSVName = fileNames[idxOfLargestCSV];
    const largestCSVPath = join(csvDir, largestCSVName);

    const createTableSQL = await new Promise((resolve, reject) => {
      exec(
        `
      gunzip -c ${largestCSVPath} |\
      head -n 10000 |\
      sed '/^#.* .*$/d; s/#//g;' |\
      csvsql -i postgresql |\
      sed 's/\\("[A-Z_0-9]\\+"\\)/\\L\\1/; s/\\"//g'
    `,
        (err, stdout) => {
          if (err) {
            return reject(err);
          }

          return resolve(stdout);
        }
      );
    });

    const createTableFilePath = join(sqlDir, `create_${tableName}.sql`);
    await writeFileAsync(createTableFilePath, createTableSQL);
    console.log(`${tableName} DONE`);
  }
}

generateDDL();
