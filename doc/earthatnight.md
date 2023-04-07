# API: Earth at Night

https://demo.ldproxy.net/earthatnight

## Scope

The Earth at night, released by NASA. For more information, see NASA Earth Observatory "Night Lights". Raster tiles on zoom levels 0 to 6 were derived from a 54000x27000 pixel GeoTIFF image using rio-mbtiles.

Resource types: Map Tiles

## Data source

License: Public Domain

To generate the MBTiles:

```sh
curl "https://eoimages.gsfc.nasa.gov/images/imagerecords/79000/79765/dnb_land_ocean_ice.2012.54000x27000_geo.tif" -o dnb_land_ocean_ice.2012.54000x27000_geo.tif
rio mbtiles dnb_land_ocean_ice.2012.54000x27000_geo.tif  -o dnb_land_ocean_ice.2012.54000x27000_geo.mbtiles --zoom-levels 0..6 --tile-size 512 --baselayer --title "Earth at Night" --description "GeoTIFF provided by NASA. Created using rio-mbtiles."
sqlite3 dnb_land_ocean_ice.2012.54000x27000_geo.mbtiles "insert into metadata (name,value) values ('minzoom',0);"
sqlite3 dnb_land_ocean_ice.2012.54000x27000_geo.mbtiles "insert into metadata (name,value) values ('maxzoom',6);"
sqlite3 dnb_land_ocean_ice.2012.54000x27000_geo.mbtiles "insert into metadata (name,value) values ('center','0,0,0');"
```

rio-mbtiles does not generate the `minzoom`, `maxzoom` and `center` entries in the `metadata` table, so these have to be set manually.

Tools:

* [curl](https://curl.se/)
* [rasterio](https://github.com/rasterio/rasterio)
* [rio-mbtiles](https://github.com/mapbox/rio-mbtiles)
* [SQLite](https://www.sqlite.org/index.html)
