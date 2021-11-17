
# Below Ground Biomass computation

The script described here below is used to derive Below Ground Biomass (BGB) from Above Ground Biomass (AGB)
The procedure has been developed by Eduardo Bendito and later modified/optimized by Giacomo Delli.  

The procedure aims to spatialize at global level the conversion scheme from AGB to BGB proposed in Chapter 4 of the 2019 Refinement to the 2006 IPCC Guidelines for National Greenhouse Gas Inventories (IPCC, 2019), which indicates the most updated root-to-shoot ratios (Table 4.4).


In short, three datasets (ecozones, elevation and precipitation) are reclassed and combined. For each unique combination of classes, the corresponding Dead Wood Biomass (DWB) and Litter (LIT)  coefficients provided in table S4 of the mentioned article are assigned to each pixel and the two resulting maps are multiplied by AGB map in order to derive DWB and LIT datasets.

## Input data

- **Above ground Biomass** v. 2 (2018) (as soon as it will be published, it will be replaced by v. 3)  
[https://catalogue.ceda.ac.uk/uuid/84403d09cef3485883158f4df2989b0c](https://catalogue.ceda.ac.uk/uuid/84403d09cef3485883158f4df2989b0c)
- **FAO Global Ecological Zones (GEZ 2010, second edition)**
[http://www.fao.org/geonetwork/srv/en/metadata.show?currTab=simple&id=47105](http://www.fao.org/geonetwork/srv/en/metadata.show?currTab=simple&id=47105)
- **GEBCO 2020** Digital Bathymetry  Model
[https://www.gebco.net/data_and_products/gridded_bathymetry_data/#global](https://www.gebco.net/data_and_products/gridded_bathymetry_data/#global)

[...]
