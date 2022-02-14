import numpy as np
import pandas as pd
from rdrobust import rdrobust,rdbwselect,rdplot
import pandas as pd

np.random.seed(123456) # set seeds
num = 1000 # number of observation

X = np.random.normal(0,0.01,size = num)
U = np.random.normal(0,0.001,size = num) 

tau = 0.5

beta10 = 0.4
beta11 = 0.7
beta12 = 7.4
beta13 = 20
beta14 = 22
beta15 = 6

beta20 = 0.5
beta21 = 0.7+tau
beta22 = -2.7
beta23 = 8.2
beta24 = -9.5
beta25 = 4

df = pd.DataFrame({'X' : X})

df.loc[df['X'] < 0, 'Y'] = beta10 + beta11*df['X'] + beta12*df['X']**2 + beta13*df['X']**3 + beta14*df['X']**4 + beta15*df['X']**5
df.loc[df['X'] >= 0, 'Y'] = beta20 + beta21*df['X'] + beta22*df['X']**2 + beta23*df['X']**3 + beta24*df['X']**4 + beta25*df['X']**5

# Define the variblrs
margin = df.X
outcome = df.Y

### rdplot with MSE-optimal choice
rdplot(y=outcome, x=margin, binselect="es", 
       title="RD Robust With Simulated Data", 
       y_label="Outcome",
       x_label="Running Variable")

### rdrobust 
print(rdrobust(y=outcome, x=margin))





