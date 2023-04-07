# API: Vineyards in Rhineland-Palatinate

https://demo.ldproxy.net/vineyards

## Scope

Vineyard register (Weinbergsrolle) of Rhineland-Palatinate, Germany, covering the wine regions Mosel, Nahe, Rheinhessen, Pfalz, Ahr, and Mittelrhein.

Resource types: Features, Vector Tiles, Styles

## Data source

License: [Datenlizenz Deutschland - Namensnennung - Version 2.0](https://www.govdata.de/dl-de/by-2-0)

Attribution: '&copy; Landwirtschaftskammer RLP (2023), dl-de/by-2-0, [weinlagen.lwk-rlp.de](http://weinlagen.lwk-rlp.de/), [Regelungen zu Gewährleistung und Haftung](http://weinlagen.lwk-rlp.de/portal/nutzungsbedingungen/gewaehrleistung-haftung.html)'

To generate the GeoPackage:

```sh
curl "http://weinlagen.lwk-rlp.de/geoserver/lwk/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=lwk:Weinlagen&outputFormat=shape-zip" -o Weinlagen.zip
unzip Weinlagen.zip
ogr2ogr -f "GPKG" Weinlagen.gpkg Weinlagen/Weinlagen.shp -oo encoding="ISO-8859-1" -nlt MULTIPOLYGON
```

Tools:

* [curl](https://curl.se/)
* [ogr2ogr](https://gdal.org/)
* a tool to extract files from a ZIP archive
