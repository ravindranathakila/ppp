# Project Prioritisation Protocol (PPP)

Code repository for running the Project Prioritisation Protocol (PPP).  R code in the **ppp** folder and testing scripts illustrating how the PPP works in the **tests** folder.  

## What is a PPP?  

The project prioritisation protocol (PPP) is an algorithm for finding an approximate solution to the problem of choosing a subset of projects for funding when you have a limited budget.  This is essentially a solution method for a modified [knapsack problem](https://en.wikipedia.org/wiki/Knapsack_problem).  

The problem the PPP has been most commonly applied to is that of choosing which management projects to fund from a range of threatened species management projects (given that it is not possible to fund management of all species) under a budget constraint.  

## Why is PPP needed?  

The PPP algorithm is needed because the knapsack problem is very difficult computationally to solve for a large number of threatened species projects.  

Consider you have 3 projects that you can fund (A, B, C), and the problem is to find the best combination of projects to fund so as to maximise species persistence over, say, 50 years, given a limited budget.  The complete set of different funding regimes that are possible are the following:

* Fund A, B, C
* Fund A, don't fund B, C
* Fund B, don't fund A, C
* Fund C, don't func A, B
* Fund A, B, don't fund C, 
* Fund A, C, don't fund B, 
* Fund B, C, don't A
* Don't fund A, B, C

So that is 8 different possible funding regimes for 3 different projects.  Note that 8 = 2**3 (2 to the power of 3).  One would have to check the expected level of species persistence after 50 years for each of these regimes to find that regime which is the best to use.  

For 3 projects this is a simple problem.  However, notice that the number of possible funding regimes is 2\*\*`N` (2 to the power of `N`), where `N` is the number of different projects that can possibly be funded.  If there were 40 projects and it took 1 millisecond to check the expected persistence of each of the 2\*\*40 regimes constructed from these different projects (i.e. Fund A, B, C, ...., Don't fund X, Y, Z) then it would take just under 36 years to check them all and find the best regime using such an exhaustive approach (0.001 * 2^40 / 60 / 60 / 24 / 365).  

The PPP is used as an approximation to this solution method.  

## How does the PPP work?  

The PPP uses an iterative approach to find a subset of projects to fund.  It ranks projects based on their cost-efficiency and iteratively removes the least cost-effective project.  After each additional project is removed the PPP recalculates cost-efficiency scores of funding each project due to overlaps in costs and benefits of each project.  Further details are in the references below.  

## References
* [Joseph et al. (2009) Optimal Allocation of Resources among Threatened Species: a Project Prioritization Protocol. Conservation Biology. 23: 328–338.](http://onlinelibrary.wiley.com/doi/10.1111/j.1523-1739.2008.01124.x/abstract)

* [Bennett et al. (2014) Balancing phylogenetic diversity and species numbers in conservation prioritization, using a case study of threatened species in New Zealand. Biological Conservation. 174. 47-54. ](http://www.sciencedirect.com/science/article/pii/S0006320714001219)

* [Tulloch et al. (2015) Effect of risk aversion on prioritizing conservation projects. Conservation Biology. 29 (2) 513-524. ](http://onlinelibrary.wiley.com/doi/10.1111/cobi.12386/abstract)

* [Di Fonzo et al. (2015) Evaluating Trade-Offs between Target Persistence Levels and Numbers of Species Conserved. Conservation Letters. DOI: 10.1111/conl.12179](http://onlinelibrary.wiley.com/doi/10.1111/conl.12179/epdf)
