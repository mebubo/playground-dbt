SELECT LocationId, "Zone" FROM {{ source('external_source', 'zones')}}