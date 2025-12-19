//  clear all
//  set more off
//  log using "policy_TABLES_beligradi.log", name(DB) replace text

*import delimited using "POLICY_CPS.csv", varnames(1) case(preserve) ///
*encoding(UTF-8) bindquote(strict) stripquotes(yes) clear

* ^  use that to run my code. i needed to use this 	
*cd "/Users/diellzabeligradi/Documents/Eco 797/Project/Analysis"
capture cd "/Users/diellzabeligradi/Desktop/POLICY PROJECT

use "POLICY_CPS.dta", clear 





*******************************************************************************
* Summary Statistics by Group
 ********************************************************************************

* All Women 18–50
estpost summarize age educ_yrs married black hispanic under5 ///
    nchild employed incwage_2013 incwage_2013_con ///
    hh_earnings_2013 hh_earnings_2013_con EITC_elig EITC_elig_con ///
    wkswork_mid wkswork_mid_con uhrsworkly uhrsworkly_con [aw=asecwt] if female == 1
est store All

* Mothers
estpost summarize age educ_yrs married black hispanic under5 ///
    nchild employed incwage_2013 incwage_2013_con ///
    hh_earnings_2013 hh_earnings_2013_con EITC_elig EITC_elig_con ///
    wkswork_mid wkswork_mid_con uhrsworkly uhrsworkly_con [aw=asecwt] if mother == 1
est store Mothers

* No Kids
estpost summarize age educ_yrs married black hispanic under5 ///
    nchild employed incwage_2013 incwage_2013_con ///
    hh_earnings_2013 hh_earnings_2013_con EITC_elig EITC_elig_con ///
    wkswork_mid wkswork_mid_con uhrsworkly uhrsworkly_con [aw=asecwt] if mother == 0
est store NoKids

* Married
estpost summarize age educ_yrs married black hispanic under5 ///
    nchild employed incwage_2013 incwage_2013_con ///
    hh_earnings_2013 hh_earnings_2013_con EITC_elig EITC_elig_con ///
    wkswork_mid wkswork_mid_con uhrsworkly uhrsworkly_con [aw=asecwt] if married == 1
est store Married

* Not Married
estpost summarize age educ_yrs  married black hispanic under5 ///
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
   addnotes("Notes: Individual March CPS weights (asecwt) used. The sample includes all women ages 18–50. Standard deviations are in parentheses. A total of 389,574 individuals have positive individual earnings, 503,139 have positive household earnings, 452,037 have positive weeks worked last year, and 376,503 have positive hours worked last week. Source: 1971--1986 March CPS data.")


			 
			 
			 
********************************************************************************
* Latex
********************************************************************************			
esttab All Mothers NoKids Married NotMarried using "Table1.tex", ///
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
         uhrsworkly_con   "Weekly Hours Worked (>0)" ///
    ) ///
   addnotes("Notes: Individual March CPS weights (asecwt) used. The sample includes all women ages 18–50. Standard deviations are in parentheses. A total of 389,574 individuals have positive individual earnings, 503,139 have positive household earnings, 452,037 have positive weeks worked last year, and 376,503 have positive hours worked last week. Source: 1971--1986 March CPS data.")

   
   
  ****************************TABLE 2**********************************
gen emprate_kid = emp_rate * nchild 
label var emprate_kid  "employment mom (interaction term)"

gen emprate_married = emp_rate * married
label var emprate_married "employment rate × married"
			 

********************************************************************************
* Baseline Logit (1)
********************************************************************************
logit employed mother post1975 i.mom [pw=asecwt], vce(cluster state)

margins, dydx (mom) post

eststo col1, title("Baseline (Logit)")


********************************************************************************
* Baseline Probit (2)
********************************************************************************
probit employed mother post1975 i.mom [pw=asecwt], vce(cluster state)

margins, dydx (mom) post

eststo col2, title("Baseline (Probit)")


********************************************************************************
* Baseline OLS (3)
********************************************************************************
reg employed mother post1975 i.mom [pw=asecwt], vce(cluster state)

eststo col3, title("Baseline (OLS)")


********************************************************************************
*  State and Year Fixed Effects LOGIT (4)
********************************************************************************

logit employed mother post1975 i.mom i.state i.workyear [pw=asecwt], vce(cluster state)


margins, dydx (mom) post

eststo col4, title("State-Year FE (Logit)")




********************************************************************************
*  State and Year Fixed Effects PROBIT (5)
********************************************************************************


probit employed mother post1975 i.mom i.state i.workyear [pw=asecwt], vce(cluster state)


margins, dydx (mom) post

eststo col5, title("State-Year FE (Probit)")


********************************************************************************
*   State and Year Fixed Effects OLS (6)
********************************************************************************


reg employed mother post1975 i.mom i.state i.workyear [pw=asecwt], vce(cluster state)




eststo col6, title("State-Year FE (OLS)")



margins, dydx(mom)post 

eststo col9, title("OLS  + Demographic Controls") 




* Add indicator flags for each regression type
estadd local Method "LOGIT"   : col1
estadd local Method "PROBIT"   : col2
estadd local Method "OLS"   : col3
estadd local Method "LOGIT"   : col4
estadd local Method "PROBIT"  : col5
estadd local Method "OLS"     : col6


* Add indicator flags for each regression
estadd local FE  ""   : col1
estadd local FE  "": col2
estadd local FE  "": col3
estadd local FE  "Yes": col4
estadd local FE  "Yes": col5
estadd local FE  "Yes": col6





 ****************************************************
* Table 2. The 1975 EITC Increased Maternal Employment
****************************************************


esttab col1 col2 col3 col4 col5 col6 ///
, keep(1.mom) ///
      coeflabels(1.mom "Mom × Post1975") ///
      cells("b(fmt(3))" "se(par fmt(3))") ///
      nostar ///
      stats(Method N FE, fmt(%9s %9.0f %9s %9s) ///
            labels("Method" "Observations" ///
                   "State & year FE")) ///
      label noconstant nobase compress nogap nonum ///
      collabels(none) ///
      mtitles("(1)" "(2)" "(3)" "(4)" "(5)" "(6)") ///
      addnotes("Sample includes all women ages 18–50. The dependent variable is binary employment, defined as having positive annual earnings. All regressions use CPS ASEC sample weights. Reported coefficients from logit and probit models are average marginal effects. Standard errors are robust to heteroskedasticity and clustered at the state level. Baseline specifications include mother, post-1975, and their interaction. Fixed-effects models additionally include state and year fixed effects. No demographic or unemployment controls are included in this table.Source: 1971-1986 March CPS data.")






*Latex


esttab col1 col2 col3 col4 col5 col6 ///
using "table2_PART1.tex", replace ///
keep(1.mom) ///
      coeflabels(1.mom "Mom × Post1975") ///
      cells("b(fmt(3))" "se(par fmt(3))") ///
      nostar ///
      stats(Method N FE, fmt(%9s %9.0f %9s %9s) ///
            labels("Method" "Observations" ///
                   "State & year FE")) ///
      label noconstant nobase compress nogap nonum ///
      collabels(none) ///
      mtitles("(1)" "(2)" "(3)" "(4)" "(5)" "(6)") ///
      addnotes("Sample includes all women ages 18–50. The dependent variable is binary employment, defined as having positive annual earnings. All regressions use CPS ASEC sample weights. Reported coefficients from logit and probit models are average marginal effects. Standard errors are robust to heteroskedasticity and clustered at the state level. Baseline specifications include mother, post-1975, and their interaction. Fixed-effects models additionally include state and year fixed effects. No demographic or unemployment controls are included in this table.Source: 1971-1986 March CPS data.")

	
	
//	
// *Docs
// esttab colA colB colC colD colE colF using table2.rtf, replace ///
// keep(1.mom) ///
//       coeflabels(1.mom "Mom × Post1975") ///
//       cells("b(fmt(3))" "se(par fmt(3))") ///
//       nostar ///
//       stats(Method N FE, fmt(%9s %9.0f %9s %9s) ///
//             labels("Method" "Observations" ///
//                    "State & year FE")) ///
//       label noconstant nobase compress nogap nonum ///
//       collabels(none) ///
//       mtitles("(1)" "(2)" "(3)" "(4)" "(5)" "(6)") ///
//       addnotes("Sample includes all women ages 18–50. The dependent variable is binary employment, defined as having positive annual earnings. All regressions use CPS ASEC sample weights. Reported coefficients from logit and probit models are average marginal effects. Standard errors are robust to heteroskedasticity and clustered at the state level. Baseline specifications include mother, post-1975, and their interaction. Fixed-effects models additionally include state and year fixed effects. No demographic or unemployment controls are included in this table.Source: 1971-1986 March CPS data.")
		 


		 
********************************************************************************
* Demographic controls LOGIT (1)
********************************************************************************
logit employed  mother i.mom post1975  i.state i.workyear married incwelfr  nchild under5 nonwhite age age2 age3 educ_yrs educ_yrs2 nonwhite_mom  nonwhite_post mom_age married_post[pw=asecwt], vce(cluster state)


margins, dydx(mom)post 

eststo colA, title("Logit + Demographic Controls") 


********************************************************************************
* Demographic controls LOGIT (2)
********************************************************************************
probit employed  mother i.mom post1975  i.state i.workyear married incwelfr  nchild under5 nonwhite age age2 age3 educ_yrs educ_yrs2 nonwhite_mom  nonwhite_post mom_age married_post[pw=asecwt], vce(cluster state)


margins, dydx(mom)post 

eststo colB, title("Probit  + Demographic Controls") 

********************************************************************************
* Demographic controls OLS (3)
********************************************************************************
reg employed  mother i.mom post1975  i.state i.workyear married incwelfr  nchild under5 nonwhite age age2 age3 educ_yrs educ_yrs2 nonwhite_mom  nonwhite_post mom_age married_post[pw=asecwt], vce(cluster state)

eststo colC, title("Probit  + Demographic Controls") 
********************************************************************************
* Unemployment rate includes state-year employment-to-population ratios and interactions with kid and married.// (LOGIT) (4)
********************************************************************************

logit employed mother i.mom post1975  married i.state i.workyear  incwelfr  nchild under5 nonwhite age age2 age3 educ_yrs educ_yrs2 nonwhite_mom  nonwhite_post mom_age married_post emp_rate  emprate_married  emprate_kid [pw=asecwt], vce(cluster state)

margins, dydx(mom)post 

eststo colD, title("Logit + Unemployment")






********************************************************************************
*employment rate includes state-year employment-to-population ratios and interactions with kid and married./// (PROBIT) (5)
********************************************************************************

probit employed mother i.mom post1975  married i.state i.workyear incwelfr  nchild under5 nonwhite age age2 age3 educ_yrs educ_yrs2 nonwhite_mom  nonwhite_post mom_age married_post emp_rate  emprate_married  emprate_kid [pw=asecwt], vce(cluster state)

margins, dydx(mom)post 

eststo colE, title("Probit + Unemployment")


********************************************************************************
*employment rate includes state-year employment-to-population ratios and interactions with kid and married./// (OLS) (6)
********************************************************************************

reg employed mother i.mom post1975  married i.state i.workyear incwelfr  nchild under5 nonwhite age age2 age3 educ_yrs educ_yrs2 nonwhite_mom  nonwhite_post mom_age married_post emp_rate  emprate_married  emprate_kid [pw=asecwt], vce(cluster state)

eststo colF, title("OLS + Unemployment")

********************************************************************************
* column 7: "Kitchen-sink": Logit (7)
********************************************************************************

reg employed  mother i.mom post1975  i.state i.year married incwelfr nchild under5 nonwhite age age2 age3 educ_yrs educ_yrs2 nonwhite_mom  nonwhite_post mom_age married_post emp_rate  emprate_married  emprate_kid nonwhite_incwelfr nonwhite_married nchild_married under5_married married_incwelfr eduyrs_married educyrs_under5 educyrs_nonwhite nonwhite_age  nonwhite_age3 state_year state_under5  stateyr_nonwhite stateyr_married [pw=asecwt], vce(cluster state)
   ///

margins, dydx(mom)post 

eststo colG, title("Logit + KITCHEN SINK")








* Add indicator flags for each regression type
estadd local Method "LOGIT"   : colA
estadd local Method "PROBIT"   : colB
estadd local Method "OLS"   : colC
estadd local Method "LOGIT"   : colD
estadd local Method "PROBIT"  : colE
estadd local Method "OLS"     : colF




* Add indicator flags for each regression
estadd local FE  "Yes"   : colA
estadd local FE  "Yes": colB
estadd local FE  "Yes": colC
estadd local FE  "Yes": colD
estadd local FE  "Yes": colE
estadd local FE  "Yes": colF
estadd local FE  "Yes": colG


estadd local DEM "YES"   : colA
estadd local DEM "YES"   : colB
estadd local DEM "Yes": colC
estadd local DEM "Yes": colD
estadd local DEM "Yes": colE
estadd local DEM "Yes": colF




estadd local UN  ""   : colA
estadd local UN  ""   : colB
estadd local UN  ""   : colC
estadd local UN  "Yes"   : colD
estadd local UN  "Yes"   : colE
estadd local UN  "Yes"   : colF







  ****************************************************
* Table 2. The 1975 EITC Increased Maternal Employment
*******************************************************



esttab colA colB colC colD colE colF  ///
, keep(1.mom) ///
  coeflabels(1.mom "Mom × Post1975") ///
  cells("b(fmt(3))" "se(par fmt(3))") ///
  nostar ///
  stats(Method N FE DEM UN, fmt(%9s %9.0f %9s %9s %9s) ///
        labels("Method" "Observations" ///
               "State & year FE"  "Demographics"  " Employment")) ///
  label noconstant nobase compress nogap nonum ///
  collabels(none) ///
  mtitles("(1)" "(2)" "(3)" "(4)" "(5)" "(6)") ///
 addnotes("Sample includes all women ages 18-50. The dependent variable is binary employment, defined as having positive annual earnings. All regressions use CPS ASEC sample weights. Reported coefficients from logit and probit models are average marginal effects. Standard errors are robust to heteroskedasticity and clustered at the state level. Demographic controls include marital status, welfare income, number of children, an indicator for a child under age 5, nonwhite status, cubic age controls, quadratic education controls, and interactions of nonwhite x mother, nonwhite x post-1975, mother x age, and married x post-1975. Unemployment specifications additionally include the state-year employment-to-population ratio and its interactions with marital status and number of children.Source: 1971-1986 March CPS data.")









esttab colA colB colC colD colE colF  ///
using "table2_PART2.tex", replace ///
keep(1.mom) ///
  coeflabels(1.mom "Mom × Post1975") ///
  cells("b(fmt(3))" "se(par fmt(3))") ///
  nostar ///
  stats(Method N FE DEM UN, fmt(%9s %9.0f %9s %9s %9s) ///
        labels("Method" "Observations" ///
               "State & year FE"  "Demographics"  " Unemployment")) ///
  label noconstant nobase compress nogap nonum ///
  collabels(none) ///
  mtitles("(1)" "(2)" "(3)" "(4)" "(5)" "(6)") ///
 addnotes("Sample includes all women ages 18-50. The dependent variable is binary employment, defined as having positive annual earnings. All regressions use CPS ASEC sample weights. Reported coefficients from logit and probit models are average marginal effects. Standard errors are robust to heteroskedasticity and clustered at the state level. Demographic controls include marital status, welfare income, number of children, an indicator for a child under age 5, nonwhite status, cubic age controls, quadratic education controls, and interactions of nonwhite x mother, nonwhite x post-1975, mother x age, and married x post-1975. Unemployment specifications additionally include the state-year employment-to-population ratio and its interactions with marital status and number of children. Source: 1971--1986 March CPS data.")


 



***************************************************************
 *Mothers with 1 child vs Non-mothers
***************************************************************

gen mom1 = .
replace mom1 = 1 if mother==1 & nchild==1 
replace mom1 = 0 if mother==0
label var mom1 "Mother with 1 Child vs Non-Mothers"




// reg employed ///
//     i.workyear##i.mom1 ///
//     i.state i.workyear ///
//     married incwelfr nchild under5 nonwhite ///
//     age age2 age3 educ_yrs educ_yrs2 ///
//     nonwhite_mom nonwhite_post mom_age married_post ///
//     emprate_married emprate_kid emp_rate ///
//     [pw=asecwt], vce(cluster state)
//
//	
//	
	
	
reg employed ///
  i(1970/1974 1976/1985)workyear#1.mom1 ///
    i.state i.workyear ///
    married incwelfr nchild under5 nonwhite ///
    age age2 age3 educ_yrs educ_yrs2 ///
    nonwhite_mom nonwhite_post mom_age married_post ///
    emprate_married emprate_kid emp_rate ///
    [pw=asecwt], vce(cluster state)


	
 	

margins r.mom1, contrast over(workyear)


marginsplot, ///
   title("EITC Impact: 1-Child Mothers vs Non-Mothers") ///
    xtitle("Year") ///
    ytitle("Difference in Predicted Employment") ///
    xline(1975, lcolor(red) lpattern(dash)) ///
    legend(off)

	graph export "1kidvsnokid.pdf", replace
	
	
	
	test ///
  1970.workyear#1.mom1 = ///
  1971.workyear#1.mom1 = ///
  1972.workyear#1.mom1 = ///
  1973.workyear#1.mom1 = ///
  1974.workyear#1.mom1
	
	

	

***************************************************************
 *Mothers with 2 child vs Non-mothers
***************************************************************	
	
gen mom2 = .
replace mom2 = 1 if mother==1 & nchild>1
replace mom2 = 0 if mother==0
label var mom2 "Mother with 2+ Children vs Non-Mothers"

gen mom2_post = mom2 * post1975
label var mom2_post "Mom2 × Post-1975"

reg employed ///
  i(1970/1974 1976/1985)workyear#1.mom2 ///
    i.state i.workyear ///
    married incwelfr nchild under5 nonwhite ///
    age age2 age3 educ_yrs educ_yrs2 ///
    nonwhite_mom nonwhite_post mom_age married_post ///
    emprate_married emprate_kid emp_rate ///
    [pw=asecwt], vce(cluster state)


margins r.mom2, contrast over(workyear)


marginsplot, ///
    title("Employment Difference: Mother with 2+ Children vs Non-Mothers") ///
    xtitle("Year") ///
    ytitle("Difference in Predicted Employment") ///
    xline(1975, lcolor(red) lpattern(dash)) ///
    legend(off)
	
	
	
graph export "2kidvsnokid.pdf", replace



	test ///
  1970.workyear#1.mom2 = ///
  1971.workyear#1.mom2 = ///
  1972.workyear#1.mom2 = ///
  1973.workyear#1.mom2 = ///
  1974.workyear#1.mom2
	
	

	

