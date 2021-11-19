
# Below Ground Biomass computation

The script described here below is used to derive Below Ground Biomass (BGB) from Above Ground Biomass (AGB)
The procedure has been developed by Eduardo Bendito and later modified/optimized by Giacomo Delli.  

The procedure aims to spatialize at global level the conversion scheme from AGB to BGB proposed in [Chapter 4](https://www.ipcc-nggip.iges.or.jp/public/2019rf/pdf/4_Volume4/19R_V4_Ch04_Forest%20Land.pdf) of the [2019 Refinement to the 2006 IPCC Guidelines for National Greenhouse Gas Inventories (IPCC, 2019)](https://www.ipcc.ch/report/2019-refinement-to-the-2006-ipcc-guidelines-for-national-greenhouse-gas-inventories/), which indicates the most updated root-to-shoot ratios (Table 4.4).  


In short, each of the parameters considered by IPCC is evaluated through a global spatial dataset. Each dataset is reclassed. The combination of all datasets provides a layer where the corresponding R score (as per IPCC table 4.4) is assigned to each unique combination of classes. In the last step, the R coefficients layer is multiplied by the AGB layer in order to derive the BGB.



## Input data

Here below the list of IPCC parameters and corresponding spatial datasets used:

| Parameter                      | Dataset                                                                                                                            |
|--------------------------------|------------------------------------------------------------------------------------------------------------------------------------|
| Above Ground Biomass           | [Above Ground Biomass  v. 2 (2018)](https://catalogue.ceda.ac.uk/uuid/84403d09cef3485883158f4df2989b0c)                            |
| Ecological Zones               | [FAO Global Ecological Zoning](http://www.fao.org/geonetwork/srv/en/main.home)                                                     |
| Continents (terrestrial)       | [ESRI World Continents dataset](https://www.arcgis.com/home/item.html?id=a3cb207855b348a297ab85261743351d) and [Global Administrative Unit Layers (GAUL), rev. 2015](http://www.fao.org/geonetwork/srv/en/metadata.show?id=12691)                 |
| Continents (marine)            | [Exclusive Economic Zones (EEZ) v9](http://www.marineregions.org/downloads.php)                                                    |
| Origin (Natural/Planted)       | [Spatial Database of Planted Trees v. 1, 2019](http://data.globalforestwatch.org/datasets/224e00192f6d408fa5147bbfc13b62dd)        |
| Land Cover (Broadleaf/Conifer) | [Land Cover CCI, 2017](http://maps.elie.ucl.ac.be/CCI/viewer/index.html)                                                           |
| Quercus (*)                    | [Statistical mapping of tree species over Europe (Brus et al.,2011)](http://dataservices.efi.int/tree-species-map/register.php)    |  

(*) data for Quercus are available only for Europe.

## Data Processing   
[...]  
(to be developed)

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
- resampled to AGB extent and resolution.  
This modified version, already imported in grass DB, is reclassed as follows:  

| code | GEZ class                    | New class                    | New code |
|------|------------------------------|------------------------------|----------|
| 11   | Tropical rainforest          | Tropical rainforest          | 11       |
| 12   | Tropical moist forest        | Tropical moist forest        | 12       |
| 13   | Tropical dry forest          | Tropical dry forest          | 13       |
| 14   | Tropical shrubland           | Tropical dry forest          | 13       |
| 15   | Tropical desert              | Tropical shrubland           | 13       |
| 16   | Tropical mountain system     | Tropical moist forest        | 12       |
| 21   | Subtropical humid forest     | Subtropical humid forest     | 21       |
| 22   | Subtropical dry forest       | Subtropical dry forest       | 22       |
| 23   | Subtropical steppe           | Subtropical steppe           | 23       |
| 24   | Subtropical desert           | Subtropical steppe           | 23       |
| 25   | Subtropical mountain system  | Subtropical dry forest       | 22       |
| 31   | Temperate oceanic forest     | Temperate oceanic forest     | 31       |
| 32   | Temperate continental forest | Temperate continental forest | 32       |
| 33   | Temperate steppe             | Temperate continental forest | 32       |
| 34   | Temperate desert             | Temperate continental forest | 32       |
| 35   | Temperate mountain system    | Temperate mountain system    | 35       |
| 41   | Boreal coniferous forest     | Boreal                       | 40       |
| 42   | Boreal tundra woodland       | Boreal                       | 40       |
| 43   | Boreal mountain system       | Boreal                       | 40       |
| 50   | Polar                        | Boreal                       | 40       |
| 90   | Water                        | Removed                      | -        |


### [Continents](https://github.com/giacomo-gcad/carbon/tree/master/bgb_processing/Continents)  
As for Global Ecological Zones, here we used a modified version (**procedure to be described**) of the GAUL and EEZ datasets, where:  
- GAUL and EEZ layers (dissolved) are merged with the [ESRI Continents dataset](https://www.arcgis.com/home/item.html?id=a3cb207855b348a297ab85261743351d) in order to avoid null values in areas with valid AGB values  
- Marine part of Europe and Asia continents has been manually splitted by extending northward the boundary of terrestrial part  
- the resulting vector is rasterized at the same resolution of AGB.  

### [Land cover](https://github.com/giacomo-gcad/carbon/tree/master/bgb_processing/LandCover)  

### [Origin]()  

### [Quercus]()  

## BGB computation   
[...]  
(to be developed)

### [Crossing input maps]()  

### [Getting Below Ground Biomass]()  

[...]  


