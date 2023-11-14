SELECT
    PULocationID,
    AVG(base_passenger_fare/trip_miles) fpm_uber,
    COUNT(*) cnt_uber
FROM {{ ref("rides")  }}
WHERE hvfhs_license_num = 'HV0003' AND DOLocationID < 264
GROUP BY PULocationID