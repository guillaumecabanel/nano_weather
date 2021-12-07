# Nano weather

## Usage

### Rain in the hour

```
/:latitude/:longitude/rain
```

Where `:latitude` and `:longitude` are the **latitude** and **longitude** with decimal format.

#### Example request

```
/47.2181/-1.5528/rain
```

#### Example response

```json
{
  "update_time": "2021-12-07 12:05:00 UTC",
  "coordinates": {
    "latitude": "47.2181",
    "longitude": "-1.5528"
  },
  "location": "Nantes",
  "forecast": [
    {
      "time": "2021-12-07 12:20:00 UTC",
      "rain_intensity": 2,
      "rain_intensity_description": "Pluie faible"
    },
    {
      "time": "2021-12-07 12:25:00 UTC",
      "rain_intensity": 2,
      "rain_intensity_description": "Pluie faible"
    },
    {
      "time": "2021-12-07 12:30:00 UTC",
      "rain_intensity": 2,
      "rain_intensity_description": "Pluie faible"
    },
    {
      "time": "2021-12-07 12:35:00 UTC",
      "rain_intensity": 2,
      "rain_intensity_description": "Pluie faible"
    },
    {
      "time": "2021-12-07 12:40:00 UTC",
      "rain_intensity": 2,
      "rain_intensity_description": "Pluie faible"
    },
    {
      "time": "2021-12-07 12:45:00 UTC",
      "rain_intensity": 2,
      "rain_intensity_description": "Pluie faible"
    },
    {
      "time": "2021-12-07 12:55:00 UTC",
      "rain_intensity": 1,
      "rain_intensity_description": "Temps sec"
    },
    {
      "time": "2021-12-07 13:05:00 UTC",
      "rain_intensity": 1,
      "rain_intensity_description": "Temps sec"
    },
    {
      "time": "2021-12-07 13:15:00 UTC",
      "rain_intensity": 1,
      "rain_intensity_description": "Temps sec"
    }
  ]
}
```
