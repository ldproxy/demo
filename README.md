# ldproxy demonstration deployment - configuration

Live deployment: https://demo.ldproxy.net/

## Getting started

To start a local deployment, use `docker compose up -d`. 

To stop the local deployment again, use `docker compose down`.

After startup, the APIs should be available at http://localhost:7080/rest/services.

The log file is available at `docker logs ldproxy_demo` while the server is running.

For more information about ldproxy see https://docs.ldproxy.net/.

## Terms of use

This configuration describes the configuration for https://demo.ldproxy.net/.

interactive instruments makes this information available as examples of ldproxy configurations.

The files included in the `api-resources` directory are in general subject to copyright and a license. For details see each API configuration.

All other files are available under the [Creative Commons Attribution 4.0 International (CC BY 4.0)](https://creativecommons.org/licenses/by/4.0/) license.

If you want to use this configuration as a starting point for your own deployment, you **must** make the following changes before your provide access to the deployment or its configuration to another party:

* Change the default external URL at `cfg.yml#/server/externalUrl`.
* Remove or change all values of `store/defaults/services/ogc_api.yml#/metadata` and `store/defaults/services/ogc_api.yml#/api`.
* Remove all files in `api-resources`.
  * For the GeoPackage, MBTiles and Style files in `api-resources/features` and `api-resources/tiles`: If you want to use one of the datasets yourself, download the source data, if publicly available, and convert the data to a GeoPackage or MBTiles file. The information how to do this is included for each API below, if the source data is publicly available.
  * For other files under `api-resources`, if the file is publicly available, the information how to download the file is provided for each API below, too.

## API: CShapes Dataset of Historical Country Boundaries

### Scope

Borders of independent states and dependent territories from 1886 to 2019.

Resource types: Features

### Notes

Each boundary feature is associated with a time interval in which the boundaries were valid. For example, to select the boundaries at January 1, 1980, use the query parameter `datetime=1980-01-01` ([request](https://demo.ldproxy.net/cshapes/collections/boundary/items?datetime=1980-01-01&limit=200)).

### Data source

License: [Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)](https://creativecommons.org/licenses/by-nc-sa/4.0/)

Attribution: Schvitz, Guy, Seraina Rüegger, Luc Girardin, Lars-Erik Cederman, Nils Weidmann, and Kristian Skrede Gleditsch. 2022. [Mapping The International System, 1886-2017: The CShapes 2.0 Dataset](https://icr.ethz.ch/publications/cshapes-2/). Journal of Conflict Resolution 66(1): 144–61.

The commands to generate the GeoPackage used as the feature provider:

```sh
curl "https://icr.ethz.ch/data/cshapes/CShapes-2.0.zip" -o CShapes-2.0.zip
unzip CShapes-2.0.zip
ogr2ogr -f "GPKG" CShapes-2.0.gpkg CShapes-2.0/CShapes-2.0.shp -oo encoding="ISO-8859-1" -nlt MULTIPOLYGON -wrapdateline -nln CShapes
```

## API: Daraa

### Scope

A test dataset used in OGC testbeds and pilots. The data is derived from OpenStreetMap data from the region of Daraa, Syria, converted to the Topographic Data Store schema.

Resource types: Features, Vector Tiles, Styles

### Notes

Vector tiles are provided in multiple tiling schemes.

### Data source

The feature data was provided by the US National Geospatial Intelligence Agency (NGA) for development, testing and demonstrations in initiatives of the Open Geospatial Consortium (OGC). For any reuse of the data, please contact NGA.

The styling resources were created by GeoSolutions during OGC Testbed-15 and the OGC Vector Tiles Pilot Phase 2. For any reuse of the data, please contact GeoSolutions.

## API: Earth at Night

### Scope

The Earth at night, released by NASA. For more information, see NASA Earth Observatory "Night Lights". Raster tiles on zoom levels 0 to 6 were derived from a 54000x27000 pixel GeoTIFF image using rio-mbtiles.

Resource types: Map Tiles

### Data source

License: Public Domain

To generate the MBTiles:

```sh
curl "https://eoimages.gsfc.nasa.gov/images/imagerecords/79000/79765/dnb_land_ocean_ice.2012.54000x27000_geo.tif" -o dnb_land_ocean_ice.2012.54000x27000_geo.tif
rio mbtiles dnb_land_ocean_ice.2012.54000x27000_geo.tif  -o dnb_land_ocean_ice.2012.54000x27000_geo.mbtiles --zoom-levels 0..6 --tile-size 512 --baselayer --title "Earth at Night" --description "GeoTIFF provided by NASA. Created using rio-mbtiles."
```

rio-mbtiles does not generate the `minzoom`, `maxzoom` and `center` entries in the `metadata` table, so these have to be set manually.

## API: OS Open Zoomstack

### Scope

OS Open Zoomstack is a comprehensive vector basemap showing coverage of Great Britain at a national level, right down to street-level detail.

Resource types: Features, Vector Tiles, Styles

### Notes

This API is disabled by default, because the data is too large to be included in this repository, see below.

### Data source

License: [Open Government Licence (OGL)](http://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/)

Attribution: 'Contains OS data © Crown copyright and database right 2023.'

To enable the API, follow these steps:

* Go to https://osdatahub.os.uk/downloads/open/OpenZoomstack.
* Select "GeoPackage" as the data format and click the download link. Store the downloaded file at the path `api-resources/features/OS_Open_Zoomstack.gpkg`.
* Select "Vector Tiles (MBTiles)" as the data format and click the download link. Store the downloaded file at the path `api-resources/tiles/zoomstack/OS_Open_Zoomstack.mbtiles`.
* Download the Stylesheets and associated resources from https://github.com/OrdnanceSurvey/OS-Open-Zoomstack-Stylesheets and copy those to `api-resources/styles/zoomstack` and `api-resources/resources/zoomstack`.
* Set `ENABLE_ZOOMSTACK` in `docker-compose.yml` to `true`.

## API: Straßennetz Landesbetrieb Straßenbau NRW

### Scope

Public roads of the road classes Autobahn, federal roads, state roads and district roads in North Rhine-Westphalia, Germany, plus accidents on these roads.

Resource types: Features, Vector Tiles, Styles

### Notes

Vector tiles are provided in multiple tiling schemes.

Accidents are provided in two variants. The first variant links to the road segment, the second joins the road segment and includes attributes from the road segment in the response.

### Data source

License: [Datenlizenz Deutschland - Namensnennung - Version 2.0](https://www.govdata.de/dl-de/by-2-0)

Attribution: '&copy; 2022 Landesbetrieb Straßenbau Nordrhein-Westfalen (Straßen.NRW)'

To generate the GeoPackage:

```sh
# Download the data
curl "https://www.opengeodata.nrw.de/produkte/transport_verkehr/strassennetz/AbschnitteAeste_EPSG25832_Shape.zip" -o AbschnitteAeste_EPSG25832_Shape.zip
curl "https://www.opengeodata.nrw.de/produkte/transport_verkehr/strassennetz/Netzknoten_EPSG25832_Shape.zip" -o Netzknoten_EPSG25832_Shape.zip
curl "https://www.opengeodata.nrw.de/produkte/transport_verkehr/strassennetz/Nullpunkte_EPSG25832_Shape.zip" -o Nullpunkte_EPSG25832_Shape.zip
curl "https://www.opengeodata.nrw.de/produkte/transport_verkehr/strassennetz/Unfaelle_EPSG25832_Shape.zip" -o Unfaelle_EPSG25832_Shape.zip
# Unzip
unzip AbschnitteAeste_EPSG25832_Shape.zip -d strassennrw
unzip Netzknoten_EPSG25832_Shape.zip -d strassennrw
unzip Nullpunkte_EPSG25832_Shape.zip -d strassennrw
unzip Unfaelle_EPSG25832_Shape.zip -d strassennrw
# Map custom timestamp format to RFC 3339
ogrinfo -dialect sqlite -sql "update ABSCHNITTEAESTE_line set NETZSTAND=substr(NETZSTAND,1,4)||'-'||substr(NETZSTAND,5,2)||'-'||substr(NETZSTAND,7,2)||'T'||substr(NETZSTAND,9,2)||':'||substr(NETZSTAND,11,2)||':'||substr(NETZSTAND,13,2)||'+01:00'" strassennrw/AbschnitteAeste/ABSCHNITTEAESTE_line.shp
ogrinfo -dialect sqlite -sql "update NETZKNOTEN_point set NETZSTAND=substr(NETZSTAND,1,4)||'-'||substr(NETZSTAND,5,2)||'-'||substr(NETZSTAND,7,2)||'T'||substr(NETZSTAND,9,2)||':'||substr(NETZSTAND,11,2)||':'||substr(NETZSTAND,13,2)||'+01:00'" strassennrw/Netzknoten/NETZKNOTEN_point.shp
ogrinfo -dialect sqlite -sql "update NULLPUNKTE_point set NETZSTAND=substr(NETZSTAND,1,4)||'-'||substr(NETZSTAND,5,2)||'-'||substr(NETZSTAND,7,2)||'T'||substr(NETZSTAND,9,2)||':'||substr(NETZSTAND,11,2)||':'||substr(NETZSTAND,13,2)||'+01:00'" strassennrw/Nullpunkte/NULLPUNKTE_point.shp
ogrinfo -dialect sqlite -sql "update UNFAELLE_point set NETZSTAND=substr(NETZSTAND,1,4)||'-'||substr(NETZSTAND,5,2)||'-'||substr(NETZSTAND,7,2)||'T'||substr(NETZSTAND,9,2)||':'||substr(NETZSTAND,11,2)||':'||substr(NETZSTAND,13,2)||'+01:00'" strassennrw/Unfaelle/UNFAELLE_point.shp
ogrinfo -dialect sqlite -sql "update UNFAELLE_point set UNFZEIT=substr(UNFZEIT,1,4)||'-'||substr(UNFZEIT,5,2)||'-'||substr(UNFZEIT,7,2)||'T'||substr(UNFZEIT,9,2)||':'||substr(UNFZEIT,11,2)||':'||substr(UNFZEIT,13,2)||'+01:00'" strassennrw/Unfaelle/UNFAELLE_point.shp
# Generate GeoPackage
ogr2ogr -f "GPKG" strassennrw.gpkg strassennrw/AbschnitteAeste/ABSCHNITTEAESTE_line.shp
ogr2ogr -f "GPKG" strassennrw.gpkg strassennrw/Netzknoten/NETZKNOTEN_point.shp -append
ogr2ogr -f "GPKG" strassennrw.gpkg strassennrw/Nullpunkte/NULLPUNKTE_point.shp -append
ogr2ogr -f "GPKG" strassennrw.gpkg strassennrw/Unfaelle/UNFAELLE_point.shp -append
```

## API: Vineyards in Rhineland-Palatinate

### Scope

Vineyard register (Weinbergsrolle) of Rhineland-Palatinate, Germany, covering the wine regions Mosel, Nahe, Rheinhessen, Pfalz, Ahr, and Mittelrhein.

Resource types: Features, Vector Tiles, Styles

### Data source

License: [Datenlizenz Deutschland - Namensnennung - Version 2.0](https://www.govdata.de/dl-de/by-2-0)

Attribution: &copy; Landwirtschaftskammer RLP (2023), dl-de/by-2-0, [weinlagen.lwk-rlp.de](http://weinlagen.lwk-rlp.de/), [Regelungen zu Gewährleistung und Haftung](http://weinlagen.lwk-rlp.de/portal/nutzungsbedingungen/gewaehrleistung-haftung.html)

To generate the GeoPackage:

```sh
curl "http://weinlagen.lwk-rlp.de/geoserver/lwk/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=lwk:Weinlagen&outputFormat=shape-zip" -o Weinlagen.zip
unzip Weinlagen.zip
ogr2ogr -f "GPKG" Weinlagen.gpkg Weinlagen/Weinlagen.shp -oo encoding="ISO-8859-1" -nlt MULTIPOLYGON
```