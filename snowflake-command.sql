CREATE DATABASE spotify_db;

create or replace storage integration s3_init
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = S3
  ENABLED = TRUE 
  STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::992382473196:role/spotify-spark-snowflake-role'
  STORAGE_ALLOWED_LOCATIONS = ('s3://spotify-data-pipeline-spark')
   COMMENT = 'Creating connection to S3' 

DESC integration s3_init;

CREATE OR REPLACE FILE FORMAT csv_fileformat
    TYPE = CSV
    FIELD_DELIMITER = ','
    SKIP_HEADER = 1
    NULL_IF = ('NULL', 'null')
    EMPTY_FIELD_AS_NULL = TRUE
    FIELD_OPTIONALLY_ENCLOSED_BY = '"';

CREATE OR REPLACE stage spotify_stage
    URL = 's3://spotify-data-pipeline-spark/transformed_data/'
    STORAGE_INTEGRATION = s3_init
    FILE_FORMAT = csv_fileformat

LIST @spotify_stage


CREATE OR REPLACE TABLE tbl_album (
    album_id STRING,
    album_name STRING,
    release_date DATE,
    total_tracks INT,
    url STRING
);

CREATE OR REPLACE TABLE tbl_artists (
    artist_id STRING,
    name STRING,
    url STRING
);

CREATE OR REPLACE TABLE tbl_songs (
    song_id STRING,
    song_name STRING,
    duration_ms INT,
    url STRING,
    popularity INT,
    song_added DATE,
    album_id STRING,
    artist_id STRING
);

COPY INTO TBL_SONGS
    FROM @spotify_stage/songs/songs_transformed_2025-01-29/run-1738115619679-part-r-00000;

COPY INTO TBL_ARTISTS
    FROM @spotify_stage/artist/artist_transformed_2025-01-29/run-1738115618531-part-r-00000;

COPY INTO TBL_ALBUM
    FROM @spotify_stage/album/album_transformed_2025-01-29/run-1738115586944-part-r-00000;

SELECT * FROM TBL_ALBUM;

CREATE OR REPLACE SCHEMA pipe;

CREATE OR REPLACE pipe spotify_db.pipe.tbl_songs_pipe
auto_ingest = TRUE
AS
COPY INTO spotify_db.public.TBL_SONGS
FROM @spotify_db.public.spotify_stage/songs;

CREATE OR REPLACE pipe spotify_db.pipe.tbl_artists_pipe
auto_ingest = TRUE
AS
COPY INTO spotify_db.public.TBL_ARTISTS
FROM @spotify_db.public.spotify_stage/artist;

CREATE OR REPLACE pipe spotify_db.pipe.tbl_album_pipe
auto_ingest = TRUE
AS
COPY INTO spotify_db.public.TBL_ALBUM
FROM @spotify_db.public.spotify_stage/album;

DESC pipe pipe.tbl_album_pipe;


SELECT count(*) from tbl_songs;
TRUNCATE TABLE tbl_album;

SELECT SYSTEM$PIPE_STATUS('pipe.tbl_artists_pipe')

DROP PIPE IF EXISTS pipe.tbl_artists_pipe;
