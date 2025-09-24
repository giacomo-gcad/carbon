# Computing Total Carbon dataset  

This procedure is used to compute the total carbon dataset, as the sum of individual Carbon pools.  

Before summing up the five carbon pools, for each pool:  
- pixel measurement units are converted from density (Mg/ha) to amount (Mg), by multiplying each pixel value for the actual area (in ha) of that pixel.  
- the [forest mask](../forest_mask/ReadMe.md) is applied in order to set to NULL all non-forest pixels.

Then, the five pools are summed up tu produce the Total Carbon dataset. The script [compute_total_carbon.sh](./compute_total_carbon.sh) performs all the above described operations, providing in  output two different versions of each pool and of the Total Carbon:
- with forest mask (*_fm)  
- without forest mask.  

After checking final outputs, and ONLY if evertything is fine, it's worth to run [clean_up.sh](./clean_up.sh) to remove the useless, intermediate layers and scripts.

Last Run: 04/07/2025 (whole procedure re-run using the AGB 2022 v.6 dataset).  

