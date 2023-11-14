SELECT
	hvfhs_license_num,
	PULocationID,
	DOLocationID,
	base_passenger_fare,
	trip_miles
FROM {{ source('taxis', 'taxis') }}