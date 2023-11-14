SELECT
        pickup_zone,
        "Zone",
        IF(num_rides >= 100, fare_per_mile, NULL) fare_per_mile,
        num_rides
from {{ ref("rides_by_pickup_zone") }} join {{ ref("zones") }} on (pickup_zone = LocationId)