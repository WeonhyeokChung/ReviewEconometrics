import numpy as np
import pandas as pd
import statsmodels.formula.api as sm

np.random.seed(123456) # set seeds
num = 1000 # number of observation

X1 = np.random.normal(size = num)
X2 = np.random.normal(size = num)

Y = 3*X1 + 4*X2 + np.random.normal(size = num)

data = pd.DataFrame({'X1' : X1, 'X2' : X2, 'Y' : Y})

# Multiple Regression-----------------------
multiple_model = sm.ols('Y ~ X1 + X2', data).fit()

# FWL---------------------------------------
# first step(X2 -> X1)
step1_model = sm.ols('X1 ~ X2', data).fit()
# second step(X2 -> Y)
step2_model = sm.ols('Y ~ X2', data).fit()

# residualize
X1_hat = step1_model.predict()
data['X1_res'] =  X1_hat-X1

Y_hat = step2_model.predict()
data['Y_res'] =  Y_hat-Y

# run regression
fwl_model = sm.ols('Y_res ~ X1_res', data).fit()

# Compare FWL & Multiple Regression---------
print(fwl_model.summary().tables[1])
print(multiple_model.summary().tables[1])
