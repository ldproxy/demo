#!/bin/sh

cp cologne_lod2/provider/cologne_lod2.yml entities/instances/features/withTiles/providers/cologne_lod2.yml
cp cologne_lod2/service/cologne_lod2.yml entities/instances/features/withTiles/services/cologne_lod2.yml
sed -i '' "s/ENABLE_COLOGNE=false/ENABLE_COLOGNE=true/" docker-compose.yml
