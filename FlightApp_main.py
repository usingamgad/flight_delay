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
import nltk
import os
import sys
import pandas as pd

filename_predictor = "final_model.pkl"
#loaded_model_clf = joblib.load(open(path.join(path.dirname(path.realpath(__file__)), "final_model.pkl")))
#loaded_model_clf = joblib.load('/Users/mo186022/Github/Bootcamp/flight_delay/final_model.pkl')


with open(path.join(path.dirname(path.realpath(__file__)), "final_model.pkl"), 'rb') as fo:
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





