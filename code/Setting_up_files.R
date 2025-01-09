library(ape)
library(here)
library(tidyverse)
library(magrittr)

target_tree = "data/original_data/Master_Pruned_Const.trees"
trees <- ape::read.tree(here(target_tree))
taxa <- data.table::fread("data/Test_taxa.tsv")
taxa_ext <- taxa %>% filter(age==0) %>%  pull(taxon)
trees_p <- lapply(trees, FUN = function(x) keep.tip(x, tip = taxa_ext))
write.tree(trees_p, file = "data/Test_Master_Pruned.trees")

target_tree = "data/original_data/Master_Resolved_Const.trees"
trees <- ape::read.tree(here(target_tree))
taxa <- taxa %>%  pull(taxon)
trees_p <- lapply(trees, FUN = function(x) keep.tip(x, tip = taxa))
write.tree(trees_p, file = "data/Test_Master_Full.trees")

nex <- ape::read.nexus.data(here("data/Test_aln.nex"))
taxa <- data.table::fread("data/Test_taxa.tsv")
taxa_ext <- taxa %>% filter(age==0) %>% pull(taxon)
new_new <- nex[which(names(nex) %in% taxa_ext)]
write.nexus.data(new_new, file="data/Test_aling.nex")

target_tree = "data/original_data/MCC_Master_Pruned.tre"
trees <- ape::read.nexus(here(target_tree))
taxa <- data.table::fread("data/Test_taxa.tsv")
taxa_ext <- taxa %>% filter(age==0) %>% pull(taxon)
trees_p <- keep.tip(trees, tip = taxa_ext)
write.tree(trees_p, file = "data/Test_MCC_Master_Pruned.trees")

target_tree = "data/original_data/MCC_Master_Resolved.tre"
trees <- ape::read.nexus(here(target_tree))
taxa <- taxa %>%  pull(taxon)
trees_p <- keep.tip(trees, tip = taxa)
write.tree(trees_p, file = "data/Test_MCC_Master_Full.trees")


taxa <- data.table::fread("data/Test_taxa.tsv")
taxa <- taxa %>% filter(age!=0) %>% pull(taxon)
data.table::fread("data/original_data/Test_Fossil_intervals.tsv") %>% filter(taxon %in% taxa) %>% 
  write.table(file = "data/Test_Fossil_intervals.tsv", col.names = TRUE, row.names = FALSE, quote = FALSE)

taxa <- data.table::fread("data/Test_taxa.tsv")
taxa <- taxa %>%  pull(taxon)
nex <- ape::read.nexus.data("data/original_data/Test_range_4.nex") 
new_new <- nex[which(names(nex) %in% taxa)]
write.nexus.data(new_new, file="data/Test_range.nex")

taxa <- data.table::fread("data/Test_taxa.tsv")
taxa <- taxa %>% filter(age==0) %>%  pull(taxon)
nex <- ape::read.nexus.data("data/original_data/Test_range_4.nex") 
new_new <- nex[which(names(nex) %in% taxa)]
write.nexus.data(new_new, file="data/Test_range_pruned.nex")

