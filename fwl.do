********************************************************************************
*
*	Project Name: fwl for STATA
*	Date: Feb 11th 2022
*	
********************************************************************************

cap log close
clear all
set more off 
set maxvar 100000
set matsize 11000

*------------------------------------------------------------------------------*
* 							Prep											   *
*------------------------------------------------------------------------------*

cd "/Users/BrianChung/Dropbox/Github"

log using "./fwl/fwl", replace

set obs 1000
set seed 123456

local beta1 = 3
local beta2 = 4
	
gen x1 = rnormal(5,1)
gen x2 = rnormal(10,2)

gen y = `beta1'*x1 + `beta2'*x2 + rnormal(0,1)
	
*------------------------------------------------------------------------------*	
* 							Analysis										   *
*------------------------------------------------------------------------------*	
	
reg y x1 x2	
	// coefficient for x1 and x2 equal to beta1 and beta2 I defined 
	
reg x1 x2
predict res_x1, res

reg y x2
predict res_y, res

reg res_y res_x1
	
log close	
