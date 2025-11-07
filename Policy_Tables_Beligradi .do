
global ROOT "/Users/diellzabeligradi/Desktop/POLICY PROJECT"

cd "$ROOT"

log using "policy_TABLES_beligradi.log", name (DB) replace 

**************************** TABLE 1 *******************************************


use "cps_policy.dta", clear
*******************************************************************************
* Summary Statistics by Group
 ********************************************************************************

* All Women 18–50
estpost summarize age educ_yrs educ_cat married black hispanic under5 ///
    nchild employed incwage_2013 incwage_2013_con ///
    hh_earnings_2013 hh_earnings_2013_con EITC_elig EITC_elig_con ///
    wkswork_mid wkswork_mid_con uhrsworkly uhrsworkly_con [aw=asecwt] if female == 1
est store All

* Mothers
estpost summarize age educ_yrs educ_cat married black hispanic under5 ///
    nchild employed incwage_2013 incwage_2013_con ///
    hh_earnings_2013 hh_earnings_2013_con EITC_elig EITC_elig_con ///
    wkswork_mid wkswork_mid_con uhrsworkly uhrsworkly_con [aw=asecwt] if mother == 1
est store Mothers

* No Kids
estpost summarize age educ_yrs educ_cat married black hispanic under5 ///
    nchild employed incwage_2013 incwage_2013_con ///
    hh_earnings_2013 hh_earnings_2013_con EITC_elig EITC_elig_con ///
    wkswork_mid wkswork_mid_con uhrsworkly uhrsworkly_con [aw=asecwt] if mother == 0
est store NoKids

* Married
estpost summarize age educ_yrs educ_cat married black hispanic under5 ///
    nchild employed incwage_2013 incwage_2013_con ///
    hh_earnings_2013 hh_earnings_2013_con EITC_elig EITC_elig_con ///
    wkswork_mid wkswork_mid_con uhrsworkly uhrsworkly_con [aw=asecwt] if married == 1
est store Married

* Not Married
estpost summarize age educ_yrs educ_cat married black hispanic under5 ///
    nchild employed incwage_2013 incwage_2013_con ///
    hh_earnings_2013 hh_earnings_2013_con EITC_elig EITC_elig_con ///
    wkswork_mid wkswork_mid_con uhrsworkly uhrsworkly_con [aw=asecwt] if notmarried == 1
est store NotMarried


********************************************************************************
* Export Table 1: Summary Statistics
********************************************************************************
esttab All Mothers NoKids Married NotMarried, ///
    main(mean %9.2f) aux(sd %9.2f) stats(N, fmt(%9.0f) labels("Observations")) ///
    label nonumbers varwidth(28) alignment(r) ///
    title("Table 1: Summary Statistics (Women ages 18–50)") ///
    mlabels("All Women" "Mothers" "No Kids" "Married" "Not Married") ///
    coeflabels( ///
        age              "Age (years)" ///
        educ_yrs         "Years of Education" ///
        educ_cat         "Education Levels" ///
        married          "Married (Spouse Present)" ///
        black            "Black" ///
        hispanic         "Hispanic" ///
        under5           "Any Children Under 5" ///
        nchild           "Number of Children" ///
        employed         "Employed" ///
        incwage_2013     "Individual Earnings (2013$)" ///
        incwage_2013_con "Individual Earnings (2013$, >0)" ///
        hh_earnings_2013 "Household Earnings (2013$)" ///
        hh_earnings_2013_con "Household Earnings (2013$, >0)" ///
        EITC_elig        "EITC-Eligible Household (Nominal $)" ///
        EITC_elig_con    "EITC-Eligible Household (Nominal $, >0)" ///
        wkswork_mid      "Annual Weeks Worked" ///
        wkswork_mid_con  "Annual Weeks Worked (>0)" ///
        uhrsworkly       "Weekly Hours Worked" ///
        uhrsworkly_con   "Weekly Hours Worked (>0)" ///
    ) ///
    addnotes("Notes: Individual March CPS weights (asecwt) used.", ///
             "The sample includes all women ages 18–50.", ///
             "Standard deviations are in parentheses.", ///
             "A total of 376,919 individuals have positive individual earnings,", ///
             "500,471 have positive household earnings,", ///
             "397,210 have positive weeks worked last year,", ///
             "and 315,902 have positive hours worked last week.", ///
             "Source: 1971–1986 March CPS data.")

			 
			 
			 
********************************************************************************
* Latex
********************************************************************************			
esttab All Mothers NoKids Married NotMarried using "Table1_SummaryStats.tex", ///
    replace ///
    booktabs ///
    main(mean %9.2f) aux(sd %9.2f) stats(N, fmt(%9.0f) labels("Observations")) ///
    label nonumbers varwidth(28) alignment(r) ///
    title("Table 1: Summary Statistics (Women ages 18–50)") ///
    mlabels("All Women" "Mothers" "No Kids" "Married" "Not Married") ///
    coeflabels( ///
        age              "Age (years)" ///
        educ_yrs         "Years of Education" ///
        educ_cat         "Education Levels" ///
        married          "Married (Spouse Present)" ///
        black            "Black" ///
        hispanic         "Hispanic" ///
        under5           "Any Children Under 5" ///
        nchild           "Number of Children" ///
        employed         "Employed" ///
        incwage_2013     "Individual Earnings (2013$)" ///
        incwage_2013_con "Individual Earnings (2013$, >0)" ///
        hh_earnings_2013 "Household Earnings (2013$)" ///
        hh_earnings_2013_con "Household Earnings (2013$, >0)" ///
        EITC_elig        "EITC-Eligible Household (Nominal $)" ///
        EITC_elig_con    "EITC-Eligible Household (Nominal $, >0)" ///
        wkswork_mid      "Annual Weeks Worked" ///
        wkswork_mid_con  "Annual Weeks Worked (>0)" ///
        uhrsworkly       "Weekly Hours Worked" ///
        uhrsworkly_con   "Weekly Hours Worked (>0)" ///
    ) ///
    addnotes("Notes: Individual March CPS weights (asecwt) used.", ///
             "The sample includes all women ages 18–50.", ///
             "Standard deviations are in parentheses.", ///
             "A total of 376,919 individuals have positive individual earnings,", ///
             "500,471 have positive household earnings,", ///
             "397,210 have positive weeks worked last year,", ///
             "and 315,902 have positive hours worked last week.", ///
             "Source: 1971–1986 March CPS data.")
			 
			 


			 
			 
***************************** TABLE 2 *****************************************




use "cps_women.dta", clear

summarize 
********************************************************************************
* Interaction term 
********************************************************************************
gen mom = mother * post1975   // Mom × Post1975

tab mom 
tab mother 



gen nonwhite_mom = mother * nonwhite 
label var nonwhite_mom "non white mother (interaction term)"

gen mom_age = mom * age 
label var mom_age "moms age interaction term"

gen nonwhite_post = nonwhite * post1975
label var nonwhite_post "nonwhite 1975 (interaction term)"

gen married_post = married * post1975 
label var married_post "married 1975 (interaction term)"

gen cohort = year - age 
label var cohort "age group (inteaction term)"


*Kitchen-sink
gen nonwhite_incwelfr = nonwhite * incwelfr
label var nonwhite_incwelfr "nonwhite welfare (interaction term)"

gen nonwhite_married = nonwhite * married 
label var nonwhite_married "Nonwhite married (inteaction term)"

gen nchild_married = nchild * married 
label var nchild_married "nchild and married(inteaction term)" 

gen under5_married = under5 * married 
label var under5_married "Number of children under 5 and married (inteaction term)" 

gen married_incwelfr = married * incwelfr
label var married_incwelfr "Married welfare (interaction term)" 

gen eduyrs_married = educ_yrs * married 
label var eduyrs_married  " Education and married(interaction term)"

gen educyrs_under5 = educ_yrs * under5 
label var educyrs_under5 " education year & child under 5 (interaction term)"

gen educyrs_nonwhite = educ_yrs * nonwhite 
label var educyrs_nonwhite " nonwhite education (interaction term)"

gen nonwhite_age3 = nonwhite * age3
label var nonwhite_age3 "Nonwhite age cubic (interaction term)"


*Kitchen-sink fixed effects 
gen nonwhite_year = nonwhite * year 
label var nonwhite_year "Nonwhite year fixed effects"

gen married_year = married * year 
label var married_year "Married year fixed effects"

gen nonwhite_state = nonwhite * state 
label var nonwhite_state "nonwhite state fixed effects"

gen birth_year = cohort * year
label var birth_year "birth year fixed effects"

gen state_year = state * year 
label var state_year "state year fixed effects"

gen state_married = state * married 
label var state_married "State married fixed effects"

gen state_under5 = state * under5 
label var state_under5 "State child under 5 fixed effects"

gen stateyr_nonwhite = state_year * nonwhite 
label var stateyr_nonwhite "state year nonwhite fixed effects"

gen stateyr_married  = state_year * married 
label var stateyr_married "state year nonwhite fixed effects"




********************************************************************************
* Baseline
********************************************************************************
logit employed mother post1975 i.mom [pw=asecwt], vce(cluster state)

margins, dydx (mom) post

eststo col1, title("Baseline (Logit)")
			 
********************************************************************************
* Column 2
********************************************************************************
logit employed mother post1975 i.mom i.state i.year [pw=asecwt], vce(cluster state)


margins, dydx (mom) post

eststo col2, title("State-Year FE (Logit)")

count 
********************************************************************************
* Column 3: LOGIT Demographic controls include married, welfare income, number of children, any children under five, age cubic, birth cohort, years of education quadratic, nonwhite-mom, nonwhite-post1975, age-mom, and married-post1975.
********************************************************************************
logit employed mother post1975 i.mom i.state i.year married incwelfr  nchild under5 nonwhite age age2 age3 educ_yrs educ_yrs2 nonwhite_mom  nonwhite_post mom_age married_post cohort [pw=asecwt], vce(cluster state)


margins, dydx(mom)post 

*includes mom interaction 
*state year fixed effects 
*Demographic controls 


eststo col3, title("Logit + Demographic Controls") :

********************************************************************************
* Column 4: PROBIT Demographic controls include married, welfare income, number of children, any children under five, age cubic, birth cohort, years of education quadratic, nonwhite-mom, nonwhite-post1975, age-mom, and married-post1975.
********************************************************************************
probit employed mother post1975 i.mom i.state i.year married incwelfr nchild under5 nonwhite age age2 age3 educ_yrs educ_yrs2 nonwhite_mom nonwhite_post mom_age married_post cohort [pw=asecwt], vce(cluster state)

margins, dydx(mom)post 

eststo col4, title("Probit + Demographic Controls")

********************************************************************************
* column 5: "Kitchen-sink" controls include unemployment rate-age, nonwhite-welfare, nonwhite-married, number children-married, child less than five-married, married-welfare income, education years-married, educa- tion-child less than five, education-nonwhite, a nonwhite-age cubic, unemployment rate-nonwhite; fixed effects for nonwhite-year, married-year, nonwhite-state, birth-year, state-year, state-married, state-child less than five, state- year-nonwhite, and state-year-married; and annual inflation and state-year manufacturing employment interacted with low education (<12 years), having children, and married.
********************************************************************************
eststo col5: reg employed ///
    mother post1975 i.mom i.state i.year ///
    married incwelfr nchild under5 nonwhite ///
    age age2 age3 educ_yrs educ_yrs2 ///
    nonwhite_mom nonwhite_post mom_age married_post cohort ///
    nonwhite_incwelfr nonwhite_married nchild_married under5_married ///
    married_incwelfr eduyrs_married educyrs_under5 educyrs_nonwhite ///
    nonwhite_age  nonwhite_age3 ///
    




*includes mom interaction 
*state year fixed effects 
*Demographic controls 



* Add indicator flags for each regression type
estadd local Method "LOGIT"   : col1
estadd local Method "LOGIT"   : col2
estadd local Method "LOGIT"   : col3
estadd local Method "LOGIT": col4
estadd local Method "OLS"   : col5


* Add indicator flags for each regression
estadd local FE  ""   : col1
estadd local FE  "Yes": col2
estadd local FE  "Yes": col3
estadd local FE  "Yes": col4
estadd local FE  "Yes": col5

estadd local DEM ""   : col1
estadd local DEM ""   : col2
estadd local DEM "Yes": col3
estadd local DEM "Yes": col4
estadd local DEM "Yes": col5

estadd local KS  ""   : col1
estadd local KS  ""   : col2
estadd local KS  ""   : col3
estadd local KS  ""   : col4
estadd local KS  "Yes": col5




  ****************************************************
* Table 2. The 1975 EITC Increased Maternal Employment
*******************************************************
esttab col1 col2 col3 col4 col5 ///
, keep(1.mom) ///
  coeflabels(1.mom "Mom × Post1975") ///
  cells("b(fmt(3))" "se(par fmt(3))") ///
  nostar ///
  stats(Method N FE DEM KS, fmt(%9s %9.0f %9s %9s %9s) ///
        labels("Method" "Observations" ///
               "State & year FE" "Demographics" "Kitchen-sink")) ///
  label noconstant nobase compress nogap nonum ///
  collabels(none) ///
  mtitles("(1)" "(2)" "(3)" "(4)" "(5)") ///
  addnotes("Average marginal effects reported (logit/probit)." ///
           "Robust standard errors clustered by state in parentheses." ///
           "All regressions weighted using CPS ASEC sample weights." ///
           "Kitchen-sink model includes all demographic, interaction, and state–year fixed effects.")

