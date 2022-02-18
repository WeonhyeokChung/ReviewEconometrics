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

log using "./rd/rd_sharp", replace

set obs 1000
set seed 123456

local tau = 0.5

local beta10 = 0.4
local beta11 = 0.7
local beta12 = 7.4
local beta13 = 20
local beta14 = 22
local beta15 = 6

local beta20 = 0.5
local beta21 = 0.7+`tau'
local beta22 = -2.7
local beta23 = 8.2
local beta24 = -9.5
local beta25 = 4

gen x = rnormal(0,0.01)

gen y = .
replace y = `beta10' + `beta11'*x + `beta12'*x^2 + `beta13'*x^3 + `beta14'*x^4 + `beta15'*x^5 + rnormal(0,0.01) if x < 0
replace y = `beta20' + `beta21'*x + `beta22'*x^2 + `beta23'*x^3 + `beta24'*x^4 + `beta25'*x^5 + rnormal(0,0.01) if x >= 0

di (`beta20' + `beta21'*(0.001) + `beta22'*(0.001)^2 + `beta23'*(0.001)^3 + `beta24'*(0.001)^4 + `beta25'*(0.001)^5 ///
	- (`beta10' + `beta11'*(-0.001) + `beta12'*(-0.001)^2 + `beta13'*(-0.001)^3 + `beta14'*(-.001)^4 + `beta15'*(-0.001)^5   ) ) 

	
*------------------------------------------------------------------------------*	
* 							Analysis										   *
*------------------------------------------------------------------------------*	

reg y x
	
rdrobust y x

rdplot y x, ci(95)
	
log close	
