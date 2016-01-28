################################################################################
###
### Clean the Hegre and Sambanis data, then impute missing values in Amelia
###
################################################################################

library("Amelia")
library("dplyr")
library("tidyr")
library("foreign")

## Read in Hegre and Sambanis data file, as provided in replication file
## distributed via JPR website
hs_raw <- read.dta("hs-raw.dta")

## Generate the "pt8" variable for peace years the same way as in the .do file
## in the paper appendix
hs_data <- mutate(hs_raw, pt8 = 2^(-tip/8))

## Get rid of observations before 1960, as in the original paper, and the
## bizarre ones for which country-year identifiers are missing
hs_data <- filter(hs_data,
                  country != "",
                  !is.na(year),
                  year >= 1960)

## Drop cases where the response is missing
hs_data <- filter(hs_data, !is.na(warstns))

## Only include the variables mentioned in the paper
##
## Should be 94 total: 88 controls, 3 core variables, 1 response, plus country
## and year IDs
hs_data <- hs_data %>%
    select(
        ## Identifiers
        country,
        year,
        ## Response
        warstns,
        ## Core variables
        ln_popns,
        ln_gdpen,
        pt8,
        ## Concept 1: Ethnic fragmentation
        dlang,
        drace,
        drel,
        ef,
        ef2,
        ehet,
        elfo,
        elfo2,
        numlang,
        plural,
        plurrel,
        relfrac,
        ## Concept 2: Ethnic dominance/polarization
        etdo4590,
        second,
        ## Concept 3: Level of democracy
        auto4,
        dem,
        dem4,
        exrec,
        mirps2,
        mirps3,
        parcomp,
        parreg,
        part,
        pol4,
        pol4m,
        polcomp,
        reg,
        sip2,
        xconst,
        ## Concept 4: Inconsistency of political institutions
        anoc,
        mirps0,
        mirps1,
        partfree,
        pol4sq,
        ## Concept 5: Political instability
        ager,
        autch98,
        demch98,
        durable,
        inst3,
        nwstate,
        p4mchg,
        polch98,
        proxregc,
        ## Concept 6: Political system
        incumb,
        inst,
        major,
        presi,
        ## Concept 7: Centralization
        autonomy,
        centpol3,
        fedpol3,
        semipol3,
        ## Concept 8: Neighborhood political economy
        avgnabo,
        nmdgdp,
        nmdp4_alt,
        regd4_alt,
        ## Concept 9: Region
        geo1,
        geo2,
        geo34,
        geo57,
        geo69,
        geo8,
        ## Concept 10: Neighborhood war
        nat_war,
        tnatwar,
        ## Concept 11: Growth
        gdpgrowth,
        ## Concept 12: Economic policy
        expgdp,
        trade,
        ## Concept 13: Social welfare
        illiteracy,
        infant,
        life,
        pri,
        seceduc,
        ## Concept 14: Resources
        agexp,
        fuelexp,
        manuexp,
        oil,
        sxpnew,
        sxpsq,
        ## Concept 15: Terrain, geography, population distribution
        lmtnest,
        ncontig,
        popdense,
        ## Concept 16: Militarization
        army85,
        milper,
        ## Concept 17: Time
        decade1,
        decade2,
        decade3,
        decade4,
        coldwar,
        ## Concept 18: Colonial war
        warhist
    )

dim(hs_data)

## Look at the amount of missingness in each variable
hs_data %>%
    gather(variable, value, -country, -year) %>%
    group_by(variable) %>%
    summarise(missing = mean(is.na(value))) %>%
    arrange(desc(missing)) %>%
    print(n = 100)

## Fix the remaining bizarre cases where the decade identifiers are missing
##
## Probably should also fix the bizarre cases where the region is missing, but
## there are less of those
hs_data <- mutate(hs_data,
                  decade1 = as.numeric(year >= 1960 & year < 1970),
                  decade2 = as.numeric(year >= 1970 & year < 1980),
                  decade3 = as.numeric(year >= 1980 & year < 1990),
                  decade4 = as.numeric(year >= 1990 & year < 2000))

## Run Amelia once
##
## Imposing a ridge prior since we get lots of singularity errors
set.seed(888)                           # For replicability
impute_hs <- amelia(x = hs_data,
                    m = 1,
                    ts = "year",
                    cs = "country",
                    p2s = 2,
                    empri = 0.01 * nrow(hs_data))

hs_imputed <- impute_hs$imputations[[1]]

## Check that there's no more missingness
hs_imputed %>%
    gather(variable, value, -country, -year) %>%
    group_by(variable) %>%
    summarise(missing = mean(is.na(value))) %>%
    summarise(most_missing = max(missing))

## Save as CSV
write.csv(hs_imputed,
          file = "hs-imputed.csv",
          row.names = FALSE)
