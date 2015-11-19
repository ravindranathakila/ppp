NewCalcCosts <- function(costs, o.data, overlapping, ...){
    
    # INPUTS
    # 
    # costs             data.frame
    #       costs of each action costed 
    # 
    # o.data            data.frame
    #       overlaps dataset showing action IDs associated with each action ID
    # 
    # overlaps          boolean
    #       Should overlaps be taken into account or not?
    # 
    # 
    # Example
    
    # Active actions are action IDs that are costed in this year
    active_actions <- costs[costs[,2] > 0, "action_id"]
    dim(active_actions) <- c(length(active_actions),1)
    
    # overlap indicator is false so return costs that 
    # occur in that year but without sharing
    if(overlapping == FALSE){
        ans <- costs
        colnames(ans)[2] <- "cost.shared"
        return(ans)
    }
    
    final.costs <- subset(costs, subset = action_id %in% active_actions)
    
    #### Non-active costs ####
    # Do nothing as the cost for these is already 0 in final.costs
    
    #### Non-overlapping, active costs ####
    # Do nothing as the cost for these is already in final.costs
    
    #### Overlapping costs ####
    # find active overlaps, and subset the data,
    # active overlaps are those actions which have overlap codes
    # shared with other actions, and also are costed in the current year
    
    # Subset o.data to show only those actions that are costed in this year
    sub_o.data <- subset(o.data, action_id %in% active_actions)
    
    # Find the number of 'active' overlap codes per action id
    overlap_counts <- aggregate(overlap_id ~ action_id, 
        data = sub_o.data, length)
    
    names(overlap_counts)[2] <- "overlap_count"
    
    incld_costs <- merge(overlap_counts, final.costs)
    names(incld_costs)[3] <- "costs"
    
    # Divide the action cost by the number of overlap costs
    incld_costs <- within(incld_costs, {
        per_code_cost <- costs/overlap_count
    })
    
    # Merge back into the dataset with action_id and overlap_id
    sub <- merge(sub_o.data, incld_costs[,c("action_id", "per_code_cost")])
    
    # Find the maximum cost across each overlap code
    maximums <- aggregate(per_code_cost ~ overlap_id, data = sub, max)
    names(maximums)[2] <- "maximum_costs"
    sums <- aggregate(per_code_cost ~ overlap_id, data = sub, sum)
    names(sums)[2] <- "summed_costs"
    sub <- merge(sub, maximums)
    sub <- merge(sub, sums)
    
    sub <- within(sub, {
        final_cost <- maximum_costs*per_code_cost/summed_costs
    })
    
    final.costs <- aggregate(final_cost ~ action_id, data = sub, sum)
    colnames(final.costs) <- c("action_id", "cost.shared")
    
    # Fill in 'final.costs' with any missing active actions.  
    missing_acts <- setdiff(active_actions, with(final.costs, action_id))
    
    # Add any of the missing acts that in the costs data (with full costs)
    costed_acts <- subset(costs, subset = action_id %in% missing_acts)
    colnames(costed_acts) <- c("action_id", "cost.shared")
    final.costs <- rbind(final.costs, costed_acts)
    
    # If there are still missing actions, add them with a cost of zero.
    missing_acts <- setdiff(active_actions, with(final.costs, action_id))
    if (NROW(missing_acts) > 0){
        missing_costs <- data.frame("action_id" = missing_acts, 
            "cost.shared" = 0)
        final.costs <- rbind(final.costs, missing_costs)
    }
    
    return(final.costs)
}