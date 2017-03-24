#!/usr/bin/env python3

import sys
from os import path


day_of_week = str(sys.argv[1])
day_of_month = str(sys.argv[2])
month = str(sys.argv[3])
carrier = str(sys.argv[4])
origin = str(sys.argv[5])
destination = str(sys.argv[6])
departure_time = str(sys.argv[7])

from sklearn.externals import joblib
import os
import pandas as pd


with open("final_model.pkl", "rb") as fo:
    loaded_model_clf = joblib.load(fo)


test_df = pd.DataFrame({'DayOfWeek': [day_of_week],
                                'DayofMonth': [day_of_month],
                                'Month':[month],
                                'AirlineID':[carrier],
                                'OriginAirportID':[origin],
                                'DestAirportID':[destination],
                                'CRSDepHH':[departure_time]})
forecast = loaded_model_clf.predict(test_df)


if forecast == ['Delay']:
    print("0")
elif forecast == ['No Delay']:
    print("1")
elif forecast == ['Severe Delay']:
    print("3")
elif forecast == ['Significant Delay']:
    print("4")
elif forecast == ['Minor Delay']:
    print("5")





