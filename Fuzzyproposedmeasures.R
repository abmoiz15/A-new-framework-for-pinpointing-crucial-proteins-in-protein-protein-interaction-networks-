#include packages
library(igraph)
library(centiserve)
library(cluster)
library(readr)
library(haven)
library(ggplot2)
library(writexl)
library(openxlsx)


edges <-  read.csv(file.choose(), header = TRUE, col.names = c("source", "target", "edgestrength"))

g <- graph_from_data_frame(edges, directed = FALSE)
A <- as.matrix(as_adjacency_matrix(g,  attr = "edgestrength", sparse = FALSE))
Adjacency_matrix <- as.data.frame(A)


# Calculate the FCC (fuzzy version of degree centrality)
FCC <- strength(g,weights = E(g)$edgestrength)
FCC <-  as.data.frame(FCC)


# Calculate the FAC (fuzzy version of closeness centrality)
FAC <- closeness(g,weights = E(g)$edgestrength)
FAC <-  as.data.frame(FAC)


# Calculate the FBC (fuzzy version of betweenness centrality)
FBC <- betweenness(g,weights = E(g)$edgestrength)
FBC <-  as.data.frame(FBC)


# Calculate the FIC (fuzzy version of eigen vector centrality)
FIC <- eigen_centrality(g,weights = E(g)$edgestrength, directed=FALSE, scale=FALSE)
FIC <-  as.data.frame(FIC)

