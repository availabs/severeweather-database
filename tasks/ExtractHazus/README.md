# What

This task migrates the Hazus data from the MS SQLServer database to PostgreSQL using pgloader.

# Usage

## 1. Create the pgloader docker image

```
./hazus_pgloader/buildIt.sh
```

## 2. Start the MSSQL docker container

```
./bin/start-SQLServer.sh
```

## 3. Mount the Hazus mdf file.

```
./bin/lib/mountHazusDBFile.SQLServer.NY.sh
```

## 4. Start the PostgreSQL docker container

```
./bin/start-Postgis.sh
```

## 5. Migrate the data

```
./bin/transferData.sh
```

## 6. Shut down the MSSQL & PostgreSQL containers

```
./bin/stop-SQLServer.sh
./bin/stop-Postgis.sh
```

# References

* [SQL Server on Docker](https://docs.microsoft.com/en-us/sql/linux/quickstart-install-connect-docker?view=sql-server-linux-2017)
* [Configure SQL Server](https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-configure-docker?view=sql-server-linux-2017)
* [Install Wine](http://www.linuxandubuntu.com/home/how-to-install-wine-and-run-windows-apps-in-linux)
* [Hazus Downloader](https://msc.fema.gov/portal/resources/download#HazusDownloadAnchor)
