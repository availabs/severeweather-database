#!/usr/bin/env node

const { writeFile, readdir, lstat, existsSync } = require('fs');
const { exec } = require('child_process');
const { promisify } = require('util');
const { join } = require('path');
const { sync: mkdirpSync } = require('mkdirp');

const DATA_DIR = join(__dirname, '../../data/');

// For safety, writes to a temporary directory
// After edits made, user should manually move them to sql/dir
//  and remove the tmp dir
const TMP_SQL_DIR = join(__dirname, '../../tmp-generated-sql/');

const writeFileAsync = promisify(writeFile);
const readdirAsync = promisify(readdir);
const lstatAsync = promisify(lstat);

async function generateDDL() {
  const dirs = await readdirAsync(DATA_DIR);

  for (let i = 0; i < dirs.length; ++i) {
    const dirName = dirs[i];
    const tableName = dirName.replace(/-/g, '_');

    const csvDir = join(DATA_DIR, dirName);

    const sqlDir = join(TMP_SQL_DIR, tableName);
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
      // The create table SQL pipeline:
      //   1. inflate the gzipped file and pipe to stdout
      //   2. take only the first 10K lines
      //   3. Remove the comments before the header line (Comments contain whitespace)
      //        & remove the hash from before the header line
      //   4. Use csvsql to generate a draft create table ddl statement
      //   5. In the generated DDL,
      //        a. change the column names to lowercase
      //        b. remove the quotes
      //        c. remove the size contraints on VARCHARs
      //        d. remove the size contraints on VARCHARs

      // csvsql -i postgresql --tables ${tableName} |\
      // sed 's/\\("[A-Z_0-9]\\+"\\)/\\L\\1/; s/\\"//g; s/([0-9]\\+)//g; s/ NOT NULL//g'

      exec(
        `
        cat \
          <(gunzip -c ${largestCSVPath} | sed '/^#.* .*$/d; s/#//g;' | head -n1) \
          <(for f in *.gz; do gunzip -c "$f" | sed '/^#.* .*$/d' | tail -n+2 | head -n10000; done) |\
        csvsql -i postgresql --tables ${tableName} --no-constraints |\
        sed 's/\\("[A-Z_0-9]\\+"\\)/\\L\\1/; s/\\"//g;'
        `,
        { shell: '/bin/bash', cwd: csvDir },
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
