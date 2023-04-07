# ldproxy Demonstration Deployment

This repository contains the configuration for the [ldproxy](https://github.com/interactive-instruments/ldproxy) demonstration deployment at https://demo.ldproxy.net/.

## Terms of use

interactive instruments provides this information as examples of configurations of [ldproxy](https://github.com/interactive-instruments/ldproxy).

The files included in the `api-resources` directory are in general subject to copyright and a license. For details see each API configuration.

All other files are available under the [Creative Commons Attribution 4.0 International (CC BY 4.0)](https://creativecommons.org/licenses/by/4.0/) license.

If you want to use this configuration as a starting point for your own deployment, you **must** make the following changes before you provide access to the deployment or its configuration to another party:

* Change the default external URL at `cfg.yml#/server/externalUrl`.
* Remove or change all values of `store/defaults/services/ogc_api.yml#/metadata` and `store/defaults/services/ogc_api.yml#/api`.
* Remove all files in `api-resources`.
  * For the GeoPackage, MBTiles and Style files in `api-resources/features` and `api-resources/tiles`: If you want to use one of the datasets yourself, download the source data, if publicly available, and convert the data to a GeoPackage or MBTiles file. The information how to do this is included for each API below, if the source data is publicly available.
  * For other files under `api-resources`, if the file is publicly available, the information how to download the file is provided for each API, too.

## Getting started

You will need an installation of Docker. Docker is available for Linux, Windows and Mac. You will find detailed installation guides for each platform [here](https://docs.docker.com/).

To start a local deployment, use `docker compose up ldproxy -d`. 

To stop the local deployment again, use `docker compose down`.

After startup, the APIs should be available at http://localhost:7080/rest/services.

The log file is available at `docker logs ldproxy_demo` while the server is running.

For more information about ldproxy see https://docs.ldproxy.net/.

## APIs

The following APIs are part of the ldproxy demo site:

* [3D Buildings in Cologne (LoD2)](doc/cologne_lod2.md)
* [CShapes Dataset of Historical Country Boundaries](doc/cshapes.md)
* [Daraa](doc/daraa.md)
* [Earth at Night](doc/earthatnight.md)
* [OS Open Zoomstack](doc/zoomstack.md)
* [Straßennetz Landesbetrieb Straßenbau NRW](doc/strassen.md)
* [Vineyards in Rhineland-Palatinate, Germany](doc/vineyards.md)
