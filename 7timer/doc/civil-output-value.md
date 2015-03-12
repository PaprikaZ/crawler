7Timer! Civil Product API Intro
---------------------------------

In Short
-----------

CIVIL is intended for civil users. It will display the forecasted weather
condition for the next 8 days with a set of easy-to-read weather icons.
Explanations of each icon, as well as the definition of values returned by
machine-readable API, are given below.

Definition of API Output Value
==============================

| Variable             | Value                        | Meaning                                                                                |
| -------------------- | ---------------------------- | -------------------------------------------------------------------------------------- |
| Cloud Cover          | 1                            | 0%-6%                                                                                  |
|                      | 2                            | 6%-19%                                                                                 |
|                      | 3                            | 19%-31%                                                                                |
|                      | 4                            | 31%-44%                                                                                |
|                      | 5                            | 44%-56%                                                                                |
|                      | 6                            | 56%-69%                                                                                |
|                      | 7                            | 69%-81%                                                                                |
|                      | 8                            | 81%-94%                                                                                |
|                      | 9                            | 94%-100%                                                                               |
| Lifted Index         | -10                          | Below -7                                                                               |
|                      | -6                           | -7 to -5                                                                               |
|                      | -4                           | -5 to -3                                                                               |
|                      | -1                           | -3 to 0                                                                                |
|                      | 2                            | 0 to 4                                                                                 |
|                      | 6                            | 4 to 8                                                                                 |
|                      | 10                           | 8 to 11                                                                                |
|                      | 15                           | Over 11                                                                                |
| 2m Temperature       | -76 to 60                    | -76C to +60C                                                                           |
| 2m Relative Humidity | 0 to 100                     | 0% to 100%                                                                             |
| 10m Wind Speed       | 1                            | Below 0.3m/s (calm)                                                                    |
|                      | 2                            | 0.3-3.4m/s (light)                                                                     |
|                      | 3                            | 3.4-8.0m/s (moderate)                                                                  |
|                      | 4                            | 8.0-10.8m/s (fresh)                                                                    |
|                      | 5                            | 10.8-17.2m/s (strong)                                                                  |
|                      | 6                            | 17.2-24.5m/s (gale)                                                                    |
|                      | 7                            | 24.5-32.6m/s (storm)                                                                   |
|                      | 8                            | Over 32.6m/s (hurricane)                                                               |
| Precipitation Amount | 0                            | None                                                                                   |
|                      | 1                            | 0-0.25mm/hr                                                                            |
|                      | 2                            | 0.25-1mm/hr                                                                            |
|                      | 3                            | 1-4mm/hr                                                                               |
|                      | 4                            | 4-10mm/hr                                                                              |
|                      | 5                            | 10-16mm/hr                                                                             |
|                      | 6                            | 16-30mm/hr                                                                             |
|                      | 7                            | 30-50mm/hr                                                                             |
|                      | 8                            | 50-75mm/hr                                                                             |
|                      | 9                            | Over 75mm/hr                                                                           |
| Weather Type         | clearday, clearnight         | Total cloud cover less than 20%                                                        |
|                      | pcloudyday, pcloudynight     | Total cloud cover between 20%-60%                                                      |
|                      | mcloudyday, mcloudynight     | Total cloud cover between 60%-80%                                                      |
|                      | cloudyday, cloudynight       | Total cloud cover over over 80%                                                        |
|                      | humidday, humidnight         | Relative humidity over 90% with total cloud cover less than 60%                        |
|                      | lightrainday, lightrainnight | Precipitation rate less than 4mm/hr with total cloud cover more than 80%               |
|                      | oshowerday, oshowernight     | Precipitation rate less than 4mm/hr with total cloud cover between 60%-80%             |
|                      | ishowerday, ishowernight     | Precipitation rate less than 4mm/hr with total cloud cover less than 60%               |
|                      | lightsnowday, lightsnownight | Precipitation rate less than 4mm/hr rainday, rainnight  Precipitation rate over 4mm/hr |
|                      | snowday, snownight           | Precipitation rate over 4mm/hr                                                         |
|                      | rainsnowday, rainsnownight   | Precipitation type to be ice pellets or freezing rain                                  |
|                      | tsday, tsnight               | Lifted Index less than -5 with precipitation rate below 4mm/hr                         |
|                      | tsrainday, tsrainnight       | Lifted Index less than -5 with precipitation rate over 4mm/h                           |
| 10m Wind Direction   | N, NE, E, SE, S, SW, W, NW   |                                                                                        |
| Precipitation Type   | snow, rain, frzr (freezing rain), icep (ice pellets), none |                                                          |
| Undefined            | -9999                        | Undefined                                                                              |

[source](http://ftp.astron.ac.cn/doc.php?lang=en)
