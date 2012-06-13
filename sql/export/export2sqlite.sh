
# to have ogr2ogr working with postgis 2.0
# psql -f /usr/share/postgresql/9.1/contrib/postgis-2.0/legacy.sql

export outputpath=/home/denis/Documents/qgis/qgis-project/sige_distribution.sqlite
rm $outputpath

# PIPES
ogr2ogr -sql "SELECT                                           \
		id				  ,                                         \
		year              ,                                         \
		tunnel_or_bridge  ,                                         \
		pressure_nominale ,                                         \
		folder            ,                                         \
		remarks           ,                                         \
		_length2d         ,                                         \
		_length3d         ,                                         \
		_length3d_uptodate,                                         \
		_is_on_map        ,                                         \
		_is_on_district   ,                                         \
		geometry::geometry(LineString,21781),                       \
		sqrt(pow(_length3d,2)-pow(_length2d,2))/_length2d AS _slope,\
		_function_name,                                             \
		_install_method,                                            \
		_material_name,                                             \
		_material_longname,                                         \
		_material_diameter,                                         \
		_material_diameter_internal,                                \
		_distributor,                                                     \
		_precision,                                                 \
		_protection,                                                \
		_status_name,                                               \
		_status_active,                                             \
		_pressurezone,                                             \
		_schema_view                                                \
 FROM distribution.pipes_view WHERE id_distributor = 1" \
 -overwrite -a_srs EPSG:21781 -f SQLite $outputpath \
 -nln pipes -nlt LINESTRING -progress -preserve_fid \
 PG:"dbname='sige' host='172.24.171.202' port='5432' user='sige' password='db4wat$'" \
 -dsco SPATIALITE=yes -lco SPATIAL_INDEX=yes  -gt 65536

# PIPES SCHEMA
ogr2ogr -sql "SELECT                                            \
		id				  ,                                         \
		year              ,                                         \
		tunnel_or_bridge  ,                                         \
		pressure_nominale ,                                         \
		folder            ,                                         \
		remarks           ,                                         \
		_length2d         ,                                         \
		_length3d         ,                                         \
		_length3d_uptodate,                                         \
		_is_on_map        ,                                         \
		_is_on_district   ,                                         \
		geometry::geometry(LineString,21781),                       \
		sqrt(pow(_length3d,2)-pow(_length2d,2))/_length2d AS _slope,\
		_function_name,                                             \
		_install_method,                                            \
		_material_name,                                             \
		_material_longname,                                         \
		_material_diameter,                                         \
		_material_diameter_internal,                                \
		_distributor,                                                     \
		_precision,                                                 \
		_protection,                                                \
		_status_name,                                               \
		_status_active,                                             \
		_pressurezone                                              \
 FROM distribution.pipes_schema WHERE id_distributor = 1" \
 -overwrite -a_srs EPSG:21781 -f SQLite $outputpath \
 -nln pipes_schema -nlt LINESTRING -progress -preserve_fid \
 PG:"dbname='sige' host='172.24.171.202' port='5432' user='sige' password='db4wat$'" \
 -dsco SPATIALITE=yes -lco SPATIAL_INDEX=yes  -gt 65536

# NODES
ogr2ogr -sql "SELECT * FROM distribution.nodes WHERE _status_active IS TRUE" \
 -overwrite -a_srs EPSG:21781 -f SQLite $outputpath \
 -nln nodes -nlt POINT -progress -preserve_fid \
 PG:"dbname='sige' host='172.24.171.202' port='5432' user='sige' password='db4wat$'" \
 -dsco SPATIALITE=yes -lco SPATIAL_INDEX=yes  -gt 65536
 
 # VALVES
ogr2ogr -sql "SELECT                   \
	id ,                                        \
	sige,                                       \
	id_pipe,                                    \
	id_node,                                    \
	diameter_nominal,                           \
	year,                                       \
	closed,                                     \
	altitude_dtm,                               \
	altitude_real,                              \
	remarks,                                    \
	_is_on_map,                                 \
	_is_on_district,                            \
	geometry::geometry(Point,21781),            \
	_function,                                  \
	_type,                                      \
	_schema_view,                                      \
	_label                                      \
 FROM distribution.valves_view" \
 -overwrite -a_srs EPSG:21781 -f SQLite $outputpath \
 -nln valves -nlt POINT -progress -preserve_fid \
 PG:"dbname='sige' host='172.24.171.202' port='5432' user='sige' password='db4wat$'" \
 -dsco SPATIALITE=yes -lco SPATIAL_INDEX=yes  -gt 65536

 # VALVES SCHEMA
ogr2ogr -sql "SELECT                   \
	id ,                                        \
	sige,                                       \
	id_pipe,                                    \
	id_node,                                    \
	diameter_nominal,                           \
	year,                                       \
	closed,                                     \
	altitude_dtm,                               \
	altitude_real,                              \
	remarks,                                    \
	_is_on_map,                                 \
	_is_on_district,                            \
	geometry_alternative::geometry(Point,21781),\
	_function,                                  \
	_type,                                      \
	_label                                      \
FROM distribution.valves_schema" \
 -overwrite -a_srs EPSG:21781 -f SQLite $outputpath \
 -nln valves_schema -nlt POINT -progress -preserve_fid \
 PG:"dbname='sige' host='172.24.171.202' port='5432' user='sige' password='db4wat$'" \
 -dsco SPATIALITE=yes -lco SPATIAL_INDEX=yes  -gt 65536
 
# INSTALLATIONS
ogr2ogr -sql "SELECT * FROM distribution.installations_view" \
 -overwrite -a_srs EPSG:21781 -f SQLite $outputpath \
 -nln installations -nlt POINT -progress -preserve_fid \
 PG:"dbname='sige' host='172.24.171.202' port='5432' user='sige' password='db4wat$'" \
 -dsco SPATIALITE=yes -lco SPATIAL_INDEX=yes  -gt 65536
 
 # PRESSURE ZONES
ogr2ogr -sql "SELECT * FROM distribution.pressurezones" \
 -overwrite -a_srs EPSG:21781 -f SQLite $outputpath \
 -nln pressurezones -nlt POLYGON -progress -preserve_fid \
 PG:"dbname='sige' host='172.24.171.202' port='5432' user='sige' password='db4wat$'" \
 -dsco SPATIALITE=yes -lco SPATIAL_INDEX=yes  -gt 65536
 
 
  # PRINT MAPS
ogr2ogr -sql "SELECT * FROM distribution.printmaps" \
 -overwrite -a_srs EPSG:21781 -f SQLite $outputpath \
 -nln printmaps -nlt POLYGON -progress -preserve_fid \
 PG:"dbname='sige' host='172.24.171.202' port='5432' user='sige' password='db4wat$'" \
 -dsco SPATIALITE=yes -lco SPATIAL_INDEX=yes  -gt 65536
 
 
   # DISTRICTS
ogr2ogr -sql "SELECT * FROM distribution.districts" \
 -overwrite -a_srs EPSG:21781 -f SQLite $outputpath \
 -nln districts -nlt POLYGON -progress -preserve_fid \
 PG:"dbname='sige' host='172.24.171.202' port='5432' user='sige' password='db4wat$'" \
 -dsco SPATIALITE=yes -lco SPATIAL_INDEX=yes  -gt 65536
 
    # SUBSCRIBER
ogr2ogr -sql "SELECT * FROM distribution.subscriber_view" \
 -overwrite -a_srs EPSG:21781 -f SQLite $outputpath \
 -nln subscriber -nlt POINT -progress -preserve_fid \
 PG:"dbname='sige' host='172.24.171.202' port='5432' user='sige' password='db4wat$'" \
 -dsco SPATIALITE=yes -lco SPATIAL_INDEX=yes  -gt 65536


    # SAMPLING POINTS
ogr2ogr -sql "SELECT * FROM distribution.samplingpoint" \
 -overwrite -a_srs EPSG:21781 -f SQLite $outputpath \
 -nln samplingpoint -nlt POINT -progress -preserve_fid \
 PG:"dbname='sige' host='172.24.171.202' port='5432' user='sige' password='db4wat$'" \
 -dsco SPATIALITE=yes -lco SPATIAL_INDEX=yes  -gt 65536