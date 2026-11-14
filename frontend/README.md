# travel_frontend_v1

## Google Maps route preview

The Add Destination mini-map uses `google_maps_flutter`. The backend
`GOOGLE_ROUTES_API_KEY` remains server-only and is not read by the mobile app.
Configure separate, application-restricted Maps SDK keys for each client:

- Android: add `MAPS_API_KEY=...` to `android/local.properties`. Enable Maps
  SDK for Android and restrict the key to application ID
  `com.company.travel_frontend_v1` plus the signing certificate SHA-1.
- iOS: copy `ios/Flutter/GoogleMaps.xcconfig.example` to
  `ios/Flutter/GoogleMaps.xcconfig`, set `GOOGLE_MAPS_API_KEY=...`, and keep the
  file uncommitted. Enable Maps SDK for iOS and restrict the key to the Runner
  bundle ID.

Do not commit either client key. The route geometry, distance, and duration
continue to come from `POST /trips/routes/preview`; Flutter only decodes and
draws the returned encoded polyline.

A new Flutter project.
-gợi ý lịch trình thông minh
-gợi ý điểm đến bằng AI
