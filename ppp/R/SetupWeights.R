SetupWeights <- function(w.data, ...) {
  
  # Make all species, genus, family names in lower case, 
  # strip white space at start and end of names
  .simpleCap <- function(x) {
    s <- strsplit(x, " ")[[1]]
    paste(toupper(substring(s, 1,1)), substring(s, 2),
          sep = "", collapse = " ")
  }
  
  # Capitalise all first letters of the genus, and family name
  w.data <- within(w.data, {
    sciname <- sapply(tolower(with(w.data, sciname)), .simpleCap)
    genus <- sapply(tolower(with(w.data, genus)), .simpleCap)
    family <- sapply(tolower(with(w.data, family)), .simpleCap)
    order <- sapply(tolower(with(w.data, order)), .simpleCap)
  })
  
  # If As, Ag, Af, or Bs, Bg, Bf, or Ts, Tg, Tf columns 
  # exist in w.data then rename them to *.old 
  names(w.data)[names(w.data) == "Bs"] <- "Bs.old"
  names(w.data)[names(w.data) == "Bg"] <- "Bg.old"
  names(w.data)[names(w.data) == "Bf"] <- "Bf.old"
  
  names(w.data)[names(w.data) == "Ts"] <- "Ts.old"
  names(w.data)[names(w.data) == "Tg"] <- "Tg.old"
  names(w.data)[names(w.data) == "Tf"] <- "Tf.old"
  
  names(w.data)[names(w.data) == "As"] <- "As.old"
  names(w.data)[names(w.data) == "Ag"] <- "Ag.old"
  names(w.data)[names(w.data) == "Af"] <- "Af.old"
  
  # Calculate weights for the Bs, Bg, Bf
  Bs.df <- aggregate(sciname ~ genus, w.data, 
          FUN = function(x) length(unique(x)))
  colnames(Bs.df) <- c("genus", "Bs")
    
  Bg.df <- aggregate(genus ~ family, w.data, 
          FUN = function(x) length(unique(x)))
  colnames(Bg.df) <- c("family", "Bg")
  
  Bf.df <- aggregate(family ~ order, w.data, 
          FUN = function(x) length(unique(x)))
  colnames(Bf.df) <- c("order", "Bf")
  
  w.data <- merge(w.data, Bs.df, by = "genus")
  w.data <- merge(w.data, Bg.df, by = "family")
  w.data <- merge(w.data, Bf.df, by = "order")
  
  # Set T*, A*, R, D, and weight_value variables to zero.
  w.data <- within(w.data, {
      Ts <- 0
      Tg <- 0
      Tf <- 0
      As <- 0
      Ag <- 0
      Af <- 0
      R <- 0
      D <- 0
      weight_value <- 0
  })
  
  # Return the result
  return(w.data)
}