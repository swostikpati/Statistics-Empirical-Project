clear
clear matrix
capture log close 

cd "C:\Users\Swostik Pati\OneDrive - nyu.edu\Documents\FALL 2021 - NYUAD\Stats\Term Project2"

log using "log4.txt", text append

import excel "C:\Users\Swostik Pati\OneDrive - nyu.edu\Documents\FALL 2021 - NYUAD\Stats\Term Project2\Data", sheet("Data") firstrow

rename Laborforceparticipationrate LFPR
rename GDPpercapitaPPPconstant20 GDP
rename PopulationtotalSPPOPTOTL Population

save "FileData.dta"

use FileData.dta

summarize GDP, detail
summarize LFPR, detail
hist GDP
tab CountryName if GDP > 70000 & GDP <.
tab Time if GDP != . & LFPR 
keep if Time == 2016

gen lGDP = log(GDP)
summarize lGDP, detail
corr GDP LFPR
corr lGDP LFPR
corr GDP LFPR [aw = Population]
corr lGDP LFPR [aw = Population]

regress GDP LFPR 
regress lGDP LFPR
regress GDP LFPR [aw = Population]
regress lGDP LFPR [aw = Population]

egen group_pop=cut(Population), group(4)

bysort group_pop: sum Population
hist Population if group_pop == 3
corr GDP LFPR [aw = Population] if group_pop == 0
corr GDP LFPR [aw = Population] if group_pop == 1
corr GDP LFPR [aw = Population] if group_pop == 2
corr GDP LFPR [aw = Population] if group_pop == 3

corr lGDP LFPR [aw = Population] if group_pop == 0
corr lGDP LFPR [aw = Population] if group_pop == 1
corr lGDP LFPR [aw = Population] if group_pop == 2
corr lGDP LFPR [aw = Population] if group_pop == 3

regress GDP LFPR if group_pop ==0
regress GDP LFPR if group_pop ==1
regress GDP LFPR if group_pop ==2
regress GDP LFPR if group_pop ==3

regress lGDP LFPR if group_pop ==0
regress lGDP LFPR if group_pop ==1
regress lGDP LFPR if group_pop ==2
regress lGDP LFPR if group_pop ==3

tw scatter GDP LFPR || lfit GDP LFPR
graph save "Graph" "GDP_LFPR"

tw scatter lGDP LFPR || lfit lGDP LFPR
graph save "Graph" "lGDP_LFPR"

tw scatter GDP LFPR [aw = Population] || lfit GDP LFPR [aw = Population]
graph save "Graph" "awGDP_LFPR" 

tw scatter lGDP LFPR [aw = Population] || lfit lGDP LFPR [aw = Population]
graph save "Graph" "awlGDP_LFPR"

tw scatter GDP LFPR if group_pop ==0 || lfit GDP LFPR if group_pop ==0
graph save "Graph" "GDP_LFPR0"

tw scatter GDP LFPR if group_pop ==1 || lfit GDP LFPR if group_pop ==1
graph save "Graph" "GDP_LFPR1"

tw scatter GDP LFPR if group_pop ==2 || lfit GDP LFPR if group_pop ==2
graph save "Graph" "GDP_LFPR2"

tw scatter GDP LFPR if group_pop ==3 || lfit GDP LFPR if group_pop ==3
graph save "Graph" "GDP_LFPR3"

tw scatter lGDP LFPR if group_pop ==0 || lfit lGDP LFPR if group_pop ==0
graph save "Graph" "lGDP_LFPR0"

tw scatter lGDP LFPR if group_pop ==1 || lfit lGDP LFPR if group_pop ==1
graph save "Graph" "lGDP_LFPR1"

tw scatter lGDP LFPR if group_pop ==2 || lfit lGDP LFPR if group_pop ==2
graph save "Graph" "lGDP_LFPR2"

tw scatter lGDP LFPR if group_pop ==3 || lfit lGDP LFPR if group_pop ==3
graph save "Graph" "lGDP_LFPR3"

//weighting analytically
regress GDP LFPR if group_pop ==0 [aw= Population] 
regress GDP LFPR if group_pop ==1 [aw= Population] 
regress GDP LFPR if group_pop ==2 [aw= Population] 
regress GDP LFPR if group_pop ==3 [aw= Population]

regress lGDP LFPR if group_pop ==0 [aw= Population]
regress lGDP LFPR if group_pop ==1 [aw= Population]
regress lGDP LFPR if group_pop ==2 [aw= Population]
regress lGDP LFPR if group_pop ==3 [aw= Population]

tw scatter GDP LFPR if group_pop ==0 [aw= Population]|| lfit GDP LFPR if group_pop ==0 [aw= Population]
graph save "Graph" "awGDP_LFPR0"

tw scatter GDP LFPR if group_pop ==1 [aw= Population]|| lfit GDP LFPR if group_pop ==1 [aw= Population]
graph save "Graph" "awGDP_LFPR1"

tw scatter GDP LFPR if group_pop ==2 [aw= Population] || lfit GDP LFPR if group_pop ==2 [aw= Population]
graph save "Graph" "awGDP_LFPR2"

tw scatter GDP LFPR if group_pop ==3 [aw= Population]|| lfit GDP LFPR if group_pop ==3 [aw= Population]
graph save "Graph" "awGDP_LFPR3"

tw scatter lGDP LFPR if group_pop ==0 [aw= Population]|| lfit lGDP LFPR if group_pop ==0 [aw= Population]
graph save "Graph" "awlGDP_LFPR0"

tw scatter lGDP LFPR if group_pop ==1 [aw= Population]|| lfit lGDP LFPR if group_pop ==1 [aw= Population]
graph save "Graph" "awlGDP_LFPR1"

tw scatter lGDP LFPR if group_pop ==2 [aw= Population]|| lfit lGDP LFPR if group_pop ==2 [aw= Population]
graph save "Graph" "awlGDP_LFPR2"

tw scatter lGDP LFPR if group_pop ==3 [aw= Population]|| lfit lGDP LFPR if group_pop ==3 [aw= Population]
graph save "Graph" "awlGDP_LFPR3"

twoway (scatter GDP LFPR [aw= Population]) (lfit GDP LFPR [aw= Population])  (lfit GDP LFPR) ,  legend(order(1 "Scatterplot GDP LFPR" 2 "Regression Line Weighted" 3 "Regression Line- Non Weighted") cols(3))  xtitle(Labour Force Participation Rate Total) ytitle(GDP PPP)

twoway (scatter GDP LFPR [aw= Population]) (lfit GDP LFPR [aw= Population])  (lfit GDP LFPR) ,  legend(order(1 "Scatterplot GDP LFPR" 2 "Regression Line Weighted" 3 "Regression Line- Non Weighted") cols(3))  xtitle(Labour Force Participation Rate Total) ytitle(GDP PPP)

twoway (scatter lGDP LFPR [aw= Population]) (lfit lGDP LFPR [aw= Population])  (lfit lGDP LFPR) ,  legend(order(1 "Scatterplot lGDP LFPR" 2 "Regression Line Weighted" 3 "Regression Line- Non Weighted") cols(3))  xtitle(Labour Force Participation Rate Total) ytitle(GDP PPP %)

log close _all
