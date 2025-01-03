# **Wildlife Conservation Score Predictor** 🌱🐾  
### **A Data-Driven Approach to Prioritize Wildlife Conservation Efforts**  

---

## **Table of Contents**  
1. [Mission Statement](#introduction)  
2. [Features](#features)  
3. [Technologies Used](#technologies-used)  
4. [Dataset Information](#dataset-information)  
5. [Public API Endpoint](#public-api-endpoint)  
6. [Screenshots](#screenshots)  
7. [Demo Links](#demo-links)  
8. [How to Run the Project](#how-to-run-the-project)  
    - [Backend (API)](#backend-api)  
    - [Mobile App](#mobile-app)  
---

## **Mission Statement**  
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

  ## **Mobile App**  
The mobile app is built using **Flutter** and allows users to interact with the wildlife conservation score prediction model through a user-friendly interface.

### **Features**  
- **User Interface**: The app provides an intuitive interface with dropdowns, text fields, and an image carousel for animal features.
- **Prediction**: Users can input data for different animal characteristics and receive a prediction on the species' conservation score.

### **How to Run the Mobile App**  
1. **Install Flutter**: Follow the instructions to [install Flutter](https://flutter.dev/docs/get-started/install) on your system.  
2. **Clone the Mobile App Repository**: If the mobile app code is separate, clone the repository for the mobile app:
    ```bash
    git clone https://github.com/YourUsername/your-mobile-app-repo.git
    cd your-mobile-app-repo
    ```
3. **Install Dependencies**: Run the following command to install the required dependencies:
    ```bash
    flutter pub get
    ```
4. **Run the App**: Launch the app on an emulator or a connected device:
    ```bash
    flutter run
    ```

The app will launch, and you can start making predictions based on animal data input.

### **Screenshots of App**
![Screenshot 2024-11-24 131310](https://github.com/user-attachments/assets/cc70473d-d143-438b-9fb9-03340150dc67)
![Screenshot 2024-11-24 131440](https://github.com/user-attachments/assets/a5ac1878-51dc-42a6-bc9c-6b3822645897)


### **Machine Learning**  
- **Algorithm**: Linear Regression, chosen for its interpretability and suitability for numeric predictions.  
- **Features**: Focused on biological traits of animals such as Hair, Feathers, and Backbone.  

---

## **Demo Links**  
Click this link to watch the demo video: https://youtu.be/lDil3xyAgiI


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

## **Installation and Setup**

1. Clone the repository:

```
git clone https://github.com/Geu-Pro2023/linear_regression_model.git  
```

2. Navigate to the project directory:

```
 cd linear_regression_model
```

3. Install dependencies:

```
pip install -r requirements.txt
```

4. Run the API:

```
uvicorn main:app --host 0.0.0.0 --port 8000
```

5. Access the API locally:
```
http://127.0.0.1:8000/docs
```


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

{
    "prediction": 65.2
}

