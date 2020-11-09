---
permalink: /
title: ""
excerpt: "About me"
author_profile: true
redirect_from: 
  - /about/
  - /about.html
---

# About Me
I'm a Postdoc Ecologist at the [USDA-ARS Jornada Experimental Range](https://jornada.nmsu.edu/). I finished my PhD in 2019 at the University of Florida in the [White Lab](https://www.weecology.org). My research centers around the implemenation and evaluation of ecological forecasts. From this I've become skilled in programming (R & python), using high performance computing, and applying ecological models to large scale weather and climate data. Previously I obtained an undergraduate degree in Ecology from the University of Idaho and spent four years working for the US Forest Service, BLM, and Agricultural Research Service. I'm an expert in plants in the Western U.S.A., especially grasses.   

### Highlights

I implemented a suite of [plant phenology models](https://pyphenology.readthedocs.io) in python and used it to build a system for [national phenology forecasts](https://phenology.naturecast.org) which update every week. The weekly modelling is done via custom Python scripts while the site is built on django and some simple javascript. The system is described fully in [Taylor & White, 2020](https://doi.org/10.1002/eap.2025). 

More recently I did a similar project for grassland phenology models. I transcribed a [grassland productivity/hydrology model](https://doi.org/10.1038/nclimate2942) from fortran into python and applied it to downscaled CMIP5 projections. I was really proud about successfully using the xarray apply_ufunc function to run this on an HPC using dask.  
For this project I focused on the user interface much more than the phenology one. I used design principles from National Climate Report [recommendations](https://www.umdindicators.org/wp-content/uploads/2017/01/Visual-Design-Guidance-Document-V1.0.pdf) on graphics, which emphasizes things like simple layouts and highlighting data with text as well as color. This one I built with python dash. See [https://github.com/sdtaylor/GrasslandModels](https://github.com/sdtaylor/GrasslandModels) and [http://grassland-forecast.com](http://grassland-forecast.com).  

Besides my phenology work I also have experience with large scale carbon analysis. I wrote a reply to the infamous [2019 Science article](https://doi.org/10.1126/science.aax0848) on tree restoration. I used global datasets of current tree cover and biomass to show the carbon storage potential proposed in the original study was really unreasonable. It was rejected from Science as an official reply but eventually published by invitation in Annals of Forest Science ([https://doi.org/10.1101/730325](https://doi.org/10.1101/730325)).  
