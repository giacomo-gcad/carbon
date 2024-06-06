# Carbon Stocks in Protected Areas

This repository provides workflows for 
-  computation of the various pools of carbon at global level. 
-  computation of statistics of total carbon stock at PA, country and ecoregion level.

## Computation of carbon pools

Total Carbon Stock is composed by 5 different 'pools'. Two of them (AGB and GSOC) are public global spatial datasets, while while the three remaining pools are derived *in house* as fractions of Above Ground Carbon:  


1. [FAO Global Soil Carbon (GSOC), v. 1.6](http://54.229.242.119/GSOCmap/)
2. [ESA Biomass CCI Above Ground Carbon (AGB), v.4 (2020)](https://catalogue.ceda.ac.uk/uuid/af60720c1e404a9e9d2c145d2b2ead4e)
3. [Below Ground Carbon (BGB)](/bgb_processing)
4. [Dead Wood Carbon (DWB)](/dwb_lit_processing)
5. [Litter Carbon (LIT)](/dwb_lit_processing)

Once each carbon pool has been processed, the five carbon pools are summed up to get the Total Carbon dataset.  
For each layer (except GSOC):
- the biomass density (Mg/ha) is converted to biomass amount, multiplying each pixel value by the area (in ha) of that pixel: output units are Mg.  
- Biomass is converted to carbon with a Biomass to carbon ratio of 0.5 for all pools.

The GSOC dataset is first resampled to the same resolution of the other carbon pools (3.2 arcseconds, no interpolation), then is converted from carbon density to carbon amount with the same method. This is done in the [last step](/total_carbon), before summing the various pools.

In the last step, the five carbon pools are summed up to derive the [Total Carbon](/total_carbon) layer, expressed as amount of Carbon within each pixel (in Mg).  
A [forest mask](/forest_mask) is applied to each final layer in order to limit the results to forest areas.


## Analysis of Carbon pools in Protected Areas

The [analysis of each carbon pool](/c_analysis) within protected areas, countries and ecoregions is performed using the same procedure used in DOPA workflow for the [analysis of continuous rasters](https://github.com/giacomo-gcad/dopa_workflow/tree/master/cep_analysis#CONTINUOUS_RASTERS).  
