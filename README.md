# **Wildlife Conservation Score Predictor** 🌱🐾  
### **A Data-Driven Approach to Prioritize Wildlife Conservation Efforts**  

---

## **Table of Contents**  
1. [Introduction](#introduction)  
2. [Features](#features)  
3. [Technologies Used](#technologies-used)  
4. [Dataset Information](#dataset-information)  
5. [Public API Endpoint](#public-api-endpoint)  
6. [Screenshots](#screenshots)  
7. [Demo Links](#demo-links)  
8. [How to Run the Project](#how-to-run-the-project)  
    - [Backend (API)](#backend-api)  
    - [Mobile App](#mobile-app)  
9. [Mission Statement](#mission-statement)  
10. [Challenges and Learnings](#challenges-and-learnings)  

---

## **Introduction**  
Wildlife populations worldwide face increasing threats due to climate change, habitat destruction, and poaching. This project is designed to help conservationists and researchers predict a species' conservation score based on biological features, assisting in prioritizing efforts to protect wildlife.  

The project integrates:  
1. **Machine Learning**: A linear regression model trained on biological features of animal species.  
2. **REST API**: A robust FastAPI backend hosted on Render, exposing prediction endpoints.  
3. **Mobile App**: A Flutter-based application providing an interactive user interface for making predictions.  

---

## **Features**  
### **Core Functionalities**  
- **Dynamic Predictions**: Predict conservation scores based on biological features like Hair, Feathers, Backbone, etc.  
- **Interactive Mobile App**: User-friendly app with dropdowns, text fields, and an image carousel.  
- **Public API**: Accessible endpoints for predictions, compatible with Swagger UI for testing.  

### **Additional Features**  
- **Responsive Design**: Mobile app adapts to various screen sizes.  
- **Error Handling**: Robust validation in both the API and mobile app for better user experience.  
- **Scalability**: Backend hosted on Render for global accessibility.  

---

## **Technologies Used**  
### **Backend**  
- **FastAPI**: To create the REST API for predictions.  
- **Joblib**: For loading the trained linear regression model.  
- **Pandas**: For handling input data transformation.  
- **Render**: Hosting the API for public access.  

### **Mobile App**  
- **Flutter**: For cross-platform mobile application development.  
- **Dart**: Language used for Flutter development.  
- **FontAwesome Icons**: For enhanced UI elements.  

### **Machine Learning**  
- **Algorithm**: Linear Regression, chosen for its interpretability and suitability for numeric predictions.  
- **Features**: Focused on biological traits of animals such as Hair, Feathers, and Backbone.  

---

## **Dataset Information**  
The dataset used for model training was sourced from the **[Kaggle Zoo Animal Classification Dataset](https://www.kaggle.com/code/krishnabhatt4/zoo-animal-classification/input?select=zoo.csv)**.  

### **Key Features**  
1. **Hair**: Presence of hair (1 = Yes, 0 = No).  
2. **Feathers**: Presence of feathers (1 = Yes, 0 = No).  
3. **Backbone**: Presence of a backbone (1 = Yes, 0 = No).  
4. **Fins**: Presence of fins (1 = Yes, 0 = No).  
5. **Class_Type**: Type of class (e.g., Mammal, Bird, etc.).  
6. **Animal Names**: Specific species such as Clam, Slug, Worm, etc.  

**Note**: Features were preprocessed to create dummy variables for categorical inputs (e.g., Animal_Name_clam).  

---

## **Public API Endpoint**  
The backend API is publicly hosted on Render, making it accessible worldwide for predictions.

### **Base URL**  
[https://linear-regressionl-api.onrender.com](https://linear-regressionl-api.onrender.com)  

### **Swagger UI**  
For API documentation and testing:  
[https://linear-regressionl-api.onrender.com/docs](https://linear-regressionl-api.onrender.com/docs)  

### **Prediction Endpoint**  
- **HTTP Method**: POST  
- **Endpoint**: `/predict`  

#### **Request Body**  
```json
{
    "Animal_Name_clam": 0,
    "Animal_Name_slug": 0,
    "Animal_Name_seawasp": 0,
    "Animal_Name_worm": 0,
    "Animal_Name_octopus": 1,
    "Hair": 1,
    "Feathers": 0,
    "Backbone": 1,
    "Fins": 0,
    "Class_Type": 2
}

#### **Response**
```json
{
    "prediction": 65.2
}
