# Carbon Stocks in Protected Areas

This repository provides workflows for 
-  computation of the various pools of carbon at global level. 
-  computation of statistics of total carbon stock at PA and country level.

## Computation of carbon pools

Total Carbon Stock is composed by 5 different 'pools'. Two of them (AGB and GSOC) are open access data, wile the remaining three are derived  *in house * from AGB:  


1. [Global Soil Carbon (GSOC), v. 1.5](http://54.229.242.119/GSOCmap/)
2. [Above Ground Carbon (AGB), v.3 (2018)](https://catalogue.ceda.ac.uk/uuid/5f331c418e9f4935b8eb1b836f8a91b8)
3. [Below Ground Carbon (BGB)](/bgb_processing)
4. [Dead Wood Carbon (DWB)](/dwb_lit_processing)
5. [Litter Carbon (LIT)](/dwb_lit_processing)

Global spatial datasets area already available for Soil Carbon and Above Ground Carbon, while the three remaining pools need to be estimated as fractions of Above Ground Carbon.  

Once each carbon pool has been processed, the five carbon pools are summed up to get the Total Carbon dataset.
For each layer (except GSOC):
- the biomass density (Mg/ha) is converted to biomass amount, multiplying each pixel value by the area (in ha) of that pixel: output units are Mg.  
- Biomass is converted to carbon by dividig by 2.

The GSOC dataset is first resampled to the same resolution of the other carbon pools (3.2 arcseconds, no interpolation), then is converted from carbon density to carbon amount with the same method.

In the last step, the five carbon pools are summed up to derive the Total Carbon layer, expressed as amount of Carbon within each pixel (in Mg).  

The script [compute_total_carbon.sh](./compute_total_carbon.sh) executes all the operations described above.  

## Analysis of Carbon pools in Protected Areas

The [analysis of each carbon pool](/c_analysis) within protected areas, countries and ecoregions is performed using the same procedure used in DOPA workflow for the [analysis of continuous rasters](https://github.com/giacomo-gcad/dopa_workflow/tree/master/cep_analysis#CONTINUOUS_RASTERS).  

