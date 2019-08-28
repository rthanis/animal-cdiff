# as_tibble methods for phyloseq objects -------------------------------------

# Requires that as_tibble() is already loaded from tibble
require(tibble)

#' as_tibble for otu_table
#'
#' If tidy == TRUE, will give in tidy format like psmelt
#'
setMethod("as_tibble", c(x = "otu_table"),
    function(x, tidy = FALSE) {
        if (taxa_are_rows(x)) {
            row_type = "Taxon"
        } else {
            row_type = "Sample"
        }
        mat <- x %>% as("matrix")
        if (tidy) {
            if (row_type == "Sample") {
                mat <- t(mat)
            }
            tb <- mat %>% 
                tibble::as_tibble(rownames = "Taxon") %>%
                tidyr::gather("Sample", "Abundance", -Taxon)
        } else {
            tb <- mat %>% 
                tibble::as_tibble(rownames = row_type)
        }
        tb
    }
)

#' as_tibble for sample_data
#'
setMethod("as_tibble", c(x = "sample_data"),
    function(x) {
        x %>% as("data.frame") %>% tibble::as_tibble(rownames = "Sample")
    }
)

#' as_tibble for taxonomyTable
#'
setMethod("as_tibble", c(x = "taxonomyTable"),
    function(x) {
        x %>% as("matrix") %>% tibble::as_tibble(rownames = "Taxon")
    }
)

#' as_tibble for DNAStringSet
#'
setMethod("as_tibble", c(x = "DNAStringSet"),
    function(x) {
        x %>% as.character %>% tibble::enframe("Taxon", "Sequence")
    }
)

#' as_tibble for phyloseq objects
#'
#' @param tax whether to include taxonomy information
setMethod("as_tibble", c(x = "phyloseq"),
    function(x, tax = TRUE) {
        # There is always an otu_table; may not be sample_data or tax_table's
        tb <- otu_table(x) %>% as_tibble(tidy = TRUE)
        sam <- access(x, "sam_data")
        tt <- access(x, "tax_table")
        # Add sample data if it exists
        if (!is.null(sam)) {
            tb <- tb %>% 
                dplyr::left_join(sam %>% as_tibble, by = "Sample", 
                    suffix = c("", ".sam"))
        }
        # Add tax_table if it exists and tax = TRUE
        if (tax & !is.null(tt)) {
            tb <- tb %>% 
                dplyr::left_join(tt %>% as_tibble, by = "Taxon", 
                    suffix = c("", ".tax"))
        }
        tb
    }
)

# ggplot setup ---------------------------------------------------------------

theme_set(theme_cowplot(12) + 
    theme(
        plot.title = element_text(face = "plain"),
        strip.text = element_text(size=12, family = ""),
        strip.background = element_blank()
    )
)
# theme_set(theme_minimal() + theme(panel.grid = element_blank()))
colors.host_species = c(Canine = "#000000", Equine = "#489BE5", Feline =
    "#F53112", Ovine = "#AE43A7")
colors.age_group <- c(
    "<1" = "#E69F00", 
    "1-4" = "#56B4E9",
    "5-9" = "#009E73",
    "≥10" = "#CC79A7", 
    "Not known" = "darkgrey"
)

shape.cd <- c(Positive = 19, Negative = 2)

italicize <- function (x) bquote(italic(.(x)))

# Other functions ------------------------------------------------------------

#' Compute the centered log-ratio transform of x
#' 
#' @param x Vector of abundances.
#' @param base Base for logarithm
#'
clr <- function(x, base = exp(1), na.rm = FALSE) {
    log(x, base = base) - mean(log(x, base = base), na.rm = na.rm)
}
