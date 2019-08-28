# Data and analysis for Thanissery et al (2019)

This repository contains the microbiome data analysis for the manuscript

R. Thanissery, M.R. McLaren, A. Rivera, A. Reed, N.S. Betrapally, T. Burdette,
J.A. Winston, M. Jacob, B.J. Callahan, and C.M. Theriot (2019).
Characterization of _C. difficile_ strains isolated from domestic animals and
the associated changes in the host fecal microbiota. (Submitted)

The raw sequence reads are available at
<https://www.ncbi.nlm.nih.gov/bioproject/PRJNA562547>. The results of
bioinformatic analysis of the raw reads with DADA2, including taxonomy
assignment against Silva v132 using DADA2's `assignTaxonomy()` and
`addSpecies()` functions are in `results/dada2`, and as a phyloseq object in
`results/ps.Rds`.

All bioinformatic and statistical analyses are contained in R-markdown
documents in `analysis/`. A description of these files is given in
[analysis/README.md](analysis/README.md). For most analyses, versions that are
already rendered to html files are included and can be viewed by clicking on
the following links,

* [00-sample-data.html](https://rthanis.github.io/animal-cdiff/analysis/00-sample-data.html)
* [03-taxonomy.html](https://rthanis.github.io/animal-cdiff/analysis/03-taxonomy.html)
* [alpha-beta.html](https://rthanis.github.io/animal-cdiff/analysis/alpha-beta.html)
* [alpha-beta-no-cdiff.html](https://rthanis.github.io/animal-cdiff/analysis/alpha-beta-no-cdiff.html)
* [canine-aldex.html](https://rthanis.github.io/animal-cdiff/analysis/canine-aldex.html)
* [cdiff-asvs.html](https://rthanis.github.io/animal-cdiff/analysis/cdiff-asvs.html)
* [cdiff-vs-age.html](https://rthanis.github.io/animal-cdiff/analysis/cdiff-vs-age.html)
* [hiranonis-asvs.html](https://rthanis.github.io/animal-cdiff/analysis/hiranonis-asvs.html)
* [multivariate-regression.html](https://rthanis.github.io/animal-cdiff/analysis/multivariate-regression.html)
