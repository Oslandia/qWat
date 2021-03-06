/*
	qWat - QGIS Water Module
	
	SQL file :: dimension arcs
*/


/* CREATE TABLE */
DROP TABLE IF EXISTS distribution.od_dimension_orientation CASCADE;
CREATE TABLE distribution.od_dimension_orientation (id serial PRIMARY KEY);
COMMENT ON TABLE distribution.od_dimension_orientation IS 'dimension arcs displays measures done on the field. For example: orientations to buildings corner';

/* columns */
ALTER TABLE distribution.od_dimension_orientation ADD COLUMN observation varchar(120) default '';
ALTER TABLE distribution.od_dimension_orientation ADD COLUMN remark      text default '';

/* geometry */
SELECT AddGeometryColumn('distribution', 'od_dimension_orientation','geometry',21781,'LINESTRING',2);
CREATE INDEX dimension_orientation_geoidx ON distribution.od_dimension_orientation USING GIST ( geometry );



