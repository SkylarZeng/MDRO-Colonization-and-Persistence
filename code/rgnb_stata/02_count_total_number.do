// Patient
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
    keep if bucket_group_patient == `i' & (`condition')

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
gen bucket_group_patient = _n
gen swab_count    = .
gen visit_count   = .
gen patient_count = .

// Assign values from macros using the word() function
forvalues i = 1/3 {
    replace swab_count    = real(word("`swab_counts'", `i')) if bucket_group_patient == `i'
    replace visit_count   = real(word("`visit_counts'", `i')) if bucket_group_patient == `i'
    replace patient_count = real(word("`patient_counts'", `i')) if bucket_group_patient == `i'
}

// Export the summary table to a CSV file
export delimited bucket_group_patient swab_count visit_count patient_count ///
    using "count_results.csv", replace

// Display the summary table
list

restore  // Restore the original dataset
