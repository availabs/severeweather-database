- [x] Generate DDL

- [ ] Create ALTER Table DDL
  - [ ] Change VARCHAR to geometries/geographies where appropriate
  - [ ] Add timestamp columns to appropriate tables
  - [ ] Table partitioning
  - [ ] Indices
  - [ ] Cluster
  - [ ] Analyze

- [ ] Clean CSVs
  - [ ] Remove all data for states other than NY
    - [ ] Research best tool for task
      - csvkit (speed & memory requirements?)
      - awk (will need to keep track of header columns)

- [ ] Load CSVs
  - [ ] COPY TO loader for Non-spatial Tables
  - [ ] ogr2ogr for spatial tables
    - [ ] Is this necessary?
