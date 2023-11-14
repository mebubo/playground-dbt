SELECT
   hvfhs_license_num,
   AVG(base_passenger_fare/trip_miles) fare,
   COUNT(*)
FROM rides GROUP BY hvfhs_license_num