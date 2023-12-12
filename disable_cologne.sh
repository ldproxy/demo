#!/bin/sh

rm entities/instances/features/withTiles/providers/cologne_lod2.yml
rm entities/instances/features/withTiles/services/cologne_lod2.yml
sed -i '' "s/ENABLE_COLOGNE=true/ENABLE_COLOGNE=false/" docker-compose.yml
