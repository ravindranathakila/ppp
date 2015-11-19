# Script to generate data for testing the PPP.  
# Generate PPP for 5 species each with 4 actions each.  
# W. Probert, 2015

weighting <- 1
multiplier <- 1
set_budget <- 0
overlap.indicator <- TRUE
discount.rate <- 0
stop.iteration <- Inf
stop.no.of.species <- 0
year.text <- "Y"
T <- 5

Nspp <- 5
Nact <- c(4, 4, 4, 4, 4)

tot.acts <- sum(Nact)

# Generate the actions dataset
# 5 species, each with 4 actions
a.data <- data.frame(
  action_id = 1:tot.acts,
  species_id = rep(1:Nspp, times = Nact),
  TaxaCodeText = rep(LETTERS[1:Nspp], times = Nact),
  TaxaCode = rep((tot.acts+1):((tot.acts+1)+Nspp-1), times = Nact),
  ProjectText = rep(letters[1:Nspp], times = Nact),
  ProjectCode = rep(-c(1:Nspp), times = Nact),
  "Method" = "Method", #because 'Method' is a defined function in R.  
  Method1Text = "Method1Text",
  Method2Text = "Method2Text",
  Method3Text = "Method3Text",
  Method4Text = "Method4Text",
  Period1Cost = 1,
  Period1Sequence = paste(1:T, sep = "", collapse = ","),
  Period2Cost = 0,
  Period2Sequence = paste(1:T, sep = "", collapse = ","),
  Period3Cost = 0,
  Period3Sequence = paste(1:T, sep = "", collapse = ","),
  ManagementSiteInputSuccess = 80,
  ManagementSiteOutputSuccess = 80,
  ActionObjectiveSuccessProbability = 80
)

# Generate the benefits data probability of persistence 
# is 75% with all actions and 15% without management
b.data <- data.frame(
  species_id = 1:Nspp,
  TaxaText = LETTERS[1:Nspp],
  TaxaCode = tot.acts:(tot.acts+Nspp-1),
  ProjectText = letters[1:Nspp],
  sciname = do.call(paste, list(LETTERS[1:Nspp], letters[1:Nspp], sep = "")),
  bene_with_action = 75,
  bene_no_action = 15,
  ProjectCode = -c(1:Nspp)
)

# Overlaps data, each action as a unit 
o.data <- data.frame(
action_id = 1:tot.acts,
overlap_id = 1:tot.acts
)

w.data <- data.frame(
species_id = 1:Nspp,
species_type = "Bat",
sciname = do.call(paste, list(LETTERS[1:Nspp], letters[1:Nspp], sep = "")),
genus = do.call(paste, list("Genus", letters[1:Nspp], sep = "_")),
Bs = 1,
Ts = 1,
family = do.call(paste, list("Family", letters[1:Nspp], sep = "_")),
Bg = 1,
Tg = 1,
order = do.call(paste, list("Order", letters[1:Nspp], sep = "_")),
Bf = 1,
Tf = 1,
Endem.spp = 0,
Endem.gen = 0,
Endem.fam = 0,
weight_value = 1
)

# (No. actions x T) True/false for if an action is costed
all.costs <- data.frame(cbind("action_id" = 1:tot.acts, 
    as.data.frame(matrix(1, tot.acts, T))))

names(all.costs)[2:(T+1)] <- do.call(paste, list("Y", 1:T, sep = ""))

CostList <- NewSetupCosts3(a.data, T, year.text)

cost.period <- CostList$period
all.costs <- data.frame("action_id" = with(a.data, action_id))
all.costs <- cbind(all.costs, CostList$allcost)


# What does MakeOverlaps do?  
# Finish the examples
# Post to repo
# Finish the weights algorithm document.  
# Send all to Martina.  

# Map for the collaborators.  
# 10 slides for the EuFMD talk.  
