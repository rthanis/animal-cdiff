# Data and analysis for Thanissery et al (2019)

This repository contains the microbiome data analysis for the manuscript

Thanissery R, McLaren MR, Rivera A, Reed AD, Betrapally NS, Burdette T, Winston
JA, Jacob M, Callahan BJ, Theriot CM. 2019. Characterization of _C. difficile_
strains isolated from companion animals and the associated changes in the host
fecal microbiota. bioRxiv 822577. doi:10.1101/822577

The raw sequence reads are available at
<https://www.ncbi.nlm.nih.gov/bioproject/PRJNA562547>. The results of
bioinformatic analysis of the raw reads with DADA2, including taxonomy
assignment against Silva v132 using DADA2's `assignTaxonomy()` and
`addSpecies()` functions are in [results/dada2](results/dada2), and as a
phyloseq object in [results/ps.Rds](results/ps.Rds).

The results/ folder also includes plain-text (.csv format) tables mapping ASV
names to their amplicon sequence and taxonomy. These tables can be viewed
directly in a web browser by clicking the below links.

* [Table of all ASV sequences](results/all-asv-sequences-and-taxonomy.csv)
* [Table of select ASV
  sequences](results/select-asv-sequences-and-taxonomy.csv) (all
  _Clostridiodes_ ASVs, all _Clostridium hiranonis_ ASVs, and ASVs shown in
  Figure 3)
* [Table of ASV
  sequences explicitly mentioned in the
  manuscript](results/manuscript-asv-sequences-and-taxonomy.csv) (Excludes
  low-prevalence _C. hiranonis_ ASVs)

All bioinformatic and statistical analyses are contained in R-markdown
documents in [analysis/](analysis/). A description of these files and links to
rendered versions showing all numerical output and figures is given in
[analysis/README.md](analysis/README.md).
