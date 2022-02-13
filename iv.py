import numpy as np
import pandas as pd
import statsmodels.formula.api as sm

np.random.seed(123456) # set seeds
num = 1000 # number of observation

X = np.random.normal(3,1,size = num)
Z = np.random.normal(2,1,size = num)


mean = [0,0]
cov = [[1,0.8],[0.8,1]]
U, V = np.random.multivariate_normal(mean, cov, num).T

T = 1*Z+U 
Y = 1/2*T + X + V 
# T is correlated with U AND since U and V are correlated, T is correlated with V
# Z is correlated with T but, uncorrelated with U

data = pd.DataFrame({'X' : X, 'Z' : Z, 'T' : T, 'U' : U, 'V' : V})

# regression without iv
noiv_model = sm.ols('Y ~ T + X', data).fit()
print(noiv_model.summary().tables[1])

# IV
# first step
step1_model = sm.ols('T ~ Z', data).fit()
T_hat = step1_model.predict()
data['T_hat'] =  T_hat

iv_model = sm.ols('Y ~ T_hat + X', data).fit()
print(iv_model.summary().tables[1])
