// Environment
// Load the dataset
use micro_data_bucketed.dta, clear

// Keep only specimens E and P
keep if is_specimen_E == 1 | is_specimen_P == 1

// Define the condition for the first valid macID being 1
local cond1 "(first_valid_mac == "mac1" & mac1ID == 1) |"
local cond2 "(first_valid_mac == "mac2" & mac2ID == 1) |"
local cond3 "(first_valid_mac == "mac3" & mac3ID == 1) |"
local cond4 "(first_valid_mac == "mac4" & mac4ID == 1)"
local condition "`cond1' `cond2' `cond3' `cond4'"

// Initialize count storage
local swab_counts ""
local visit_counts ""
local patient_counts ""

// Loop over each bucket (1, 2, 3)
forvalues i = 1/3 {
    
    * Preserve the dataset before dropping duplicates
    preserve
    
    // **Step 1: Keep only relevant cases for bucket `i`**
    keep if bucket_group_environment == `i' & (`condition')

    // **Step 2: Drop duplicates at each level before counting**

    * Swab Level: Drop duplicates (studyID + visit + specimen + first_valid_mac)
    duplicates drop studyID visit specimen first_valid_mac, force
    quietly count
    local swab_counts `swab_counts' `r(N)'

    * Visit Level: Drop duplicates (studyID + visit + first_valid_mac)
    duplicates drop studyID visit first_valid_mac, force
    quietly count
    local visit_counts `visit_counts' `r(N)'

    * Patient Level: Drop duplicates (studyID)
    duplicates drop studyID, force
    quietly count
    local patient_counts `patient_counts' `r(N)'

    restore  // Restore original dataset before next iteration
}

// Preserve the dataset and create a new summary table
preserve
clear
set obs 3  // One row per bucket

// Create variables for bucket number and counts
gen bucket_group_environment = _n
gen swab_count    = .
gen visit_count   = .
gen patient_count = .

// Assign values from macros using the word() function
forvalues i = 1/3 {
    replace swab_count    = real(word("`swab_counts'", `i')) if bucket_group_environment == `i'
    replace visit_count   = real(word("`visit_counts'", `i')) if bucket_group_environment == `i'
    replace patient_count = real(word("`patient_counts'", `i')) if bucket_group_environment == `i'
}

// Export the summary table to a CSV file
export delimited bucket_group_environment swab_count visit_count patient_count ///
    using "count_results_A_environment.csv", replace

// Display the summary table
list

restore  // Restore the original dataset

// Environment Resistence
// Load the dataset
use micro_data_bucketed.dta, clear

// Keep only specimens E and P
keep if is_specimen_E == 1 | is_specimen_P == 1

// Define the condition for the first valid macID being 1
local cond1 "(first_valid_mac == "mac1" & mac1ID == 14) |"
local cond2 "(first_valid_mac == "mac2" & mac2ID == 14) |"
local cond3 "(first_valid_mac == "mac3" & mac3ID == 14) |"
local cond4 "(first_valid_mac == "mac4" & mac4ID == 14)"
local condition "`cond1' `cond2' `cond3' `cond4'"

// Initialize resistance count macros
local ctcr_swab_counts    ""
local cipr_swab_counts    ""
local imir_swab_counts    ""

local ctcr_visit_counts   ""
local cipr_visit_counts   ""
local imir_visit_counts   ""

local ctcr_patient_counts ""
local cipr_patient_counts ""
local imir_patient_counts ""

// Loop over each bucket (1, 2, 3)
forvalues i = 1/3 {
    
    preserve
    
    // **Step 1: Keep only relevant cases for bucket `i`**
    keep if bucket_group_environment == `i' & (`condition')

    // **Step 2: Drop duplicates at Swab Level (studyID + visit + specimen + first_valid_mac)**
    duplicates drop studyID visit specimen first_valid_mac, force

    // **Step 3: Count resistance cases for first_valid_mac at Swab Level**
    quietly count if first_valid_mac == "mac1" & mac1ctzr == 1
    local ctcr_swab = r(N)
    quietly count if first_valid_mac == "mac2" & mac2ctzr == 1
    local ctcr_swab = `ctcr_swab' + r(N)
    quietly count if first_valid_mac == "mac3" & mac3ctzr == 1
    local ctcr_swab = `ctcr_swab' + r(N)
    quietly count if first_valid_mac == "mac4" & mac4ctzr == 1
    local ctcr_swab = `ctcr_swab' + r(N)
    local ctcr_swab_counts `ctcr_swab_counts' `ctcr_swab'

    quietly count if first_valid_mac == "mac1" & mac1cipr == 1
    local cipr_swab = r(N)
    quietly count if first_valid_mac == "mac2" & mac2cipr == 1
    local cipr_swab = `cipr_swab' + r(N)
    quietly count if first_valid_mac == "mac3" & mac3cipr == 1
    local cipr_swab = `cipr_swab' + r(N)
    quietly count if first_valid_mac == "mac4" & mac4cipr == 1
    local cipr_swab = `cipr_swab' + r(N)
    local cipr_swab_counts `cipr_swab_counts' `cipr_swab'

    quietly count if first_valid_mac == "mac1" & mac1imir == 1
    local imir_swab = r(N)
    quietly count if first_valid_mac == "mac2" & mac2imir == 1
    local imir_swab = `imir_swab' + r(N)
    quietly count if first_valid_mac == "mac3" & mac3imir == 1
    local imir_swab = `imir_swab' + r(N)
    quietly count if first_valid_mac == "mac4" & mac4imir == 1
    local imir_swab = `imir_swab' + r(N)
    local imir_swab_counts `imir_swab_counts' `imir_swab'

    // **Step 4: Drop duplicates at Visit Level (studyID + visit + first_valid_mac)**
    duplicates drop studyID visit first_valid_mac, force

    quietly count if first_valid_mac == "mac1" & mac1ctzr == 1
    local ctcr_visit = r(N)
    quietly count if first_valid_mac == "mac2" & mac2ctzr == 1
    local ctcr_visit = `ctcr_visit' + r(N)
    quietly count if first_valid_mac == "mac3" & mac3ctzr == 1
    local ctcr_visit = `ctcr_visit' + r(N)
    quietly count if first_valid_mac == "mac4" & mac4ctzr == 1
    local ctcr_visit = `ctcr_visit' + r(N)
    local ctcr_visit_counts `ctcr_visit_counts' `ctcr_visit'

    quietly count if first_valid_mac == "mac1" & mac1cipr == 1
    local cipr_visit = r(N)
    quietly count if first_valid_mac == "mac2" & mac2cipr == 1
    local cipr_visit = `cipr_visit' + r(N)
    quietly count if first_valid_mac == "mac3" & mac3cipr == 1
    local cipr_visit = `cipr_visit' + r(N)
    quietly count if first_valid_mac == "mac4" & mac4cipr == 1
    local cipr_visit = `cipr_visit' + r(N)
    local cipr_visit_counts `cipr_visit_counts' `cipr_visit'

    quietly count if first_valid_mac == "mac1" & mac1imir == 1
    local imir_visit = r(N)
    quietly count if first_valid_mac == "mac2" & mac2imir == 1
    local imir_visit = `imir_visit' + r(N)
    quietly count if first_valid_mac == "mac3" & mac3imir == 1
    local imir_visit = `imir_visit' + r(N)
    quietly count if first_valid_mac == "mac4" & mac4imir == 1
    local imir_visit = `imir_visit' + r(N)
    local imir_visit_counts `imir_visit_counts' `imir_visit'

    // **Step 5: Drop duplicates at Patient Level (studyID)**
    duplicates drop studyID, force

    quietly count if first_valid_mac == "mac1" & mac1ctzr == 1
    local ctcr_patient = r(N)
    quietly count if first_valid_mac == "mac2" & mac2ctzr == 1
    local ctcr_patient = `ctcr_patient' + r(N)
    quietly count if first_valid_mac == "mac3" & mac3ctzr == 1
    local ctcr_patient = `ctcr_patient' + r(N)
    quietly count if first_valid_mac == "mac4" & mac4ctzr == 1
    local ctcr_patient = `ctcr_patient' + r(N)
    local ctcr_patient_counts `ctcr_patient_counts' `ctcr_patient'

    quietly count if first_valid_mac == "mac1" & mac1cipr == 1
    local cipr_patient = r(N)
    quietly count if first_valid_mac == "mac2" & mac2cipr == 1
    local cipr_patient = `cipr_patient' + r(N)
    quietly count if first_valid_mac == "mac3" & mac3cipr == 1
    local cipr_patient = `cipr_patient' + r(N)
    quietly count if first_valid_mac == "mac4" & mac4cipr == 1
    local cipr_patient = `cipr_patient' + r(N)
    local cipr_patient_counts `cipr_patient_counts' `cipr_patient'

    quietly count if first_valid_mac == "mac1" & mac1imir == 1
    local imir_patient = r(N)
    quietly count if first_valid_mac == "mac2" & mac2imir == 1
    local imir_patient = `imir_patient' + r(N)
    quietly count if first_valid_mac == "mac3" & mac3imir == 1
    local imir_patient = `imir_patient' + r(N)
    quietly count if first_valid_mac == "mac4" & mac4imir == 1
    local imir_patient = `imir_patient' + r(N)
    local imir_patient_counts `imir_patient_counts' `imir_patient'

    restore
}

// Export results (similar to swab-level output)
// Preserve dataset and create a summary table for resistance counts
preserve
clear
set obs 3  // One row per bucket

// Create variables for bucket number and resistance counts
gen bucket_group_environment = _n

// Swab-level resistance counts
gen ctcr_swab_count = .
gen cipr_swab_count = .
gen imir_swab_count = .

// Visit-level resistance counts
gen ctcr_visit_count = .
gen cipr_visit_count = .
gen imir_visit_count = .

// Patient-level resistance counts
gen ctcr_patient_count = .
gen cipr_patient_count = .
gen imir_patient_count = .

// Assign values from macros using the word() function
forvalues i = 1/3 {
    replace ctcr_swab_count = real(word("`ctcr_swab_counts'", `i')) if bucket_group_environment == `i'
    replace cipr_swab_count = real(word("`cipr_swab_counts'", `i')) if bucket_group_environment == `i'
    replace imir_swab_count = real(word("`imir_swab_counts'", `i')) if bucket_group_environment == `i'

    replace ctcr_visit_count = real(word("`ctcr_visit_counts'", `i')) if bucket_group_environment == `i'
    replace cipr_visit_count = real(word("`cipr_visit_counts'", `i')) if bucket_group_environment == `i'
    replace imir_visit_count = real(word("`imir_visit_counts'", `i')) if bucket_group_environment == `i'

    replace ctcr_patient_count = real(word("`ctcr_patient_counts'", `i')) if bucket_group_environment == `i'
    replace cipr_patient_count = real(word("`cipr_patient_counts'", `i')) if bucket_group_environment == `i'
    replace imir_patient_count = real(word("`imir_patient_counts'", `i')) if bucket_group_environment == `i'
}

// Export the full resistance summary table to a CSV file
export delimited bucket_group_environment ctcr_swab_count cipr_swab_count imir_swab_count ///
    ctcr_visit_count cipr_visit_count imir_visit_count ///
    ctcr_patient_count cipr_patient_count imir_patient_count ///
    using "resistance_counts.csv", replace

// Display the resistance summary table
list

restore
