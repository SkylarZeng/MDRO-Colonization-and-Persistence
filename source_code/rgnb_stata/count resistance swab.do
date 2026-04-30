// Test
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

// Initialize resistance count macros
local ctcr_swab_counts    ""
local cipr_swab_counts    ""
local imir_swab_counts    ""

// Loop over each bucket (1, 2, 3)
forvalues i = 1/3 {
    
    preserve
    
    // **Step 1: Keep only relevant cases for bucket `i`**
    keep if bucket_group_patient == `i' & (`condition')

    // **Step 2: Drop duplicates at Swab Level (studyID + visit + specimen + first_valid_mac)**
    duplicates drop studyID visit specimen first_valid_mac, force

    // **Step 3: Count resistance cases for first_valid_mac ONLY IN THE 46 swabs**
    quietly count if first_valid_mac == "mac1" & mac1ctzr == 1
    local ctcr_count = r(N)
    quietly count if first_valid_mac == "mac2" & mac2ctzr == 1
    local ctcr_count = `ctcr_count' + r(N)
    quietly count if first_valid_mac == "mac3" & mac3ctzr == 1
    local ctcr_count = `ctcr_count' + r(N)
    quietly count if first_valid_mac == "mac4" & mac4ctzr == 1
    local ctcr_count = `ctcr_count' + r(N)
    local ctcr_swab_counts `ctcr_swab_counts' `ctcr_count'

    quietly count if first_valid_mac == "mac1" & mac1cipr == 1
    local cipr_count = r(N)
    quietly count if first_valid_mac == "mac2" & mac2cipr == 1
    local cipr_count = `cipr_count' + r(N)
    quietly count if first_valid_mac == "mac3" & mac3cipr == 1
    local cipr_count = `cipr_count' + r(N)
    quietly count if first_valid_mac == "mac4" & mac4cipr == 1
    local cipr_count = `cipr_count' + r(N)
    local cipr_swab_counts `cipr_swab_counts' `cipr_count'

    quietly count if first_valid_mac == "mac1" & mac1imir == 1
    local imir_count = r(N)
    quietly count if first_valid_mac == "mac2" & mac2imir == 1
    local imir_count = `imir_count' + r(N)
    quietly count if first_valid_mac == "mac3" & mac3imir == 1
    local imir_count = `imir_count' + r(N)
    quietly count if first_valid_mac == "mac4" & mac4imir == 1
    local imir_count = `imir_count' + r(N)
    local imir_swab_counts `imir_swab_counts' `imir_count'

    restore
}

// Preserve dataset and create a summary table for resistance counts
preserve
clear
set obs 3  // One row per bucket

// Create variables for bucket number and resistance counts
gen bucket_group_patient = _n
gen ctcr_swab_count = .
gen cipr_swab_count = .
gen imir_swab_count = .

// Assign values from macros using the word() function
forvalues i = 1/3 {
    replace ctcr_swab_count = real(word("`ctcr_swab_counts'", `i')) if bucket_group_patient == `i'
    replace cipr_swab_count = real(word("`cipr_swab_counts'", `i')) if bucket_group_patient == `i'
    replace imir_swab_count = real(word("`imir_swab_counts'", `i')) if bucket_group_patient == `i'
}

// Export the resistance summary table to a CSV file
export delimited bucket_group_patient ctcr_swab_count cipr_swab_count imir_swab_count ///
    using "resistance_counts.csv", replace

// Display the resistance summary table
list

restore
