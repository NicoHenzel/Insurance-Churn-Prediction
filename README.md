# Insurance-Churn-Prediction
Project for insurance churn prediction with xgboost classification algorithm

This project was created in April of 2022 as part of the "Programming Languages" module.
This module is part of the masters course "Data Science" at the HdM university in Stuttgart, Germany.

* Goal  

The goal for this project is to train a machine learning algorithm with anonymized insurance contract data in order to predict the insurance customer churn rate (whether the insurance company will lose a customer or not).
A potential use case where these insights could be applied is:
Any insurance company wants to improve (or at least not decrease) their customer loyalty.
If the insurance case handlers could understand why a customer quits a contract and more importantly if a customer is close to quitting an ongoing contract, they could start countermeasures in order to improve customer service and maybe keep the customer.
This information can easily be provided through a dashboard, or implemented into existing applications for viewing contracts, by marking potential customers and contracts which are likely to be quit.

* Model and code  

The R code for the model is found in the *Insurance-Churn-Prediction.Rproj*
The report is an html file named *Insurance-Churn-Prediction.html*
The XGBoost Classification algorithm was choosen to make the predictions.
At the time of writing this readme, the XGBoost algorithm is one of the best machine learning algorithms for classification (and regression) models.
Quoted from the official XGBoost Documentation:
"XGBoost is an optimized distributed gradient boosting library designed to be highly efficient, flexible and portable. It implements machine learning algorithms under the Gradient Boosting framework. XGBoost provides a parallel tree boosting (also known as GBDT, GBM) that solve many data science problems in a fast and accurate way." (see https://xgboost.readthedocs.io/en/stable/, last visited: 2022-04-25 18:38)

* Dashboard  

A Mockup for a dashboard can be found in the *Dashboard* folder. It is modeled using R shiny.

* Data  

The data is found in the *data* folder.
Since this is a public project, the data used for it is also publicly available.
It was taken from the Insurance Churn Prediction: Weekend Hackathon from kaggle (see: https://www.kaggle.com/datasets/k123vinod/insurance-churn-prediction-weekend-hackathon, last visited: 2022-04-25 18:46)
The Hackathon was originally hosted by Machine Hack in 2020 (https://www.machinehack.com/course/insurance-churn-prediction-weekend-hackathon-2/), this Website is not reachable anylonger, thus the data was downloaded from kaggle.