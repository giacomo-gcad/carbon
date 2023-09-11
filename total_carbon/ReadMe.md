# Computing Total Carbon dataset  /

This procedure is used to compute the total carbon dataset, as the sum of individual Carbon pools.  

Before summing up the five carbon pools, for each pool:  
- pixel measurement units are converted from density (Mg/ha) to amount (Mg), by multiplying each pixel value for the actual area (in ha) of that pixel.  
- the [forest mask](../forest_mask/ReadMe.md) is applied in order to set to NULL all non-forest pixels

Then, the five pools are summed up tu produce the Total Carbon dataset. The script [compute_total_carbon.sh](./compute_total_carbon.sh) performs all the above described operations. 

Last Run: 11/09/2023 (whole procedure re-run using the AGB 2020 dataset).  
