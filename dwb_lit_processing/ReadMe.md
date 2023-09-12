
# Dead wood and Litter pools computation

The script described here below is used to derive from Above Ground Biomass two additional  carbon pools:
* **Dead Wood Biomass**
* **Litter**

The procedure is based on the methodology proposed by  
Harris, N.L., Gibbs, D.A., Baccini, A. _et al._ Global maps of twenty-first century forest carbon fluxes. _Nat. Clim. Chang._ **11,** 234–240 (2021). https://doi.org/10.1038/s41558-020-00976-6  
In short, three datasets (ecozones, elevation and precipitation) are reclassed and combined. For each unique combination of classes, the corresponding Dead Wood Biomass (DWB) and Litter (LIT)  coefficients provided in table S4 of the mentioned article are assigned to each pixel and the two resulting maps are multiplied by AGB map in order to derive DWB and LIT datasets.

## Input data

- [**Above ground Biomass** v. 4 (2020)](https://catalogue.ceda.ac.uk/uuid/af60720c1e404a9e9d2c145d2b2ead4e)
- [**FAO Global Ecological Zones** (GEZ 2010, second edition)](https://data.apps.fao.org/map/catalog/srv/eng/catalog.search?currTab=simple&id=47105#/metadata/2fb209d0-fd34-4e5e-a3d8-a13c241eb61b)
- [**GEBCO 2023** Digital Bathymetry  Model](https://www.gebco.net/data_and_products/gridded_bathymetry_data/#global)
- [**Worldclim monthly rainfall** version 2](http://worldclim.org/version2)

The script [process_dwb_lit.sh](./process_dwb_lit.sh) is entirely based on GRASS routines.
Environment variables of the bash script are set in [dwb_lit.conf](./dwb_lit.conf) file.
Prerequisites:
1. The GRASS DB must already contain, in the working mapset defined by  the configuration file,  a map for AGB and a reclass version of AGB (used here as mask to get null values where AGB has No data).
2. Elevation and Rainfall layers must already exist in the GRASS DB.
3. GEZ map reclassified and resampled to AGB resolution for computation of [Below Ground Biomass](https://github.com/giacomo-gcad/carbon/tree/master/bgb_processing) must already exist in the GRASS DB.

## Workflow
Here below each step of the procedure is shortly described.

### Processing Rainfall
1. Annual rainfall is derived as the sum  of the 12 monthly rainfall maps
2. Annual rainfall map is grown by 300 km radius in order to fill eventual gaps on coastal areas due to different coastlines and resolutions with respect to the other input datasets.
3. Annual rainfall is reclassed as follows:

> < 1000 mm/yr = 1  
> 1000 - 1600	mm/yr = 2  
> \> 1600 mm/yr = 3  

4. Reclassed map is resampled to AGB resolution (3.2 arcseconds, approximately 100m at the equator) using Nearest Neighbor algorithm.

### Processing Elevation
1. GEBCO 2023 map is reclassed as follows:
> < 2000 m. a.s.l. = 10  
> \> 2000 m. a.s.l. = 20  
2. Reclassed map is resampled to AGB resolution (3.2 arcseconds, approximately 100m at the equator) using Nearest Neighbor algorithm.

### Processing Global Ecological Zones
1. GEZ 2010 is reclassed as follows:  
> Tropical rainforest = 100  
> Tropical moist forest = 100  
> Tropical dry forest = 100  
> Subtropical humid forest = 100  
> Subtropical dry forest = 100  
> Subtropical steppe = 100  
> Temperate oceanic forest = 200  
> Temperate continental forest = 200  
> Temperate mountain system = 200  
> Boreal coniferous forest = 200  
> Boreal tundra woodland = 200  
> Boreal mountain system = 200  

The input dataset has already the same extent and resolution of AGB, therefore no resampling is needed.  

### Crossing input maps
Each of the output maps obtained from each of the steps above described is reclassed using a different order of magnitude (units, tens and hundreds for Rainfall, Elevation and Ecological zone, respectively). 
Therefore, they can be summed up without risks of mixing classes. The resulting value of each pixel will be an unique numeric code where 
- the first digit represents the Ecological zone class;
- the second digit  represents the Elevation class;
- the third digit  represents the Annual Rainfall class.

For example, the combination  Temperate/Boreal (**200**), Elevation < 2000 m a.s.l. (**10**) and Rainfall > 1600 mm/yr (**3**) will result in code **213**  

### Getting Dead Wood Biomass and Litter datasets
1. The map with unique codes obtained at previous step is reclassed twice, once for DWB and once for LIT, assigning the coefficients below (as from table S4 of the mentioned article):  

| Climate  (GEZ)   | Elevation (m) | Rainfall  (mm/yr) | Dead Wood fraction of AGB | Litter fraction of AGB |
| ---------------- | :-----------: | :---------------: | :-----------------------: | :--------------------: |
| Tropical         | <2000         | <1000             |     0.02                  |    0.04                |           
| Tropical         | <2000         | 1000-1600         |     0.01                  |    0.01                |
| Tropical         | <2000         | >1600             |     0.06                  |    0.01                |
| Tropical         | >2000         | All               |     0.07                  |    0.01                |
| Temperate/Boreal | All           | All               |     0.08                  |    0.04                |

2. The two maps with coefficients are multiplied by AGB map to get Dead Wood Biomass and Litter maps. Measurement units are the same of AGB (Mg/ha). 

Last Run: 07/09/2023 (whole procedure re-run using the AGB 2020 dataset).  