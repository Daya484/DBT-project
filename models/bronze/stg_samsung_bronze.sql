
{{
  config(
    materialized = 'view',
    tags = ['bronze_samsung']
  )
}}

SELECT
    *,
    _FILE_NAME          AS source_file_path,      -- which GCS file the row came from
    SPLIT(ARRAY_REVERSE(SPLIT(_FILE_NAME, '/'))[SAFE_OFFSET(0)],'.' )[SAFE_OFFSET(0)] AS file_name,
    CURRENT_TIMESTAMP() AS load_timestamp    -- when it was loaded
FROM {{ source('gcs_raw', 'raw_samsung') }}