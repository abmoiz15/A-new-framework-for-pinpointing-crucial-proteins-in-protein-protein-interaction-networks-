library(igraph)
library(dplyr)
library(writexl)

edges <- read.csv(file.choose(), header = TRUE, col.names = c("source", "target"))

graph <- graph_from_data_frame(edges)

# Initialize an empty list to store results
empty_list <- list()

# Iterate over each edge
for (edge in E(graph)) {
  # Get the vertices at each end of the edge
  vertices <- ends(graph, edge)
  vertex1 <- vertices[1]
  vertex2 <- vertices[2]
  
# Get neighbors of each vertex
  neighbors1 <- neighbors(graph, vertex1)
  neighbors2 <- neighbors(graph, vertex2)
  
  common_neighbors <- intersect(neighbors1, neighbors2)
  all_neighbors <- union(neighbors1, neighbors2)
  
  BioLinkStrength <- length(common_neighbors) / length(all_neighbors)
  
  # Store the result in the list
  empty_list[[as.character(edge)]] <- BioLinkStrength
}

# Convert the list to a data frame
resut_df <- data.frame(edge = names(empty_list), BioLinkStrength = unlist(empty_list))
write_xlsx(resut_df, path = "data.xlsx")
