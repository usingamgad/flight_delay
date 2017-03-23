#!/usr/bin/env python3

#import speech_recognition as sr
import sys
#import reload
# obtain path to "english.wav" in the same folder as this script
from os import path
#reload(sys)
#sys.setdefaultencoding('utf-8')

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
#loaded_model_clf = joblib.load(open(path.join(path.dirname(path.realpath(__file__)), filename_predictor)))
loaded_model_clf = joblib.load('/Users/mo186022/Github/Bootcamp/flight_delay/final_model.pkl')
test_df = pd.DataFrame({'DayOfWeek': [day_of_week],
                                'DayofMonth': [day_of_month],
                                'Month':[month],
                                'AirlineID':[carrier],
                                'OriginAirportID':[origin],
                                'DestAirportID':[destination],
                                'CRSDepHH':[departure_time]})
forecast = loaded_model_clf.predict(test_df)


if forecast == ['Delay']:
    print("The flight is likely to be delayed (up tp 1 hour)")
elif forecast == ['No Delay']:
    print("The flight is likely to depart on time")
elif forecast == ['Severe Delay']:
    print("The flight is likely to be severely delayed (more than 2 hours)")
elif forecast == ['Significant Delay']:
    print("The flight is likely to be significantly delayed (up to 2 hours")
elif forecast == ['Minor Delay']:
    print("The flight is likely to be slightly delayed (up to 30 minutes)")





