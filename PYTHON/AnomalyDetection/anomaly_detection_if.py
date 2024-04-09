# Importing necessary libraries
import numpy as np
import pandas as pd
from sklearn.ensemble import IsolationForest
from sklearn.model_selection import train_test_split
from sklearn.metrics import classification_report

# Load your dataset
data = pd.read_csv('driving_dataset.csv')

# Select relevant features (e.g., speed, acceleration, braking patterns, etc.)
selected_features = ['Speed', 'Acceleration', 'BrakePressure', 'TimeOfDay', 'Location', ...]

# Preprocess the data if necessary (e.g., handle missing values, encode categorical variables)
# Ensure that the dataset contains a column indicating whether each instance is normal or anomalous

# Split the dataset into features and labels
X = data[selected_features]
y = data['Anomaly_Label']  # Assuming 'Anomaly_Label' is the column indicating normal or anomalous instances

# Split the data into training and testing sets
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Train the Isolation Forest model
isolation_forest = IsolationForest(contamination=0.1, random_state=42)  # Adjust contamination as needed
isolation_forest.fit(X_train)

# Predict anomalies on the test set
y_pred = isolation_forest.predict(X_test)

# Convert predictions to binary (1 for normal, -1 for anomaly)
y_pred_binary = np.where(y_pred == 1, 0, 1)

# Evaluate the model
print(classification_report(y_test, y_pred_binary))

# Using the trained model to predict anomalies on new data
# new_data = pd.read_csv('new_data.csv')
# new_X = new_data[selected_features]
# new_y_pred = isolation_forest.predict(new_X)
# new_y_pred_binary = np.where(new_y_pred == 1, 0, 1)
# print(new_y_pred_binary)
