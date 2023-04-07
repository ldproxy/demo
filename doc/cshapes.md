# API: CShapes Dataset of Historical Country Boundaries

https://demo.ldproxy.net/cshapes

## Scope

Borders of independent states and dependent territories from 1886 to 2019.

Resource types: Features

## Notes

Each boundary feature is associated with a time interval in which the boundaries were valid. For example, to select the boundaries at January 1, 1980, use the query parameter `datetime=1980-01-01` ([request](https://demo.ldproxy.net/cshapes/collections/boundary/items?datetime=1980-01-01&limit=200)).

## Data source

License: [Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)](https://creativecommons.org/licenses/by-nc-sa/4.0/)

Attribution: Schvitz, Guy, Seraina Rüegger, Luc Girardin, Lars-Erik Cederman, Nils Weidmann, and Kristian Skrede Gleditsch. 2022. [Mapping The International System, 1886-2017: The CShapes 2.0 Dataset](https://icr.ethz.ch/publications/cshapes-2/). Journal of Conflict Resolution 66(1): 144–61.

The commands to generate the GeoPackage used as the feature provider:

```sh
curl "https://icr.ethz.ch/data/cshapes/CShapes-2.0.zip" -o CShapes-2.0.zip
unzip CShapes-2.0.zip
ogr2ogr -f "GPKG" CShapes-2.0.gpkg CShapes-2.0/CShapes-2.0.shp -oo encoding="ISO-8859-1" -nlt MULTIPOLYGON -wrapdateline -nln CShapes
```

Tools:

* [curl](https://curl.se/)
* [ogr2ogr](https://gdal.org/)
* a tool to extract files from a ZIP archive
