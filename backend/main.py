import flask
from sklearn.metrics import accuracy_score
from sklearn.impute import SimpleImputer
from sklearn.preprocessing import LabelEncoder
from sklearn.preprocessing import StandardScaler
from sklearn.model_selection import train_test_split
import numpy as np # linear algebra
import pandas as pd # data processing, CSV file I/O (e.g. pd.read_csv)
import plotly.express as px
import matplotlib
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.ensemble import RandomForestClassifier


#flask
app = flask.Flask(__name__)
app.config["DEBUG"] = True

#import dataset
df_raw = pd.read_csv('backend/weatherAUS.csv')
df = df_raw

#Dataset
x=df.iloc[:,[1,2,3,4,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21]].values
y=df.iloc[:,-1].values.reshape(-1,1) #slicing genrates new list

#dealing with invalid dataset
imputer=SimpleImputer(missing_values=np.nan,strategy='most_frequent')
x=imputer.fit_transform(x)
y=imputer.fit_transform(y)

#Label Encoding
le1=LabelEncoder()
x[:,0]=le1.fit_transform(x[:,0])
le2=LabelEncoder()
x[:,4]=le2.fit_transform(x[:,4])
le3=LabelEncoder()
x[:,6]=le3.fit_transform(x[:,6])
le4=LabelEncoder()
x[:,7]=le4.fit_transform(x[:,7])
le5=LabelEncoder()
x[:,-1]=le5.fit_transform(x[:,-1])
le6=LabelEncoder()
y=le6.fit_transform(y)

#Feature Scaling
sc=StandardScaler()
x=sc.fit_transform(x)

#Split Dataset
x_train,x_test,y_train,y_test=train_test_split(x,y,test_size=0.2,random_state=0)

# Just for testing :)
@app.route('/hello', methods=['GET'])
def hello_world():
    return "Hello World"

@app.route('/randomForest', methods=['GET'])
def train_random_forest():
    classifier=RandomForestClassifier(n_estimators=200,random_state=0)
    classifier.fit(x_train,y_train)
    classifier.score(x_train,y_train)
    y_pred=classifier.predict(x_test)
    accuracy=accuracy_score(y_test,y_pred)
    dict_a={"accuracy":str(accuracy)}
    return dict_a


#handle all exceptions
@app.errorhandler(Exception)
def all_exception_handler(error):
    return 'Internal Error', 500

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=8080)