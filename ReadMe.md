# Carbon Stocks in Protected Areas

This repository provides workflows for 
-  computation of the various pools of carbon at global level. 
-  computation of statistics of total carbon stock at PA and country level.

## Computation of carbon pools

Total Carbon Stock is composed by 5 different 'pools'
1. Soil Carbon (SOC)
2. Above Ground Carbon (AGB)
3. [Below Ground Carbon (BGB)](/bgb_processing)
4. [Dead Wood Carbon (DWB)](/dwb_lit_processing)
5. [Litter Carbon (LIT)](/dwb_lit_processing)

Global spatial datasets area already available for Soil Carbon and Above Ground Carbon, while the three remaining pools need to be estimated as fractions of Above Ground Carbon.  

Once each carbon pool has been processed, the five carbon pools are summed upto get the Total Carbon dataset.
For each layer (Except GSOC):
- the biomass density (Mg/ha) is converted to biomass amount, multiplying each pixel value for the area of that pixel: output units are Mg.  
- Biomass is converted to carbon by dividig by 2.
- the layer is downscaled to the same resolution of GSOC (approximately 1 km at the equator). When resampling, pixel values are summed up. The output represents the amount of biomass (in Mg) in each 30 arc-seconds pixel.  

For GSOC, only the conversion from carbon density to carbon amount is done.

The script [compute_total_carbon.sh](./compute_total_carbon.sh) executes all the operations described above.  


## Analysis of Carbon pools in Protected Areas

[...]


