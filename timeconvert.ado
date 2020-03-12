/*==================================================
project:       convert time to different timezones
Author:        R.Andres Castaneda 
E-email:       acastanedaa@worldbank.org
url:           
Dependencies:  The World Bank
----------------------------------------------------
Creation Date:    12 Mar 2020 - 18:12:15
Modification Date:   
Do-file version:    01
References:          
Output:             
==================================================*/

/*==================================================
              0: Program set up
==================================================*/
program define timeconvert, rclass
syntax [anything], [       ///
target(numlist)        ///
]
version 15

*##s
if ("`target'" == "") local target 0

/*=================================================
1:  get time 
==================================================*/

*----------1.1: from timeanddate.com
local page "https://www.timeanddate.com/worldclock/uk/london"
scalar page = fileread(`"`page'"')


if regexm(page, ".*(<span id=ct class=h1>)([0-9:apm ]+)(</span>)") local time = regexs(2) 
if regexm(page, ".*(<span id=ctdat>[A-Za-z]+), ([A-Za-z0-9 ]+, [0-9]+)(</span>)") local date = regexs(2) 

local ref_datetime "`date'`time'"

*----------1.2: from local 
local loc_datetine "`c(current_date)'`c(current_time)'"

/*==================================================
2:  det diff
==================================================*/

local ref_srf = clock("`date'`time'", "MDYhms")
local loc_srf = clock("`c(current_date)'`c(current_time)'", "DMYhms")

local diffdt   = `loc_srf'- `ref_srf' 
local loczone  = round(`diffdt'/(60*60*1000))

local adj = `target' - `loczone'

local new_srf = `loc_srf'+`adj'*60*60*1000

local new_hrf: disp %tcDDmonCCYY_HH:MM:SS `new_srf'
local ref_hrf: disp %tcDDmonCCYY_HH:MM:SS `ref_srf'
local loc_hrf: disp %tcDDmonCCYY_HH:MM:SS `loc_srf'

//========================================================
//  Display results
//========================================================

disp  as text _col(3) "  Zone Time " _col(18) as input "{c |}" _col(21) as text "Date-time" _n /* 
 */ as input _col(3) "{hline 15}{c +}{hline 20}"  _n /* 
 */ as text  _col(3) "London zone"  _col(18) as input "{c |}" _col(21) as text "`ref_hrf'" _n /* 
 */ as text  _col(3) "Local  zone"  _col(18) as input "{c |}" _col(21) as text "`loc_hrf'" _n /* 
 */ as text  _col(3) "Target zone"  _col(18) as input "{c |}" _col(21) as text "`new_hrf'" _n /* 
 */ as input _col(3) "{hline 15}{c BT}{hline 20}" 

//========================================================
// Return results
//========================================================


return local ref_hrf = "`ref_hrf'"
return local loc_hrf = "`loc_hrf'"
return local new_hrf = "`new_hrf'"
return local ref_srf = `ref_srf'
return local loc_srf = `loc_srf'
return local new_srf = `new_srf'
return local loczone =  `loczone'



*##e


*----------2.1:


*----------2.2:





end
exit
/* End of do-file */

><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><

Notes:
1.
2.
3.


Version Control:


