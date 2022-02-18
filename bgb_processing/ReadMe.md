
# Below Ground Biomass computation

The script described here below is used to derive Below Ground Biomass (BGB) from Above Ground Biomass (AGB)
The procedure has been developed by Eduardo Bendito and later modified/optimized by Giacomo Delli.  

The procedure aims to spatialize at global level the conversion scheme from AGB to BGB proposed in [Chapter 4](https://www.ipcc-nggip.iges.or.jp/public/2019rf/pdf/4_Volume4/19R_V4_Ch04_Forest%20Land.pdf) of the [2019 Refinement to the 2006 IPCC Guidelines for National Greenhouse Gas Inventories (IPCC, 2019)](https://www.ipcc.ch/report/2019-refinement-to-the-2006-ipcc-guidelines-for-national-greenhouse-gas-inventories/), which indicates the most updated root-to-shoot ratios (Table 4.4).  


In short, each of the parameters considered by IPCC is evaluated through a global spatial dataset. Each dataset is reclassed. The combination of all datasets provides a layer where the corresponding R score (as per IPCC table 4.4) is assigned to each unique combination of classes. In the last step, the R coefficients layer is multiplied by the AGB layer in order to derive the BGB.



## Input data

Here below the list of IPCC parameters and corresponding spatial datasets used:

| Parameter                      | Dataset                                                                                                                            |
|--------------------------------|------------------------------------------------------------------------------------------------------------------------------------|
| Above Ground Biomass           | [Above Ground Biomass  v. 3 (2018)](https://catalogue.ceda.ac.uk/uuid/5f331c418e9f4935b8eb1b836f8a91b8)                            |
| Ecological Zones               | [FAO Global Ecological Zoning](http://www.fao.org/geonetwork/srv/en/main.home)                                                     |
| Continents (terrestrial)       | [ESRI World Continents dataset](https://www.arcgis.com/home/item.html?id=a3cb207855b348a297ab85261743351d) and [Global Administrative Unit Layers (GAUL), rev. 2015](http://www.fao.org/geonetwork/srv/en/metadata.show?id=12691)                 |
| Continents (marine)            | [Exclusive Economic Zones (EEZ) v9](http://www.marineregions.org/downloads.php)                                                    |
| Origin (Natural/Planted)       | [Spatial Database of Planted Trees v. 1, 2019](http://data.globalforestwatch.org/datasets/224e00192f6d408fa5147bbfc13b62dd)        |
| Land Cover (Broadleaf/Conifer) | [Land Cover CCI, 2017](http://maps.elie.ucl.ac.be/CCI/viewer/index.html)                                                           |
| Quercus (*)                    | [Statistical mapping of tree species over Europe (Brus et al.,2011)](http://dataservices.efi.int/tree-species-map/register.php)    |  

(*) data for Quercus are available only for Europe.

## Data Processing   
Each input layer is resampled (if needed) to the same extent and resolution of AGB and reclassed. For reclass, **a different order of magnitude** is used for each layer, so that in the and they can be summed up to derive a synthesis layer where each value is a numeric code that can be translated into the corresponding sequence of classes. In this way it is possible to build a consistent Look Up Table to be used later in order to replace each numeric code with the corresponding R (BGB/AGB ratio) coefficient.  
This method is alternative to the use of the GRASS function **r.cross**, where layers are combined and a random value is assigned to each unique combination of classes. The grass function diadavantage is that there is no guarantee over time that the same pixel value will correspond to the same combination of classes, forcing to manually build up a new Look Up Table after each run.  
In the last step, the final layer with R coefficients is multiplied by the AGB layer to get the BGB.  

### [Above Ground Biomass](https://github.com/giacomo-gcad/carbon/tree/master/bgb_processing/AGB)  
The original dataset is imported in grass DB as external link and reclassed as follows:  

> 1  - 75 = 1  
> 76 - 125 = 2  
> No Data = 3  

### [Global Ecological Zones](https://github.com/giacomo-gcad/carbon/tree/master/bgb_processing/GEZ_2010)  
Here we used a modified version (**procedure to be described**) of Global Ecological Zones, where polygons along coastlines are 
- made to grow 300 km outward in order to avoid null values in areas with valid AGB values  
- resampled to AGB extent and resolution (3.2 arcseconds, approximately 100m at the equator) using Nearest Neighbor algorithm.  
This modified version, already imported in grass DB, is reclassed as follows:  

| code | GEZ class                    | New class                    | New code      |
|------|------------------------------|------------------------------|---------------|
| 11   | Tropical rainforest          | Tropical rainforest          | 1100000       |
| 12   | Tropical moist forest        | Tropical moist forest        | 1200000       |
| 13   | Tropical dry forest          | Tropical dry forest          | 1300000       |
| 14   | Tropical shrubland           | Tropical shrubland           | 1300000       |
| 15   | Tropical desert              | Tropical shrubland           | 1300000       |
| 16   | Tropical mountain system     | Tropical moist forest        | 1200000       |
| 21   | Subtropical humid forest     | Subtropical humid forest     | 2100000       |
| 22   | Subtropical dry forest       | Subtropical dry forest       | 2200000       |
| 23   | Subtropical steppe           | Subtropical steppe           | 2300000       |
| 24   | Subtropical desert           | Subtropical steppe           | 2300000       |
| 25   | Subtropical mountain system  | Subtropical dry forest       | 2200000       |
| 31   | Temperate oceanic forest     | Temperate oceanic forest     | 3100000       |
| 32   | Temperate continental forest | Temperate continental forest | 3200000       |
| 33   | Temperate steppe             | Temperate continental forest | 3200000       |
| 34   | Temperate desert             | Temperate continental forest | 3200000       |
| 35   | Temperate mountain system    | Temperate mountain system    | 3500000       |
| 41   | Boreal coniferous forest     | Boreal                       | 4000000       |
| 42   | Boreal tundra woodland       | Boreal                       | 4000000       |
| 43   | Boreal mountain system       | Boreal                       | 4000000       |
| 50   | Polar                        | Boreal                       | 4000000       |
| 90   | Water                        | Removed                      | -             |


### [Continents](https://github.com/giacomo-gcad/carbon/tree/master/bgb_processing/Continents)  
As for Global Ecological Zones, here we used a modified version (**procedure to be described**) of the GAUL and EEZ datasets, where:  
- GAUL and EEZ layers (dissolved) are merged with the [ESRI Continents dataset](https://www.arcgis.com/home/item.html?id=a3cb207855b348a297ab85261743351d) in order to avoid null values in areas with valid AGB values  
- Marine part of Europe and Asia continents has been manually splitted by extending northward the boundary of terrestrial part  
- the resulting vector is rasterized at the same resolution of AGB (3.2 arcseconds, approximately 100m at the equator) using Nearest Neighbor algorithm.  

The resulting continents raster layer is reclassed as follows:  
> Africa = 10000  
> Americas = 20000  
> Asia = 30000  
> Europe = 40000  
> Oceania = 50000  
> Antartica = 60000  

The reclassed layer is then resampled at the extent and resolution of AGB dataset (3.2 arcseconds, approximately 100m at the equator) using Nearest Neighbor algorithm.  

### [Land cover](https://github.com/giacomo-gcad/carbon/tree/master/bgb_processing/LandCover)  
Presently, the 300m resolution ESA-CCI Land Cover is used to classify land cover in three classes: broadleaf, needleleaf and mosaic.  
The ESA-CCI land cover layer for 2018 is reclassed as follows:  

> No data = mosaic (1000)  
> Cropland, rainfed = mosaic (1000)  
> Herbaceous cover = mosaic (1000)  
> Tree or shrub cover = mosaic (1000)  
> Cropland, irrigated or post-flooding = mosaic (1000)  
> Mosaic cropland (>50%) / natural vegetation (tree, shrub, herbaceous cover) (<50%) = mosaic (1000)  
> Mosaic natural vegetation (tree, shrub, herbaceous cover) (>50%) / cropland (<50%)  = mosaic (1000)  
> Tree cover, broadleaved, evergreen, closed to open (>15%) = broadleaf (2000)  
> Tree cover, broadleaved, deciduous, closed to open (>15%) = broadleaf (2000)  
> Tree cover, broadleaved, deciduous, closed (>40%) = broadleaf (2000)  
> Tree cover, broadleaved, deciduous, open (15-40%) = broadleaf (2000)  
> Tree cover, needleleaved, evergreen, closed to open (>15%) = needleleaf (3000)  
> Tree cover, needleleaved, evergreen, closed (>40%) = needleleaf (3000)  
> Tree cover, needleleaved, evergreen, open (15-40%) = needleleaf (3000)  
> Tree cover, needleleaved, deciduous, closed to open (>15%) = needleleaf (3000)  
> Tree cover, needleleaved, deciduous, closed (>40%) = needleleaf (3000)  
> Tree cover, needleleaved, deciduous, open (15-40%) = needleleaf (3000)  
> Tree cover, mixed leaf type (broadleaved and needleleaved) = mosaic (1000)  
> Mosaic tree and shrub (>50%) / herbaceous cover (<50%) = mosaic (1000)  
> Mosaic herbaceous cover (>50%) / tree and shrub (<50%) = mosaic (1000)  
> Shrubland = mosaic (1000)  
> Shrubland evergreen = mosaic (1000)  
> Shrubland deciduous = mosaic (1000)  
> Grassland = mosaic (1000)  
> Lichens and mosses = mosaic (1000)  
> Sparse vegetation (tree, shrub, herbaceous cover) (<15%) = mosaic (1000)  
> Sparse tree (<15%) = mosaic (1000)  
> Sparse shrub (<15%) = mosaic (1000)  
> Sparse herbaceous cover (<15%) = mosaic (1000)  
> Tree cover, flooded, fresh or brakish water = mosaic (1000)  
> Tree cover, flooded, saline water = mosaic (1000)  
> Shrub or herbaceous cover, flooded, fresh/saline/brakish water = mosaic (1000)  
> Urban areas = mosaic (1000)  
> Bare areas = mosaic (1000)  
> Consolidated bare areas = mosaic (1000)  
> Unconsolidated bare areas = mosaic (1000)  
> Water bodies = mosaic (1000)  
> Permanent snow and ice = mosaic (1000)  

The reclassed layer is then resampled at the extent and resolution of AGB dataset (3.2 arcseconds, approximately 100m at the equator) using Nearest Neighbor algorithm.  

### [Origin](https://github.com/giacomo-gcad/carbon/tree/master/bgb_processing/Plantation)  
This dataset is distributed as ESRI File Geodatabase. Processing includes the followings:

- All feature classes included in the GDB are imported and merged into a single Geopackage layer using GDAL libraries (ogr2ogr)  
- The resulting layer is rasterized at the AGB resolution using GDAL libraries (gdal_rasterize)  
- THe raster layer is imported as external link in GRASS and reclassed as follows:

> Natural (1) = 100  
> Planted (2) = 200  

The reclassed layer is then resampled at the extent and resolution of AGB dataset (3.2 arcseconds, approximately 100m at the equator) using Nearest Neighbor algorithm.  
  
**TBD**: remove input data from within bgb_processing folder and replace gdal functions with grass functions  


### [Quercus](https://github.com/giacomo-gcad/carbon/tree/master/bgb_processing/Quercus)  
This datset is distributed as TIFF raster layer. It is phisically imported in GRASS DB, then zero value is assigned to NULL. The resulting layer is reclassed as follows:  

> 1 - 12 = not quercus (0)  
> 14 - 18 = not quercus (0)  
> 20 - 255 = not quercus (0)  
> 13 and 19 = quercus (10)  

The reclassed layer is then resampled at the extent and resolution of AGB dataset (3.2 arcseconds, approximately 100m at the equator) using Nearest Neighbor algorithm.  
  
**TBD**: remove input data from within bgb_processing folder and replace gdal functions with grass functions.  


## BGB computation  


### [Crossing input maps and preparing R coefficients layer ](https://github.com/giacomo-gcad/carbon/tree/master/bgb_processing/rcl_cross)  

Each of the output maps obtained from each of the steps above described has been reclassed using a different order of magnitude (from units up to millions).   
Therefore, the six layers can be summed up without risks of mixing classes. The resulting value of each pixel will be an unique numeric code where each digit refers to a class of the corresponding dataset.  
For example, value **1123102** ccan be decoded as:  
Tropical rainforest (**1100000**), Americas (**20000**), Needleleaf (**3000**), Natural (**100**), without Quercus (**0**), with AGB values in range 75-125 (**2**).  

[Statistics](https://github.com/giacomo-gcad/carbon/tree/master/bgb_processing/rcl_cross/output_data/rcl_cross_stats.csv) on the resulting output are calculated with r.stats in order to get the full list of effectively existing combinations of classes.  
The csv  file with statistics is written in output and used as input in the template spreadsheet **[lut_rcoeffs.ods](https://github.com/giacomo-gcad/carbon/tree/master/bgb_processing/rcl_cross)**. The following steps have to be manually done:  

- Paste data from [Statistics](https://github.com/giacomo-gcad/carbon/tree/master/bgb_processing/rcl_cross/output_data/rcl_cross_stats.csv) file into sheet rcl_cross_stats (columns A and B) of the template spreadsheet
- The VLOOKUP formula in column C assigns the R coefficient to each code, using as source the full list of 820 combinations in sheet 'r_coefficients'. Manually check this column to verify the absence of errors or of  missing data.   
The formula is provided for a total of 744 combinations (those actually existing when run on AGB v.2, 2018 dataset). It could be necessary to copy the formula in missing cells if more combinations are obtained.  
- Export as text file the content of column A in sheet 'recode_file'. It will be used as [reclass file](https://github.com/giacomo-gcad/carbon/tree/master/bgb_processing/BGB/assign_r_coeffs.rcl)  in the successive step.  


### [Getting Below Ground Biomass](https://github.com/giacomo-gcad/carbon/tree/master/bgb_processing/BGB)  
The reclass file exported in the previous step provides the look up table needed to convert the unique numeric codes to IPCC R coefficients. This is done with the GRASS module `r.recode`
The raster layer with R coefficients is then multiplied by the Above Ground Biomass layer to get the final **Below Ground Biomass layer**.  
 

[...]  

