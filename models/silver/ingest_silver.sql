{{
  config(
    materialized         = 'incremental',
    incremental_strategy = 'merge',         
    unique_key           = [               
      'Distributor_code',
      'Retailer_code',
      'Store_code',
      'EAN_code'
    ],
  )
}}

SELECT *
  FROM {{ ref('stg_samsung_bronze') }} AS s

  {% if is_incremental() %}
   WHERE s.load_timestamp > (SELECT MAX(load_timestamp) FROM {{ this }})
  {% endif %}