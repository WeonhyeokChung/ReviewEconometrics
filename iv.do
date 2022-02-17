********************************************************************************
*
*	Project Name: IV for STATA
*	Date: Feb 12th 2022
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

log using "./iv/iv", replace

set obs 1000
set seed 123456

local beta1 = 1
local beta2 = 1/2

matrix C = (1, .8 \ .8, 1)

drawnorm u v, means(0,0) cov(C)
gen x = rnormal(3,1)
gen z = rnormal(2,1)
gen t = `beta1'*z + u + rnormal(0,0.1)
gen y = `beta2'*t + x+ v + rnormal(0,0.1)

	
*------------------------------------------------------------------------------*	
* 							Analysis										   *
*------------------------------------------------------------------------------*	

reg y t x
	// omitted variable bias
	
reg t z
predict t_hat

reg y t_hat x 
ivregress 2sls  y x (t=z)

*reg y x v

	
log close	
