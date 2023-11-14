SELECT
    PULocationID,
    AVG(base_passenger_fare/trip_miles) fpm_lyft,
    COUNT(*) cnt_lyft
FROM {{ ref("rides") }}
WHERE hvfhs_license_num = 'HV0005' AND DOLocationID < 264
GROUP BY PULocationID