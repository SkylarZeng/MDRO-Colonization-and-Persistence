// import Datasets
use micro_data_bucketed.dta, clear

// drop other specimen except E and P
keep if is_specimen_E == 1 | is_specimen_P == 1

// Count for patients (bucket_group_patient)
// only 1 gnb
// Swab level (46)
count if bucket_group_patient == 1 & ((first_valid_mac == "mac1" & mac1ID == 1) | ///
                                     (first_valid_mac == "mac2" & mac2ID == 1) | ///
                                     (first_valid_mac == "mac3" & mac3ID == 1) | ///
                                     (first_valid_mac == "mac4" & mac4ID == 1)) & tag_swab
display "Patient - Bucket = 1, First macID = 1 (Swab Level): " r(N)

// Visit level (32)
count if bucket_group_patient == 1 & ((first_valid_mac == "mac1" & mac1ID == 1) | ///
                                     (first_valid_mac == "mac2" & mac2ID == 1) | ///
                                     (first_valid_mac == "mac3" & mac3ID == 1) | ///
                                     (first_valid_mac == "mac4" & mac4ID == 1)) & tag_visit
display "Patient - Bucket = 1, First macID = 1 (Visit Level): " r(N)

// Patient level (19)
count if bucket_group_patient == 1 & ((first_valid_mac == "mac1" & mac1ID == 1) | ///
                                     (first_valid_mac == "mac2" & mac2ID == 1) | ///
                                     (first_valid_mac == "mac3" & mac3ID == 1) | ///
                                     (first_valid_mac == "mac4" & mac4ID == 1)) & tag_patient
display "Patient - Bucket = 1, First macID = 1 (Patient Level): " r(N)

// more than 1, susceptible
// Swab level (25)
count if bucket_group_patient == 2 & ((first_valid_mac == "mac1" & mac1ID == 1) | ///
                                     (first_valid_mac == "mac2" & mac2ID == 1) | ///
                                     (first_valid_mac == "mac3" & mac3ID == 1) | ///
                                     (first_valid_mac == "mac4" & mac4ID == 1)) & tag_swab
display "Patient - Bucket = 2, First macID = 1 (Swab Level): " r(N)

// Visit level (11)
count if bucket_group_patient == 2 & ((first_valid_mac == "mac1" & mac1ID == 1) | ///
                                     (first_valid_mac == "mac2" & mac2ID == 1) | ///
                                     (first_valid_mac == "mac3" & mac3ID == 1) | ///
                                     (first_valid_mac == "mac4" & mac4ID == 1)) & tag_visit
display "Patient - Bucket = 2, First macID = 1 (Visit Level): " r(N)

// Patient level (4)
count if bucket_group_patient == 2 & ((first_valid_mac == "mac1" & mac1ID == 1) | ///
                                     (first_valid_mac == "mac2" & mac2ID == 1) | ///
                                     (first_valid_mac == "mac3" & mac3ID == 1) | ///
                                     (first_valid_mac == "mac4" & mac4ID == 1)) & tag_patient
display "Patient - Bucket = 2, First macID = 1 (Patient Level): " r(N)

// more than 1, resistance
// Swab level (16)
count if bucket_group_patient == 3 & ((first_valid_mac == "mac1" & mac1ID == 1) | ///
                                     (first_valid_mac == "mac2" & mac2ID == 1) | ///
                                     (first_valid_mac == "mac3" & mac3ID == 1) | ///
                                     (first_valid_mac == "mac4" & mac4ID == 1)) & tag_swab
display "Patient - Bucket = 3, First macID = 1 (Swab Level): " r(N)

//check code
list studyID visit specimen mac1ID mac2ID mac3ID mac4ID if bucket_group_patient == 3 & ((first_valid_mac == "mac1" & mac1ID == 1) | (first_valid_mac == "mac2" & mac2ID == 1) | (first_valid_mac == "mac3" & mac3ID == 1) | (first_valid_mac == "mac4" & mac4ID == 1))

// Visit level (10)
count if bucket_group_patient == 3 & ((first_valid_mac == "mac1" & mac1ID == 1) | ///
                                     (first_valid_mac == "mac2" & mac2ID == 1) | ///
                                     (first_valid_mac == "mac3" & mac3ID == 1) | ///
                                     (first_valid_mac == "mac4" & mac4ID == 1)) & tag_visit
display "Patient - Bucket = 3, First macID = 1 (Visit Level): " r(N)

//check code
list studyID visit specimen mac1ID mac2ID mac3ID mac4ID if bucket_group_patient == 3 & tag_visit == 1 & ((first_valid_mac == "mac1" & mac1ID == 1) | (first_valid_mac == "mac2" & mac2ID == 1) | (first_valid_mac == "mac3" & mac3ID == 1) | (first_valid_mac == "mac4" & mac4ID == 1))

// Patient level (6)
count if bucket_group_patient == 3 & ((first_valid_mac == "mac1" & mac1ID == 1) | ///
                                     (first_valid_mac == "mac2" & mac2ID == 1) | ///
                                     (first_valid_mac == "mac3" & mac3ID == 1) | ///
                                     (first_valid_mac == "mac4" & mac4ID == 1)) & tag_patient
display "Patient - Bucket = 3, First macID = 1 (Patient Level): " r(N)

// Count Resistance
// Bucket 1
// Count first_valid_mac resistant to CTZR
// Swab Level
count if bucket_group_patient == 1 & ((first_valid_mac == "mac1" & mac1ID == 1 & mac1ctzr == 1) /// 
                                      | (first_valid_mac == "mac2" & mac2ID == 1 & mac2ctzr == 1) /// 
                                      | (first_valid_mac == "mac3" & mac3ID == 1 & mac3ctzr == 1) /// 
                                      | (first_valid_mac == "mac4" & mac4ID == 1 & mac4ctzr == 1)) & tag_swab
display "Patient - Bucket - swab = 1, First GNB Resistant to CTZR: " r(N)

// Visit Level
count if bucket_group_patient == 1 & ((first_valid_mac == "mac1" & mac1ID == 1 & mac1ctzr == 1) /// 
                                      | (first_valid_mac == "mac2" & mac2ID == 1 & mac2ctzr == 1) /// 
                                      | (first_valid_mac == "mac3" & mac3ID == 1 & mac3ctzr == 1) /// 
                                      | (first_valid_mac == "mac4" & mac4ID == 1 & mac4ctzr == 1)) & tag_visit
display "Patient - Bucket - visit = 1, First GNB Resistant to CTZR: " r(N)

// Patient Level
count if bucket_group_patient == 1 & ((first_valid_mac == "mac1" & mac1ID == 1 & mac1ctzr == 1) /// 
                                      | (first_valid_mac == "mac2" & mac2ID == 1 & mac2ctzr == 1) /// 
                                      | (first_valid_mac == "mac3" & mac3ID == 1 & mac3ctzr == 1) /// 
                                      | (first_valid_mac == "mac4" & mac4ID == 1 & mac4ctzr == 1)) & tag_patient
display "Patient - Bucket - patient = 1, First GNB Resistant to CTZR: " r(N)

// CIPR
// Swab Level
count if bucket_group_patient == 1 & ((first_valid_mac == "mac1" & mac1ID == 1 & mac1cipr == 1) /// 
                                      | (first_valid_mac == "mac2" & mac2ID == 1 & mac2cipr == 1) /// 
                                      | (first_valid_mac == "mac3" & mac3ID == 1 & mac3cipr == 1) /// 
                                      | (first_valid_mac == "mac4" & mac4ID == 1 & mac4cipr == 1)) & tag_swab
display "Patient - Bucket - swab = 1, First GNB Resistant to CIPR: " r(N)

// Visit Level
count if bucket_group_patient == 1 & ((first_valid_mac == "mac1" & mac1ID == 1 & mac1cipr == 1) /// 
                                      | (first_valid_mac == "mac2" & mac2ID == 1 & mac2cipr == 1) /// 
                                      | (first_valid_mac == "mac3" & mac3ID == 1 & mac3cipr == 1) /// 
                                      | (first_valid_mac == "mac4" & mac4ID == 1 & mac4cipr == 1)) & tag_visit
display "Patient - Bucket - visit = 1, First GNB Resistant to CIPR: " r(N)

// Patient Level
count if bucket_group_patient == 1 & ((first_valid_mac == "mac1" & mac1ID == 1 & mac1cipr == 1) /// 
                                      | (first_valid_mac == "mac2" & mac2ID == 1 & mac2cipr == 1) /// 
                                      | (first_valid_mac == "mac3" & mac3ID == 1 & mac3cipr == 1) /// 
                                      | (first_valid_mac == "mac4" & mac4ID == 1 & mac4cipr == 1)) & tag_patient
display "Patient - Bucket - patient = 1, First GNB Resistant to CIPR: " r(N)

//IMIR
// Swab Level
count if bucket_group_patient == 1 & ((first_valid_mac == "mac1" & mac1ID == 1 & mac1imir == 1) /// 
                                      | (first_valid_mac == "mac2" & mac2ID == 1 & mac2imir == 1) /// 
                                      | (first_valid_mac == "mac3" & mac3ID == 1 & mac3imir == 1) /// 
                                      | (first_valid_mac == "mac4" & mac4ID == 1 & mac4imir == 1)) & tag_swab
display "Patient - Bucket - swab = 1, First GNB Resistant to IMIR: " r(N)

// Visit Level
count if bucket_group_patient == 1 & ((first_valid_mac == "mac1" & mac1ID == 1 & mac1imir == 1) /// 
                                      | (first_valid_mac == "mac2" & mac2ID == 1 & mac2imir == 1) /// 
                                      | (first_valid_mac == "mac3" & mac3ID == 1 & mac3imir == 1) /// 
                                      | (first_valid_mac == "mac4" & mac4ID == 1 & mac4imir == 1)) & tag_visit
display "Patient - Bucket - visit = 1, First GNB Resistant to IMIR: " r(N)

// Patient Level
count if bucket_group_patient == 1 & ((first_valid_mac == "mac1" & mac1ID == 1 & mac1imir == 1) /// 
                                      | (first_valid_mac == "mac2" & mac2ID == 1 & mac2imir == 1) /// 
                                      | (first_valid_mac == "mac3" & mac3ID == 1 & mac3imir == 1) /// 
                                      | (first_valid_mac == "mac4" & mac4ID == 1 & mac4imir == 1)) & tag_patient
display "Patient - Bucket - patient = 1, First GNB Resistant to IMIR: " r(N)


//Bucket 2
// Count First Valid macID Resistant to CTZR in Bucket 2

// Swab Level
count if bucket_group_patient == 2 & ( ///
    (first_valid_mac == "mac1" & mac1ID == 1 & mac1ctzr == 1) | ///
    (first_valid_mac == "mac2" & mac2ID == 1 & mac2ctzr == 1) | ///
    (first_valid_mac == "mac3" & mac3ID == 1 & mac3ctzr == 1) | ///
    (first_valid_mac == "mac4" & mac4ID == 1 & mac4ctzr == 1) ///
) & tag_swab
display "Patient - Bucket 2 - swab = 1, Reference GNB Resistant to CTZR: " r(N)

// Visit Level
count if bucket_group_patient == 2 & ( ///
    (first_valid_mac == "mac1" & mac1ID == 1 & mac1ctzr == 1) | ///
    (first_valid_mac == "mac2" & mac2ID == 1 & mac2ctzr == 1) | ///
    (first_valid_mac == "mac3" & mac3ID == 1 & mac3ctzr == 1) | ///
    (first_valid_mac == "mac4" & mac4ID == 1 & mac4ctzr == 1) ///
) & tag_visit
display "Patient - Bucket 2 - visit = 1, Reference GNB Resistant to CTZR: " r(N)

// Patient Level
count if bucket_group_patient == 2 & ( ///
    (first_valid_mac == "mac1" & mac1ID == 1 & mac1ctzr == 1) | ///
    (first_valid_mac == "mac2" & mac2ID == 1 & mac2ctzr == 1) | ///
    (first_valid_mac == "mac3" & mac3ID == 1 & mac3ctzr == 1) | ///
    (first_valid_mac == "mac4" & mac4ID == 1 & mac4ctzr == 1) ///
) & tag_patient
display "Patient - Bucket 2 - patient = 1, Reference GNB Resistant to CTZR: " r(N)

// CIPR
// Swab Level
count if bucket_group_patient == 2 & ( ///
    (first_valid_mac == "mac1" & mac1ID == 1 & mac1cipr == 1) | ///
    (first_valid_mac == "mac2" & mac2ID == 1 & mac2cipr == 1) | ///
    (first_valid_mac == "mac3" & mac3ID == 1 & mac3cipr == 1) | ///
    (first_valid_mac == "mac4" & mac4ID == 1 & mac4cipr == 1) ///
) & tag_swab
display "Patient - Bucket 2 - swab = 1, Reference GNB Resistant to CIPR: " r(N)

// Visit Level
count if bucket_group_patient == 2 & ( ///
    (first_valid_mac == "mac1" & mac1ID == 1 & mac1cipr == 1) | ///
    (first_valid_mac == "mac2" & mac2ID == 1 & mac2cipr == 1) | ///
    (first_valid_mac == "mac3" & mac3ID == 1 & mac3cipr == 1) | ///
    (first_valid_mac == "mac4" & mac4ID == 1 & mac4cipr == 1) ///
) & tag_visit
display "Patient - Bucket 2 - visit = 1, Reference GNB Resistant to CIPR: " r(N)

// Patient Level
count if bucket_group_patient == 2 & ( ///
    (first_valid_mac == "mac1" & mac1ID == 1 & mac1cipr == 1) | ///
    (first_valid_mac == "mac2" & mac2ID == 1 & mac2cipr == 1) | ///
    (first_valid_mac == "mac3" & mac3ID == 1 & mac3cipr == 1) | ///
    (first_valid_mac == "mac4" & mac4ID == 1 & mac4cipr == 1) ///
) & tag_patient
display "Patient - Bucket 2 - patient = 1, Reference GNB Resistant to CIPR: " r(N)


// IMIR
// Swab Level
count if bucket_group_patient == 2 & ( ///
    (first_valid_mac == "mac1" & mac1ID == 1 & mac1imir == 1) | ///
    (first_valid_mac == "mac2" & mac2ID == 1 & mac2imir == 1) | ///
    (first_valid_mac == "mac3" & mac3ID == 1 & mac3imir == 1) | ///
    (first_valid_mac == "mac4" & mac4ID == 1 & mac4imir == 1) ///
) & tag_swab
display "Patient - Bucket 2 - swab = 1, Reference GNB Resistant to IMIR: " r(N)

// Visit Level
count if bucket_group_patient == 2 & ( ///
    (first_valid_mac == "mac1" & mac1ID == 1 & mac1imir == 1) | ///
    (first_valid_mac == "mac2" & mac2ID == 1 & mac2imir == 1) | ///
    (first_valid_mac == "mac3" & mac3ID == 1 & mac3imir == 1) | ///
    (first_valid_mac == "mac4" & mac4ID == 1 & mac4imir == 1) ///
) & tag_visit
display "Patient - Bucket 2 - visit = 1, Reference GNB Resistant to IMIR: " r(N)

// Patient Level
count if bucket_group_patient == 2 & ( ///
    (first_valid_mac == "mac1" & mac1ID == 1 & mac1imir == 1) | ///
    (first_valid_mac == "mac2" & mac2ID == 1 & mac2imir == 1) | ///
    (first_valid_mac == "mac3" & mac3ID == 1 & mac3imir == 1) | ///
    (first_valid_mac == "mac4" & mac4ID == 1 & mac4imir == 1) ///
) & tag_patient
display "Patient - Bucket 2 - patient = 1, Reference GNB Resistant to IMIR: " r(N)

//Bucket 3
// Count First Valid macID Resistant to CTZR in Bucket 3

// Swab Level
count if bucket_group_patient == 3 & ( ///
    (first_valid_mac == "mac1" & mac1ID == 1 & mac1ctzr == 1) | ///
    (first_valid_mac == "mac2" & mac2ID == 1 & mac2ctzr == 1) | ///
    (first_valid_mac == "mac3" & mac3ID == 1 & mac3ctzr == 1) | ///
    (first_valid_mac == "mac4" & mac4ID == 1 & mac4ctzr == 1) ///
) & tag_swab
display "Patient - Bucket 3 - swab = 1, Reference GNB Resistant to CTZR: " r(N)

// Visit Level
count if bucket_group_patient == 3 & ( ///
    (first_valid_mac == "mac1" & mac1ID == 1 & mac1ctzr == 1) | ///
    (first_valid_mac == "mac2" & mac2ID == 1 & mac2ctzr == 1) | ///
    (first_valid_mac == "mac3" & mac3ID == 1 & mac3ctzr == 1) | ///
    (first_valid_mac == "mac4" & mac4ID == 1 & mac4ctzr == 1) ///
) & tag_visit
display "Patient - Bucket 3 - visit = 1, Reference GNB Resistant to CTZR: " r(N)

// Patient Level
count if bucket_group_patient == 3 & ( ///
    (first_valid_mac == "mac1" & mac1ID == 1 & mac1ctzr == 1) | ///
    (first_valid_mac == "mac2" & mac2ID == 1 & mac2ctzr == 1) | ///
    (first_valid_mac == "mac3" & mac3ID == 1 & mac3ctzr == 1) | ///
    (first_valid_mac == "mac4" & mac4ID == 1 & mac4ctzr == 1) ///
) & tag_patient
display "Patient - Bucket 3 - patient = 1, Reference GNB Resistant to CTZR: " r(N)

// CIPR
// Swab Level
count if bucket_group_patient == 3 & ( ///
    (first_valid_mac == "mac1" & mac1ID == 1 & mac1cipr == 1) | ///
    (first_valid_mac == "mac2" & mac2ID == 1 & mac2cipr == 1) | ///
    (first_valid_mac == "mac3" & mac3ID == 1 & mac3cipr == 1) | ///
    (first_valid_mac == "mac4" & mac4ID == 1 & mac4cipr == 1) ///
) & tag_swab
display "Patient - Bucket 3 - swab = 1, Reference GNB Resistant to CIPR: " r(N)

// Visit Level
count if bucket_group_patient == 3 & ( ///
    (first_valid_mac == "mac1" & mac1ID == 1 & mac1cipr == 1) | ///
    (first_valid_mac == "mac2" & mac2ID == 1 & mac2cipr == 1) | ///
    (first_valid_mac == "mac3" & mac3ID == 1 & mac3cipr == 1) | ///
    (first_valid_mac == "mac4" & mac4ID == 1 & mac4cipr == 1) ///
) & tag_visit
display "Patient - Bucket 3 - visit = 1, Reference GNB Resistant to CIPR: " r(N)

// Patient Level
count if bucket_group_patient == 3 & ( ///
    (first_valid_mac == "mac1" & mac1ID == 1 & mac1cipr == 1) | ///
    (first_valid_mac == "mac2" & mac2ID == 1 & mac2cipr == 1) | ///
    (first_valid_mac == "mac3" & mac3ID == 1 & mac3cipr == 1) | ///
    (first_valid_mac == "mac4" & mac4ID == 1 & mac4cipr == 1) ///
) & tag_patient
display "Patient - Bucket 3 - patient = 1, Reference GNB Resistant to CIPR: " r(N)


// IMIR
// Swab Level
count if bucket_group_patient == 3 & ( ///
    (first_valid_mac == "mac1" & mac1ID == 1 & mac1imir == 1) | ///
    (first_valid_mac == "mac2" & mac2ID == 1 & mac2imir == 1) | ///
    (first_valid_mac == "mac3" & mac3ID == 1 & mac3imir == 1) | ///
    (first_valid_mac == "mac4" & mac4ID == 1 & mac4imir == 1) ///
) & tag_swab
display "Patient - Bucket 3 - swab = 1, Reference GNB Resistant to IMIR: " r(N)

// Visit Level
count if bucket_group_patient == 3 & ( ///
    (first_valid_mac == "mac1" & mac1ID == 1 & mac1imir == 1) | ///
    (first_valid_mac == "mac2" & mac2ID == 1 & mac2imir == 1) | ///
    (first_valid_mac == "mac3" & mac3ID == 1 & mac3imir == 1) | ///
    (first_valid_mac == "mac4" & mac4ID == 1 & mac4imir == 1) ///
) & tag_visit
display "Patient - Bucket 3 - visit = 1, Reference GNB Resistant to IMIR: " r(N)

// Patient Level
count if bucket_group_patient == 3 & ( ///
    (first_valid_mac == "mac1" & mac1ID == 1 & mac1imir == 1) | ///
    (first_valid_mac == "mac2" & mac2ID == 1 & mac2imir == 1) | ///
    (first_valid_mac == "mac3" & mac3ID == 1 & mac3imir == 1) | ///
    (first_valid_mac == "mac4" & mac4ID == 1 & mac4imir == 1) ///
) & tag_patient
display "Patient - Bucket 3 - patient = 1, Reference GNB Resistant to IMIR: " r(N)




// Count for enviroment (bucket_group_enviroment)
// only 1 gnb
// more than 1, susceptible
// more than 1, resistance
