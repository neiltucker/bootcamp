# This script will create a "Customer Table" dataset and export up to 1 million rows to a CSV file.
# Change the rows variable to control the number of rows exported.
# pip install --upgrade pandas, pandas_datareader, scipy, matplotlib, pyodbc, pycountry, azure
# pip freeze > requirements

### This looping operation will install the modules not already configured.
import importlib, os, sys
packages = ['numpy', 'pandas','faker']
for package in packages:
  try:
    module = importlib.__import__(package)
    globals()[package] = module
  except ImportError:
    cmd = 'pip install --user ' + package
    os.system(cmd)
    module = importlib.__import__(package)

rows = 1000
import random, decimal, string, csv, datetime, numpy as np, pandas as pd
from faker import Faker
fake=Faker()

customerid = np.array([''.join(random.choice(string.ascii_uppercase) for _ in range(2)) + ''.join(random.choice(string.digits) for _ in range(2)) for _ in range(rows)])
firstname = np.array([''.join(fake.first_name()) for _ in range(rows)])
lastname = np.array([''.join(fake.last_name()) for _ in range(rows)])
i = 0
email = []
while i < rows:
  email.append(lastname[i] + "." + firstname[i] + "@datacompany.com")
  i += 1

i = 0
companyname = []
while i < rows:
  companyname.append(firstname[i][0] + lastname[i] + " LLC")
  i += 1

phone = np.array([''.join(fake.phone_number()) for _ in range(rows)])
street = np.array([''.join(fake.street_address()) for _ in range(rows)])
city = np.array([''.join(fake.city()) for _ in range(rows)])
state = np.array([''.join(fake.state()) for _ in range(rows)])
zipcode = np.array([''.join(fake.zipcode()) for _ in range(rows)])
customerdata = zip(customerid,companyname,firstname,lastname,email,phone,street,city,state,zipcode)
customerdata1 = list(zip(customerid,companyname,firstname,lastname,email,phone,street,city,state,zipcode))
df = pd.DataFrame(customerdata1)
df.to_csv('projectdata_customers.csv',index=False,header=["CustomerID","CompanyName","FirstName","LastName","Email","Phone","Street","City","State","ZIP"])


