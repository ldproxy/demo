# API: Straßennetz Landesbetrieb Straßenbau NRW

https://demo.ldproxy.net/strassen

## Scope

Public roads of the road classes Autobahn, federal roads, state roads and district roads in North Rhine-Westphalia, Germany, plus accidents on these roads.

Resource types: Features, Vector Tiles, Styles

## Notes

Vector tiles are provided in multiple tiling schemes.

Accidents are provided in two variants. The first variant links to the road segment, the second joins the road segment and includes attributes from the road segment in the response.

## Data source

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

Tools:

* [curl](https://curl.se/)
* [ogr2ogr](https://gdal.org/)
* a tool to extract files from a ZIP archive
