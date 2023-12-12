#!/bin/sh

rm entities/instances/features/withTiles/providers/zoomstack.yml
rm entities/instances/features/withTiles/providers/zoomstack-tiles.yml
rm entities/instances/features/withTiles/services/zoomstack.yml
sed -i '' "s/ENABLE_ZOOMSTACK=true/ENABLE_ZOOMSTACK=false/" docker-compose.yml
