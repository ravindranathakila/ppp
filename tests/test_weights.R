# Example of weights calculation for the PPP
# W. Probert, 2015

# Set the path to the project folder
main_d <- file.path('/', 'Users', 'wjmprobert', 'Downloads', 'Martina_code')

# Import the weighting functions
source(file.path(main_d, "R", "SetupWeights.R"))
source(file.path(main_d, "R", "UpdateWeightsII.R"))
source(file.path(main_d, "R", "CalculateWeightsII.R"))

###################### REPRESENTATIVENESS

# From Bennett et al (2014) ... 
# Thus, a species from a genus containing three species, two of which are
# threatened, would have Ri =1+2/3+0+0=1.66 ...

weights.data <- data.frame(species_id = 1:7, 
    sciname = letters[1:7],
    genus = c("G1", "G1", "G1", "G2", "G2", "G3", "G3"),
    family = "F1", 
    order = "O1", 
    Endem.spp = 1, 
    Endem.gen = 1, 
    Endem.fam = 1)

weights.data <- SetupWeights(weights.data)

# Remove species 1 and 2 from 'secure' list (so they're now threatened)
weights.data <- UpdateWeightsII(weights.data, 
    just.removed = c(1, 2), 
    remaining = c(3, 4, 5, 6, 7))

# Calculate Representativeness (R) (and output it to screen)
within(weights.data$w, {
    R <- 1 + (As/Bs)*Ts + (Ag/Bg)*Tg + (Af/Bf)*Tf
})


# From Bennett et al (2014) ... 
# ... while the sole species from a genus in a family containing another genus 
# that is secure would have Ri =1+1/1+1/2+0=2.5.

weights.data <- data.frame(species_id = 1:3, 
    sciname = letters[1:3],
    genus = c("G1", "G2", "G2"),
    family = "F1", 
    order = "O1", 
    Endem.spp = 1, 
    Endem.gen = 1, 
    Endem.fam = 1)

weights.data <- SetupWeights(weights.data)

# Remove species 1 from 'secure' list (so it's now threatened)
weights.data <- UpdateWeightsII(weights.data, 
    just.removed = c(1), 
    remaining = c(2, 3))

# Calculate Representativeness (R) (and output it to screen)
within(weights.data$w, {
    R <- 1 + (As/Bs)*Ts + (Ag/Bg)*Tg + (Af/Bf)*Tf
})
