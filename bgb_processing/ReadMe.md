
# Below Ground Biomass computation

The script described here below is used to derive Below Ground Biomass (BGB) from Above Ground Biomass (AGB)
The procedure has been developed by Eduardo Bendito and later modified/optimized by Giacomo Delli.  

The procedure aims to spatialize at global level the conversion scheme from AGB to BGB proposed in [Chapter 4](https://www.ipcc-nggip.iges.or.jp/public/2019rf/pdf/4_Volume4/19R_V4_Ch04_Forest%20Land.pdf) of the [2019 Refinement to the 2006 IPCC Guidelines for National Greenhouse Gas Inventories (IPCC, 2019)](https://www.ipcc.ch/report/2019-refinement-to-the-2006-ipcc-guidelines-for-national-greenhouse-gas-inventories/), which indicates the most updated root-to-shoot ratios (Table 4.4).  


In short, each of the parameters considered by IPCC is evaluated through a global spatial dataset. Each dataset is reclassed. The combination of all datasets provides a layer where the corresponding R score (as per IPCC table 4.4) is assigned to each unique combination of classes. In the last step, the R coefficients layer is multiplied by the AGB layer in order to derive the BGB.



## Input data

Here below the list of IPCC parameters and corresponding spatial datasets used:

| Parameter                      | Dataset                                                                                                                            |
|--------------------------------|------------------------------------------------------------------------------------------------------------------------------------|
| Ecological Zones               | [FAO Global Ecological Zoning](http://www.fao.org/geonetwork/srv/en/main.home)                                                     |
| Above ground Biomass           | [Above ground Biomass  v. 2 (2018)](https://catalogue.ceda.ac.uk/uuid/84403d09cef3485883158f4df2989b0c)                            |
| Ecological Zones               | [FAO Global Ecological Zoning](http://www.fao.org/geonetwork/srv/en/main.home)                                                     |
| Continents (terrestrial)       | [Global Administrative Unit Layers (GAUL), rev. 2015](http://www.fao.org/geonetwork/srv/en/metadata.show?id=12691)                 |
| Continents (marine)            | [Exclusive Economic Zones (EEZ) v9](http://www.marineregions.org/downloads.php)                                                    |
| Origin (Natural/Planted)       | [Spatial Database of Planted Trees v. 1, 2019](http://data.globalforestwatch.org/datasets/224e00192f6d408fa5147bbfc13b62dd)        |
| Land Cover (Broadleaf/Conifer) | [Land Cover CCI, 2017](http://maps.elie.ucl.ac.be/CCI/viewer/index.html)                                                           |
| Quercus (*)                    | [Statistical mapping of tree species over Europe (Brus et al.,2011)](http://dataservices.efi.int/tree-species-map/register.php)    |  

(*) data for Quercus are available only for Europe. For the other continents

## Data Processing   
[...]  
(to be developed)

### [Above Ground Biomass}(https://github.com/giacomo-gcad/carbon/tree/master/bgb_processing/AGB)  

### {Global Ecological Zones](https://github.com/giacomo-gcad/carbon/tree/master/bgb_processing/GEZ_2010)  

### {Continents](https://github.com/giacomo-gcad/carbon/tree/master/bgb_processing/Continents)  

### {Land cover]()  

### {Origin]()  

### {Quercus]()  

### {Crossing input maps]()  

### {Getting Below Ground Biomass]()  

[...]  


