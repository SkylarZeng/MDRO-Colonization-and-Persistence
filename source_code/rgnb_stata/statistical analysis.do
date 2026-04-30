clear
import excel "Reorganized_data_dictionary.xlsx", sheet("Micro_Data") firstrow
keep if category == 3

* Generate antibiotic resistance and non-resistance counts
foreach ab in caz cip ipm {
    gen resist_`ab' = `ab'
    gen non_resist_`ab' = total - resist_`ab'
}

* Initialize results dataset
preserve
clear
tempfile results
save `results', emptyok
restore

levelsof species, local(species_list)
levelsof source, local(sources)

foreach s in `species_list' {
    foreach src in `sources' {
        foreach ab in caz cip ipm {
            preserve
            keep if species == "`s'" & source == `src'
            qui tab group
            if r(r) == 3 { // Check if all 3 groups exist
                * Prepare contingency table
                qui tab group, matrow(groups)
                mata: st_local("g1", strofreal(st_matrix("groups")[1]))
                mata: st_local("g2", strofreal(st_matrix("groups")[2]))
                mata: st_local("g3", strofreal(st_matrix("groups")[3]))
                
                qui sum resist_`ab' if group == `g1'
                local r1 = r(mean)
                qui sum non_resist_`ab' if group == `g1'
                local nr1 = r(mean)
                
                qui sum resist_`ab' if group == `g2'
                local r2 = r(mean)
                qui sum non_resist_`ab' if group == `g2'
                local nr2 = r(mean)
                
                qui sum resist_`ab' if group == `g3'
                local r3 = r(mean)
                qui sum non_resist_`ab' if group == `g3'
                local nr3 = r(mean)
                
                * Overall chi-squared test
                tabi `r1' `nr1' \ `r2' `nr2' \ `r3' `nr3', chi2
                local p_overall = r(p)
                
                * Pairwise chi-squared tests
                tabi `r1' `nr1' \ `r2' `nr2', chi2
                local p_12 = r(p)
                tabi `r1' `nr1' \ `r3' `nr3', chi2
                local p_13 = r(p)
                tabi `r2' `nr2' \ `r3' `nr3', chi2
                local p_23 = r(p)
                
                * Store results
                clear
                set obs 1
                gen species = "`s'"
                gen source = `src'
                gen antibiotic = "`ab'"
                gen p_overall = `p_overall'
                gen p_1v2 = `p_12'
                gen p_1v3 = `p_13'
                gen p_2v3 = `p_23'
                append using `results'
                save `results', replace
            }
            restore
        }
    }
}

use `results', clear
export excel "Statistical_Results.xlsx", firstrow(variables) replace
