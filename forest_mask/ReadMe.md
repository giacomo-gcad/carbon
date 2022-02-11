# Preparing a Forest Mask

This procedure is used to set up a Forest Mask layer, used at a later stage to mask each Carbon pool to only forest areas.  

Three different datasets are used to defin forest areas:  

1. [Copernicus Land Cover map (year 2018)](https://land.copernicus.eu/global/products/lc): only classes from 111 to 126 are kept.  

2. [UNEP - WCMC Global Mangrove Watch (year 2016)](https://data.unep-wcmc.org/datasets/45): pixels classified as Mangroves are removed from mask.

3. [Oil Palm Plantations (year 2019)](https://essd.copernicus.org/articles/13/1211/2021/): pixels classified as Oil Palm Plantation are removed from mask.  


The script [process_forest_mask.sh](./process_forest_mask.sh) performs the following operations:  

1. Import, reclass and resample to Above Ground Biomass resolution the Copernicus Land Cover map;  
2. Import, reclass and resample to Above Ground Biomass resolution the Mangroves map;
3. Import, reclass and resample to Above Ground Biomass resolution the Oil Palm Plantations map;
4. Overaly the three layers above to derive the final Forest Mask. 

The mask is then applied to each individual Carbon pool in the [total carbon](https://github.com/giacomo-gcad/carbon/tree/master/total_carbon) step.

