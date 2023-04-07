# API: 3D Buildings in Cologne (LoD2)

https://demo.ldproxy.net/cologne_lod2

## Scope

Together with a digital terrain model, 3D building models describe the natural terrain shape of the earth's surface, including all buildings and structures, in digital form and enable the representation of cities and towns in virtual worlds. Buildings can be modeled in different levels of detail (Level of Detail, LoD). In the 3D building model LoD2, the modeling of the buildings is done with standardized roof shapes such as a gable or hip roof.

Resource types: Features, 3D Tiles, Styles

## Notes

The data in this API is an extract from the statewide data (rectangle in the city of Cologne with 2 km x 3 km edge length, 10500 buildings).

The building properties and their values are in German.

This API is disabled by default, because of the need to first start a PosqlgrSQL database and load the data. See below.

## Data source

License: [Datenlizenz Deutschland - Zero – Version 2.0](https://www.govdata.de/dl-de/zero-2-0)

This data source requires two docker containers. In addition to ldproxy, we also need a PostgreSQL/PostGIS database. This complicates the setup and this data source has therefore been disabled by default. To include this data source, execute the following steps:

* Move `cologne_lod2/provider/cologne_lod2.yml` to `store/entities/features/withTiles/providers/cologne_lod2.yml`.
* Move `cologne_lod2/service/cologne_lod2.yml` to `store/entities/features/withTiles/services/cologne_lod2.yml`.
* Set `ENABLE_ZOOMSTACK` in `docker-compose.yml` to `true`.

To start ldproxy:

* First start the database using `docker compose up db -d`.
* Monitor the progress with `docker logs -f db_demo`. 
* When the "database system is ready to accept connections", start ldproxy using `docker compose up ldproxy -d`. The list of APIs should now include "3D Buildings in Cologne (LoD2)".

To generate the PostgreSQL database dump with the 3D building data yourself, follow these steps:

```sh
# download the six CityGML tiles
mkdir temp
curl https://www.opengeodata.nrw.de/produkte/geobasis/3dg/lod2_gml/lod2_gml/LoD2_32_355_5644_1_NW.gml -o temp/LoD2_32_355_5644_1_NW.gml
curl https://www.opengeodata.nrw.de/produkte/geobasis/3dg/lod2_gml/lod2_gml/LoD2_32_355_5645_1_NW.gml -o temp/LoD2_32_355_5645_1_NW.gml
curl https://www.opengeodata.nrw.de/produkte/geobasis/3dg/lod2_gml/lod2_gml/LoD2_32_356_5644_1_NW.gml -o temp/LoD2_32_356_5644_1_NW.gml
curl https://www.opengeodata.nrw.de/produkte/geobasis/3dg/lod2_gml/lod2_gml/LoD2_32_356_5645_1_NW.gml -o temp/LoD2_32_356_5645_1_NW.gml
curl https://www.opengeodata.nrw.de/produkte/geobasis/3dg/lod2_gml/lod2_gml/LoD2_32_357_5644_1_NW.gml -o temp/LoD2_32_357_5644_1_NW.gml
curl https://www.opengeodata.nrw.de/produkte/geobasis/3dg/lod2_gml/lod2_gml/LoD2_32_357_5645_1_NW.gml -o temp/LoD2_32_357_5645_1_NW.gml

# start 3D CityDB
docker run -d -p 5432:5432 --name citydb --rm -e POSTGRES_PASSWORD=postgres -e SRID=5555 3dcitydb/3dcitydb-pg

# ... wait until the database is ready

# import the data
docker run -i -t --name impexp --rm -u $(id -u):$(id -g) -v ${PWD}/temp:/data 3dcitydb/impexp import -H host.docker.internal -P 5432 -d postgres -p postgres -u postgres /data

# postprocess the data for better usability
psql -hlocalhost -p5432 -Upostgres -dpostgres -c "CREATE materialized VIEW solid_geometry as SELECT f.id, ST_Collect(f.geom) as geom FROM (select id, (ST_Dump(A.solid_geometry)).geom as geom from surface_geometry A) as f group by id; CREATE materialized VIEW surface_geometry_multi as SELECT ts.id as id, ts.building_id as cityobject_id, st_multi(sg.geometry) as geom, replace(replace(lower(o.classname), 'building', ''), 'surface', '') as surface_type  FROM thematic_surface ts join surface_geometry sg on (ts.lod2_multi_surface_id = sg.parent_id) join objectclass o on (ts.objectclass_id = o.id) where sg.geometry is not null and ts.objectclass_id in (33,34,35,36); CREATE materialized VIEW building_address as select a.id, b.id as building_id, a.multi_point, a.street, a.house_number, a.zip_code , a.city , a.state, a.country from building b join address_to_building atb on b.id = atb.building_id join address a on atb.address_id = a.id; update building b set measured_height = (select max(b2.measured_height) from building b2 where b2.building_parent_id = b.id  group by b.id) where measured_height is null; update building b set storeys_above_ground  = (select max(b2.storeys_above_ground) from building b2 where b2.storeys_above_ground = b.id  group by b.id) where storeys_above_ground is null;"

# export a dump that will be loaded when the database starts
pg_dump -hlocalhost -p5432 -Upostgres -dpostgres -N"public|tiger|tiger_data|topology" > cologne_lod2.sql
gzip cologne_lod2.sql

# cleanup
docker stop citydb
rm temp/*.gml
rmdir temp
```

Tools:

* [curl](https://curl.se/)
* [3D City Database](https://www.3dcitydb.org/3dcitydb/3ddatabase/)
* [3D City Database Importer/Exporter](https://www.3dcitydb.org/3dcitydb/3dimpexp/)
* [psql / pg_dump](https://www.postgresql.org/)
* a tool to gzip a file
