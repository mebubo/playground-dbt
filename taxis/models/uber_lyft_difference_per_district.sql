SELECT
    uber_rides.PULocationID pickup_zone,
    cnt_uber,
    cnt_lyft,
    IF(cnt_uber >= 100 AND cnt_lyft >= 100, fpm_uber - fpm_lyft, NULL)
FROM {{ ref('uber_rides') }} uber_rides
JOIN {{ ref('lyft_rides') }} lyft_rides ON (uber_rides.PULocationID = lyft_rides.PULocationID)
