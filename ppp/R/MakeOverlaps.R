MakeOverlaps <- function(act_id, o.data, overlap.indicator){
    if(overlap.indicator==TRUE){
        # Find rows numbers of o.data for each action id in act_id
        result <- lapply(act_id, function(y) c(y, which(o.data$action_id==y))) 
        
        # Save the actual overlap id associated with each action id in act_id
        overlap_data <- lapply(result, function(x) c(x[1],
            o.data$overlap_id[x[-1]]))
        
        # Find the number of overlap codes for each action
        sizes <- sapply(overlap_data, length)
        
        # Create a large matrix to store results, dimension is length(act_id)
        # x (maximum number overlap codes for any individual action)
        mat <- matrix(rep(0, max(sizes)*length(overlap_data)), 
            nrow = length(act_id), ncol = max(sizes))
        
        for(i in 1:length(sizes)){
            mat[i,1:sizes[i]] <- overlap_data[[i]]
        }
        # Remove the first column when returning (this is the associated 
        # action id)
        return(mat[,-1])
        
        # If overlap.indicator=FALSE then return the single column 
        # of unique overlapIDs
    }else{
        with(o.data, action_id)
    }
}
