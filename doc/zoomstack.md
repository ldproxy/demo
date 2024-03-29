# API: OS Open Zoomstack

https://demo.ldproxy.net/zoomstack

## Scope

OS Open Zoomstack is a comprehensive vector basemap showing coverage of Great Britain at a national level, right down to street-level detail.

Resource types: Features, Vector Tiles, Styles

## Notes

This API is disabled by default, because the data is too large to be included in this repository, see below.

## Data source

License: [Open Government Licence (OGL)](http://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/)

Attribution: 'Contains OS data © Crown copyright and database right 2023.'

To enable the API, follow these steps:

* Go to https://osdatahub.os.uk/downloads/open/OpenZoomstack.
* Select "GeoPackage" as the data format and click the download link. Store the downloaded file at the path `resources/features/OS_Open_Zoomstack.gpkg`.
* Select "Vector Tiles (MBTiles)" as the data format and click the download link. Store the downloaded file at the path `resources/tiles/zoomstack/OS_Open_Zoomstack.mbtiles`.
* Copy `zoomstack/provider/zoomstack.yml` to `entities/instances/features/withTiles/providers/zoomstack.yml`.
* Copy `zoomstack/provider/zoomstack-tiles.yml` to `entities/instances/features/withTiles/providers/zoomstack-tiles.yml`.
* Copy `zoomstack/service/zoomstack.yml` to `entities/instances/features/withTiles/services/zoomstack.yml`.
* Set `ENABLE_ZOOMSTACK` in `docker-compose.yml` to `true`.

There is also a script `enable_zoomstack.sh` that executes the last four steps steps. The script `disable_zoomstack.sh` restores the original setting.

Note that the Stylesheets and associated resources from https://github.com/OrdnanceSurvey/OS-Open-Zoomstack-Stylesheets are already included in `values/maplibre-styles/zoomstack`, `resources/other-styles/zoomstack` and `resources/api-resources/zoomstack`.
