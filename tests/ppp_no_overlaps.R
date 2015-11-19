# Example PPP on mock data with no overlap codes.  
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
source(file.path(directory, "tests", "ppp_pseudo_data.R"))

# Run the PPP
ppp <- PrioritisationII(directory, weighting,multiplier,
    set_budget, overlap.indicator, discount.rate, T, stop.iteration,
    stop.no.of.species, a.data, b.data, o.data, w.data, all.costs)


# Look at some output...

# Such as the list of species removed, the 'iteration' column 
# shows the iteration of the PPP in which that species was removed
ppp$removed.spp.df

# List of first year budgets for each iteration
ppp$firstyear.budgets

# List of full budgets for each iteration of the PPP
ppp$full.budgets

# Any species that were initially removed (in the first iteration)
# because W or B or S were zero.  
ppp$initially_removed

# The date and time when the PPP finished
ppp$date
