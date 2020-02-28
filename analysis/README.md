# Files in analysis/

## Bioinformatic analysis

These scripts must be run first, and in the given order, to create the files
`results/metadata-clean.csv`, `results/hiranonis-and-scindens.csv`, and
`results/ps.Rds`, which form the starting points for the statistical analysis.

#### 00-sample-data.Rmd

This script cleans the sample metadata in `data/Metadata_2.13.2019.xlsx` and
saves the cleaned version in `results/metadata-clean.csv` and
`results/metadata-clean.Rds`; the latter includes formatting of some variables
as factors.

Rendered version:
[00-sample-data.html](https://rthanis.github.io/animal-cdiff/analysis/00-sample-data.html)

#### 01-dada2.Rmd

This script runs the DADA2 pipeline to analyze the 16S sequence data and create
an ASV-sequence count table (`results/dada2/seqtab.Rds`) and a taxonomy table
(`results/dada2/taxa.Rds`).

#### 02-phyloseq.Rmd

This script imports the DADA2 results into a phyloseq object. It adds some
additional columns to the sample data based on the sequence table that are used
in our downstream analysis.

#### 03-taxonomy.Rmd

This script 1) inspects the fraction of ASVs and reads with assigned taxonomy
at various taxonomic levels; 2) inspects ASVs identified as C. difficile in the
DADA2 species-assignment step; 3) uses BLAST to identify ASVs as C. hiranonis
and C. scindens, which were not identified in the initial species assignment.
The results are saved in `results/hiranonis-and-scindens.csv` and added to the
taxonomy table in the phyloseq object.

Rendered version:
[03-taxonomy.html](https://rthanis.github.io/animal-cdiff/analysis/03-taxonomy.html)

## Statistical analysis

### Community-wide analyses

#### alpha-beta.Rmd

This script analyses patterns of alpha and beta diversity across animal host
types, and between C. difficile positive and negative samples within an animal
host type. Alpha and beta diversities were computed with C. difficile reads
included or excluded, giving approximately indistinguishable results.

Rendered version:
[alpha-beta.html](https://rthanis.github.io/animal-cdiff/analysis/alpha-beta.html)

Rendered version with C. difficle reads removed:
[alpha-beta-no-cdiff.html](https://rthanis.github.io/animal-cdiff/analysis/alpha-beta-no-cdiff.html)

#### canine-aldex.Rmd

This script performs a compositional PCA analysis and community-wide
differential-abundance test to look for ASVs associated with C. difficile
presence.

Rendered version:
[canine-aldex.html](https://rthanis.github.io/animal-cdiff/analysis/canine-aldex.html)

### C. difficile specific analyses

#### cdiff-vs-age.Rmd

This script visualizes C. difficile presence by lab sporulation assay versus
age.

Rendered version:
[cdiff-vs-age.html](https://rthanis.github.io/animal-cdiff/analysis/cdiff-vs-age.html)

#### cdiff-asvs.Rmd

This script examines the co-occurrence of the three C. difficile ASVs and
compares the detection of C. difficile by lab sporulation assay to that via 16S
community sequencing.

Rendered version:
[cdiff-asvs.html](https://rthanis.github.io/animal-cdiff/analysis/cdiff-asvs.html)

### Analyses of C. hiranonis and its relationship with C. difficile 

#### hiranonis-asvs.Rmd

This script analyses the prevalence of C. hiranonis, the association of C.
hiranonis presence with C. difficile, and the co-abundance patterns of the
various C. hiranonis ASVs.

Rendered version: 
[hiranonis-asvs.html](https://rthanis.github.io/animal-cdiff/analysis/hiranonis-asvs.html)

#### multivariate-regression.Rmd

This script performs logistic regression of C. difficile presence versus
presence of the two C. hiranonis types, with and without the sample covariates
of age, antibiotics use, GI distress, and sex.

Rendered version:
[multivariate-regression.html](https://rthanis.github.io/animal-cdiff/analysis/multivariate-regression.html)
