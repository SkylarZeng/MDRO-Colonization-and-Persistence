// Import datasets
import excel "Micro data_20250121.xlsx", firstrow clear
save "micro_data_original.dta", replace
use micro_data_original.dta, clear

// Data cleaning
drop bldptcont msagrowth msa1quant msa1catal msa1staph msa1foxdia msa1meth msa1ID msa1frzcd msa1frznm msa2quant msa2catal msa2staph msa2foxdia msa2meth msa2ID msa2frzcd msa2frznm msa3quant msa3catal msa3staph msa3foxdia msa3meth msa3ID msa3frzcd msa3frznm

drop vregrowth vre1quant vre1pyr vre1ID vrespecies1 vre1frzcd vre1frznm vre2quant vre2pyr vre2ID vrespecies2 vre2frzcd vre2frznm

save "micro_data_cleaned.dta", replace

// Data Processing
use micro_data_cleaned.dta, clear
keep if macgrowth == 1

/// Replace 88 with missing for all numeric variables
foreach var of varlist _all {
    capture confirm numeric variable `var'
    if _rc == 0 {
        replace `var' = . if `var' == 88
    }
}

drop macgrowth mac1quant mac1frzcd mac1frznm mac2quant mac2frznm mac2frzcd mac3quant mac3frzcd mac3frznm mac4quant mac4frznm mac4frzcd
drop mac1cazdia mac1cipdia mac1imidia mac1cladia mac2cazdia mac2cipdia mac2imidia mac2cladia mac3cazdia mac3cipdia mac3imidia mac3cladia mac4cazdia mac4cipdia mac4imidia mac4cladia

save micro_data_filtered.dta, replace

// not account for 'mac'esbl for now
// Make the bucket based on type
use micro_data_filtered.dta, clear

// Check duplicates
gen mac1_equals_mac2 = (mac1ID == mac2ID & !missing(mac1ID) & !missing(mac2ID))
gen mac1_equals_mac3 = (mac1ID == mac3ID & !missing(mac1ID) & !missing(mac3ID))
gen mac1_equals_mac4 = (mac1ID == mac4ID & !missing(mac1ID) & !missing(mac4ID))
gen mac2_equals_mac3 = (mac2ID == mac3ID & !missing(mac2ID) & !missing(mac3ID))
gen mac2_equals_mac4 = (mac2ID == mac4ID & !missing(mac2ID) & !missing(mac4ID))
gen mac3_equals_mac4 = (mac3ID == mac4ID & !missing(mac3ID) & !missing(mac4ID))

count if mac1_equals_mac2 == 1
display "mac1ID = mac2ID: " r(N)
// 331
count if mac1_equals_mac3 == 1
display "mac1ID = mac3ID: " r(N)
// 50
count if mac1_equals_mac4 == 1
display "mac1ID = mac4ID: " r(N)
// 11
count if mac2_equals_mac3 == 1
display "mac2ID = mac3ID: " r(N)
// 66
count if mac2_equals_mac4 == 1
display "mac2ID = mac4ID: " r(N)
// 10
count if mac3_equals_mac4 == 1
display "mac3ID = mac4ID: " r(N)
// 11

drop mac1esbl mac2esbl mac3esbl mac4esbl

gen mac1_mac2_same_resistance = (mac1ctzr == mac2ctzr & mac1cipr == mac2cipr & ///
                                 mac1imir == mac2imir)
								 
gen mac1_mac3_same_resistance = (mac1ctzr == mac3ctzr & mac1cipr == mac3cipr & ///
                                 mac1imir == mac3imir)

gen mac1_mac4_same_resistance = (mac1ctzr == mac4ctzr & mac1cipr == mac4cipr & ///
                                 mac1imir == mac4imir)

gen mac2_mac3_same_resistance = (mac2ctzr == mac3ctzr & mac2cipr == mac3cipr & ///
                                 mac2imir == mac3imir)

gen mac2_mac4_same_resistance = (mac2ctzr == mac4ctzr & mac2cipr == mac4cipr & ///
                                 mac2imir == mac4imir)

gen mac3_mac4_same_resistance = (mac3ctzr == mac4ctzr & mac3cipr == mac4cipr & ///
                                 mac3imir == mac4imir)
								 
replace mac2ID = . if mac1_equals_mac2 == 1 & mac1_mac2_same_resistance == 1
replace mac2ctzr = . if mac1_equals_mac2 == 1 & mac1_mac2_same_resistance == 1
replace mac2cipr = . if mac1_equals_mac2 == 1 & mac1_mac2_same_resistance == 1
replace mac2imir = . if mac1_equals_mac2 == 1 & mac1_mac2_same_resistance == 1

replace mac3ID = . if mac1_equals_mac3 == 1 & mac1_mac3_same_resistance == 1
replace mac3ctzr = . if mac1_equals_mac3 == 1 & mac1_mac3_same_resistance == 1
replace mac3cipr = . if mac1_equals_mac3 == 1 & mac1_mac3_same_resistance == 1
replace mac3imir = . if mac1_equals_mac3 == 1 & mac1_mac3_same_resistance == 1

replace mac4ID = . if mac1_equals_mac4 == 1 & mac1_mac4_same_resistance == 1
replace mac4ctzr = . if mac1_equals_mac4 == 1 & mac1_mac4_same_resistance == 1
replace mac4cipr = . if mac1_equals_mac4 == 1 & mac1_mac4_same_resistance == 1
replace mac4imir = . if mac1_equals_mac4 == 1 & mac1_mac4_same_resistance == 1

replace mac3ID = . if mac2_equals_mac3 == 1 & mac2_mac3_same_resistance == 1
replace mac3ctzr = . if mac2_equals_mac3 == 1 & mac2_mac3_same_resistance == 1
replace mac3cipr = . if mac2_equals_mac3 == 1 & mac2_mac3_same_resistance == 1
replace mac3imir = . if mac2_equals_mac3 == 1 & mac2_mac3_same_resistance == 1

replace mac4ID = . if mac2_equals_mac4 == 1 & mac2_mac4_same_resistance == 1
replace mac4ctzr = . if mac2_equals_mac4 == 1 & mac2_mac4_same_resistance == 1
replace mac4cipr = . if mac2_equals_mac4 == 1 & mac2_mac4_same_resistance == 1
replace mac4imir = . if mac2_equals_mac4 == 1 & mac2_mac4_same_resistance == 1

replace mac4ID = . if mac3_equals_mac4 == 1 & mac3_mac4_same_resistance == 1
replace mac4ctzr = . if mac3_equals_mac4 == 1 & mac3_mac4_same_resistance == 1
replace mac4cipr = . if mac3_equals_mac4 == 1 & mac3_mac4_same_resistance == 1
replace mac4imir = . if mac3_equals_mac4 == 1 & mac3_mac4_same_resistance == 1

replace mac1_equals_mac2 = (mac1ID == mac2ID & !missing(mac1ID) & !missing(mac2ID))
replace mac1_equals_mac3 = (mac1ID == mac3ID & !missing(mac1ID) & !missing(mac3ID))
replace mac1_equals_mac4 = (mac1ID == mac4ID & !missing(mac1ID) & !missing(mac4ID))
replace mac2_equals_mac3 = (mac2ID == mac3ID & !missing(mac2ID) & !missing(mac3ID))
replace mac2_equals_mac4 = (mac2ID == mac4ID & !missing(mac2ID) & !missing(mac4ID))
replace mac3_equals_mac4 = (mac3ID == mac4ID & !missing(mac3ID) & !missing(mac4ID))

count if mac1_equals_mac2 == 1
display "mac1ID = mac2ID: " r(N)
// 331 -> 91
count if mac1_equals_mac3 == 1
display "mac1ID = mac3ID: " r(N)
// 50 -> 18
count if mac1_equals_mac4 == 1
display "mac1ID = mac4ID: " r(N)
// 11 -> 4
count if mac2_equals_mac3 == 1
display "mac2ID = mac3ID: " r(N)
// 66 -> 12
count if mac2_equals_mac4 == 1
display "mac2ID = mac4ID: " r(N)
// 10 -> 2
count if mac3_equals_mac4 == 1
display "mac3ID = mac4ID: " r(N)
// 11 -> 2

drop mac1_equals_mac2 mac1_equals_mac3 mac1_equals_mac4 ///
     mac2_equals_mac3 mac2_equals_mac4 mac3_equals_mac4 ///
     mac1_mac2_same_resistance mac1_mac3_same_resistance mac1_mac4_same_resistance ///
     mac2_mac3_same_resistance mac2_mac4_same_resistance mac3_mac4_same_resistance
								 	  
save micro_data_cleaned_modified.dta, replace


// Make the bucket based on type
use micro_data_cleaned_modified.dta, clear
// count -- 6,110

// Duplicate each row for each valid macID
expand 4  // Each row is duplicated 4 times (once per macID)
// count -- 24,440

// Step 1: Identify Patient & Environment Specimen
gen is_specimen_E = substr(specimen, 1, 1) == "E"
gen is_specimen_P = inlist(specimen, "G", "H", "N", "O", "R")

// Step 2: Count the number of valid (non-missing) macID values
gen valid_gnb_count = !missing(mac1ID) + !missing(mac2ID) + !missing(mac3ID) + !missing(mac4ID)
keep if valid_gnb_count != 0
// count -- 24,412

// Step 2: Create an index variable to differentiate the duplicated rows
gen mac_index = mod(_n, 4)

// Step 3: Assign first valid macID based on the duplicate index
gen first_valid_mac = ""
replace first_valid_mac = "mac1" if mac_index == 1 & !missing(mac1ID)
replace first_valid_mac = "mac2" if mac_index == 2 & !missing(mac2ID)
replace first_valid_mac = "mac3" if mac_index == 3 & !missing(mac3ID)
replace first_valid_mac = "mac4" if mac_index == 0 & !missing(mac4ID)

// mac1 - 6101, mac2 - 1433, mac3 - 320, mac4 - 47

// Step 4: Remove duplicates where the assigned first_valid_mac is missing
drop if missing(first_valid_mac)
// count -- 7901

// Step 5: Count valid `macID`s excluding the first one
gen remaining_gnb_count = valid_gnb_count - 1

// Step 5: Check if remaining macIDs have resistance
gen resistance_other_mac = 0
foreach mac in mac1 mac2 mac3 mac4 {
    replace resistance_other_mac = 1 if ///
        first_valid_mac != "`mac'" & !missing(`mac'ID) & ///
        (`mac'ctzr == 1 | `mac'cipr == 1 | `mac'imir == 1)
}

// Step 6: Assign bucket categories
gen bucket_group = .
replace bucket_group = 1 if remaining_gnb_count == 0
replace bucket_group = 2 if remaining_gnb_count > 0 & resistance_other_mac == 0
replace bucket_group = 3 if remaining_gnb_count > 0 & resistance_other_mac == 1
tabulate bucket_group
// 1 - 4663, 2 - 1937, 3 - 1301

// Step 7: Create separate variables for patients and environment
gen bucket_group_patient = bucket_group if is_specimen_P == 1
tabulate bucket_group_patient
// 1 - 1373, 2 - 1065, 3 - 789
gen bucket_group_environment = bucket_group if is_specimen_E == 1
tabulate bucket_group_environment
// 1 - 2661, 2 - 686, 3 - 434

// Save the modified dataset
save micro_data_bucketed.dta, replace
