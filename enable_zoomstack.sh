#!/bin/sh

cp zoomstack/provider/zoomstack.yml entities/instances/features/withTiles/providers/zoomstack.yml
cp zoomstack/provider/zoomstack-tiles.yml entities/instances/features/withTiles/providers/zoomstack-tiles.yml
cp zoomstack/service/zoomstack.yml entities/instances/features/withTiles/services/zoomstack.yml
sed -i '' "s/ENABLE_ZOOMSTACK=false/ENABLE_ZOOMSTACK=true/" docker-compose.yml
