# Example PPP on mock data with overlaps
# W. Probert, 2015

directory <- file.path('/', 'Users', 'wjmprobert', 'Projects', 'ppp')

setwd(directory)

# Import the functions to run the PPP
source(file.path(directory, "ppp", "R", "MakeOverlaps.R"))
source(file.path(directory, "ppp", "R", "UpdateWeightsII.R"))
source(file.path(directory, "ppp", "R", "CalculateWeightsII.R"))
source(file.path(directory, "ppp", "R", "NewCalcCosts.R"))
source(file.path(directory, "ppp", "R", "NewSetupCosts3.R"))
source(file.path(directory, "ppp", "R", "PrioritisationII.R"))
source(file.path(directory, "ppp", "R", "SetupWeights.R"))

# Load the mock data, 5 species each with 4 actions.  
source(file.path(directory, "tests", "ppp_pseudo_overlap_data.R"))

# Run the PPP
ppp <- PrioritisationII(directory, weighting,multiplier,
    set_budget, overlap.indicator, discount.rate, T, stop.iteration,
    stop.no.of.species, a.data, b.data, o.data, w.data, all.costs)
