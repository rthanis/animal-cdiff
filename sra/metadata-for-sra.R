library(here)
library(tidyverse)

sam <- readRDS(here("results", "metadata-clean.Rds")) %>%
    filter(Year_sequenced != "Not sequenced")
glimpse(sam)

# Biosample metadata ----------------------------------------------------------

sam0 <- sam %>%
    rename_all(str_to_lower) %>%
    rename(sample_name = sample) %>%
    mutate(
        organism = "feces metagenome",
        strain = "not applicable",
        collection_date = "2016-12/2017-10",
        env_broad_scale = "not applicable",
        env_local_scale = "not applicable",
        env_medium = "ENVO:00002003",
        geo_loc_name = "USA:North Carolina:Raleigh",
        lat_lon = "35.798 N 78.704 W",
        host = fct_recode(host_species,
            `Vicugna pacos` = "Alpaca",
            `Gallus gallus` = "Avian",
            `Canis lupus familiaris` = "Canine",
            Equus = "Equine",
            `Felis catus` = "Feline",
            `Ovis aries` = "Ovine",
            ),
        isol_growth_condt = "not applicable",
        ) %>%
    mutate(
        sex = fct_recode(sex, Male = "M", Female = "F", 
            `not collected` = "Not known"),
    ) %>%
    rename(
        host_alias = host_species,
        host_breed = breed,
        host_age_reported = age_reported,
        host_age_years = age,
        host_sex = sex,
        host_neutered = neutered,
        host_antibiotics_status = ab_status,
        host_antibiotics_type = ab_type,
        host_antibiotics_group = ab_group,
        host_gastrointestinal_status = gi_status,
        c_difficile_lab = cd_lab,
        c_difficile_toxigenic = cd_toxigenic,
        c_difficile_ribotype = cd_ribotype,
        host_relevant_diagnosis_or_reason_for_visit =
            relevant_diagnosis_or_reason_for_visit,
        year_data_received = year_sequenced
    ) %>%
    select(-sexcs, -age_group) %>%
    # Needed to remove newlines in sample "CS3_CN2", to avoid SRA parsing error
    mutate_at(vars(host_antibiotics_type), str_replace_all, "\\r\\n", "; ")
glimpse(sam0)

write_tsv(sam0, here("results", "biosample-metadata-for-sra.tsv"))

# SRA metadata ----------------------------------------------------------------

# First, get the sample_name, library_id, and filenames for the F and R reads
fns <- list.files("~/data/animal_microbiomes/reads/raw", pattern = "fastq.gz")
tb <- tibble(filename = fns) %>%
    mutate(
        library_ID = str_extract(filename, "^[^_]+"),
        direction = str_extract(filename, "(?<=_R)[1-2](?=_)"),
        filetype = "fastq"
    ) %>%
    mutate(direction = case_when(
            direction == 1 ~ "filename",
            direction == 2 ~ "filename2",
            )
    ) %>%
    spread(direction, filename)
tb0 <- left_join(sam0 %>% select(sample_name, library_ID = sequence_id), tb,
    by = "library_ID")
# Now add info that is identical for all samples
tb0 <- tb0 %>%
    mutate(
        title = "sample_name",
        library_strategy = "AMPLICON",
        library_source = "METAGENOMIC",
        library_selection = "PCR",
        library_layout = "paired",
        platform = "Illumina",
        instrument_model = "Illumina MiSeq",
        design_description = "paired-end amplicon sequencing of the 16S V4 region",
    )
glimpse(tb0)

write_tsv(tb0, here("results", "sra-metadata-for-sra.tsv"))
