SELECT
    PULocationID pickup_zone,
    AVG(base_passenger_fare / trip_miles) fare_per_mile,
    COUNT(*) num_rides
FROM {{ ref("rides") }}
WHERE DOLocationID < 264
GROUP BY PULocationID