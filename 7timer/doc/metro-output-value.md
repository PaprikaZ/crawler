7Timer! Metro
-------------

In Short
--------

METEO product is mainly intended for meteorological purpose and has included a
number of meteorological elements, such as the relative humidity and wind
profile from 950hPa to 200hPa. The forecasts for wind and cloud cover are
plotted following the universal meteorological guidelines (users might read
Wikipedia article at http://en.wikipedia.org/wiki/Station_model for a quick
look of such guidelines). The forecast range is 8-day (192-hour).

Definition of API Output Value
==============================

| Variable                  | Value             | Meaning                     |
| ------------------------- | ----------------- | ----------------------------|
| Cloud Cover               | 1                 | 0%-6%                       |
|                           | 2                 | 6%-19%                      |
|                           | 3                 | 19%-31%                     |
|                           | 4                 | 31%-44%                     |
|                           | 5                 | 44%-56%                     |
|                           | 6                 | 56%-69%                     |
|                           | 7                 | 69%-81%                     |
|                           | 8                 | 81%-94%                     |
|                           | 9                 | 94%-100%                    |
| Lifted Index              | -10               | Below -7                    |
|                           | -6                | -7 to -5                    |
|                           | -4                | -5 to -3                    |
|                           | -1                | -3 to 0                     |
|                           | 2                 | 0 to 4                      |
|                           | 6                 | 4 to 8                      |
|                           | 10                | 8 to 11                     |
|                           | 15                | Over 11                     |
| 2m Temperature            | -76 to 60         | -76C to +60C                |
| Seeing                    | 1                 | <0.5"                       |
|                           | 2                 | 0.5"-0.75"                  |
|                           | 3                 | 0.75"-1"                    |
|                           | 4                 | 1"-1.25"                    |
|                           | 5                 | 1.25"-1.5"                  |
|                           | 6                 | 1.5"-2"                     |
|                           | 7                 | 2"-2.5"                     |
|                           | 8                 | >2.5"                       |
| Transparency              | 1                 | <0.3                        |
|                           | 2                 | 0.3-0.4                     |
|                           | 3                 | 0.4-0.5                     |
|                           | 4                 | 0.5-0.6                     |
|                           | 5                 | 0.6-0.7                     |
|                           | 6                 | 0.7-0.85                    |
|                           | 7                 | 0.85-1                      |
|                           | 8                 | >1                          |
| Relative Humidity (2m and profile) | -4                | 0%-5%              |
|                                    | -3                | 5%-10%             |
|                                    | -2                | 10%-15%            |
|                                    | -1                | 15%-20%            |
|                                    | 0                 | 20%-25%            |
|                                    | 1                 | 25%-30%            |
|                                    | 2                 | 30%-35%            |
|                                    | 3                 | 35%-40%            |
|                                    | 4                 | 40%-45%            |
|                                    | 5                 | 45%-50%            |
|                                    | 6                 | 50%-55%            |
|                                    | 7                 | 55%-60%            |
|                                    | 8                 | 60%-65%            |
|                                    | 9                 | 65%-70%            |
|                                    | 10                | 70%-75%            |
|                                    | 11                | 75%-80%            |
|                                    | 12                | 80%-85%            |
|                                    | 13                | 85%-90%            |
|                                    | 14                | 90%-95%            |
|                                    | 15                | 95%-99%            |
|                                    | 16                | 100%               |
| Wind Speed (10m and profile) | 1                 | Below 0.3m/s (calm)      |
|                              | 2                 | 0.3-3.4m/s (light)       |
|                              | 3                 | 3.4-8.0m/s (moderate)    |
|                              | 4                 | 8.0-10.8m/s (fresh)      |
|                              | 5                 | 10.8-17.2m/s (strong)    |
|                              | 6                 | 17.2-24.5m/s (gale)      |
|                              | 7                 | 24.5-32.6m/s (storm)     |
|                              | 8                 | 32.6-36.7m/s (hurricane) |
|                              | 9                 | 36.7-41.4m/s (hurricane+)|
|                              | 10                | 41.4-46.2m/s (hurricane+)|
|                              | 11                | 46.2-50.9m/s (hurricane+)|
|                              | 12                | 50.9-55.9m/s (hurricane+)|
|                              | 13                | Over 55.9m/s (hurricane+)|
| Wind direction               | 0-360             | 0-360 degree (with 0 to be north) spacing in 5-degree |
| MSL Pressure                 | 924-1060          | 924hPa to 1060hPa        |
| Precipitation Type           | snow, rain, frzr (freezing rain), icep (ice pellets), none ||
| Precipitation Amount         | 0                 | None                     |
|                              | 1                 | 0-0.25mm/hr              |
|                              | 2                 | 0.25-1mm/hr              |
|                              | 3                 | 1-4mm/hr                 |
|                              | 4                 | 4-10mm/hr                |
|                              | 5                 | 10-16mm/hr               |
|                              | 6                 | 16-30mm/hr               |
|                              | 7                 | 30-50mm/hr               |
|                              | 8                 | 50-75mm/hr               |
|                              | 9                 | 75+mm/hr                 |
| Snow Depth                   | 0                 | None                     |
|                              | 1                 | 0-1cm                    |
|                              | 2                 | 1-5cm                    |
|                              | 3                 | 5-10cm                   |
|                              | 4                 | 10-25cm                  |
|                              | 5                 | 25-50cm                  |
|                              | 6                 | 50-100cm                 |
|                              | 7                 | 100-150cm                |
|                              | 8                 | 150-250cm                |
|                              | 9                 | 250+cm                   |
| Undefined                    | -9999             | Undefined                |

[source](http://ftp.astron.ac.cn/doc.php?lang=en)
