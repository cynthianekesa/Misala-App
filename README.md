# Misala App
## 1. **About the Project**
Misala is an ML-powered mobile app that automates the identification and multilingual documentation of traditional African medicinal plants, preserving indigenous knowledge, promoting biodiversity conservation, and enhancing community health.

The project consists of:
- African medicinal plant identification model
- NLP Rule-Based Chatbot
- Reinforcement learning + identification model for drone simulation

### Research Proposal(05/28/2025)

[PROPOSAL](https://docs.google.com/document/d/1RpQLqegaGXdicoSxc8O93Bt4YJyuiTJr/edit?usp=sharing&ouid=116463373145295427131&rtpof=true&sd=true)

### Research Proposal Ethics(06/26/2025)

[ETHICS](https://docs.google.com/document/d/1k04BnqFJsXRbZZnlnVRXHFbMtiW8qRHyvEXEWvozRh0/edit?usp=sharing)


---

## 2. **Initial Software Product/Solution Demonstration(06/08/2025)**

### GitHub Repo

[REPO](https://github.com/cynthianekesa/Misala-App.git)

### Plant identification model
- 26 classes with 6535 images already split into 81% train, 11% validate, and 8% test data taken in different lighting and weather conditions, while taking into consideration both healthy and diseased plant parts for a non-biased model

- Overview of initial metrics, sizes, and aspect ratios of the images in the dataset

![image](https://github.com/user-attachments/assets/1c6d4801-4312-489a-88bd-45cda61691fa)

![image](https://github.com/user-attachments/assets/f86f53ff-a6b7-47c8-aa0a-b9a5eb241e5c)

![image](https://github.com/user-attachments/assets/1430e120-a786-49f3-82d6-9fac952d9fe5)

- Test Accuracy: `0.9382274150848389` and Test Loss: `0.21622663736343384`(MobileNet)

- Training and validation accuracy vs loss

  ![image](https://github.com/user-attachments/assets/b285118e-ea7d-4c52-a905-e703fa2a9bad)

- Trained models converted to TensorFlow Lite format to enable offline access

- GPU crashed while doing approach 2 training(Xception model)


### NLP Rule-Based Chatbot
- Used the NLTK library because it's lightweight, easy to use, and can enable offline access of the model

- Initial example of chatbot behaviour
  
![image](https://github.com/user-attachments/assets/1dab6759-4d50-491a-90d5-0157372e2304)


### Reinforcement learning for plant identification using drones
- This unique use case popped up during research and was also motivated by 3.2 summative work.

- Initial environment(to be developed further)

![image](https://github.com/user-attachments/assets/1bed5b26-90c5-4c55-8ad4-45e296c76e29)

- Going forward, is to add more actions, improve the GUI of the environment, and integrate the plant identification trained model.


### Environment and Project Setup
To set up the environment and run the project, follow these steps:

- Clone the repository

```bash
git clone https://github.com/cynthianekesa/Misala-App.git
cd Misala-App
Here you will have access to the Google Colab notebooks, hence you can view Explatory Data Analysis(EDA) and test model performance either by opening the notebook to lead you directly to Google Colab or using Visual Studio Code as it is.
The Google collabs can be accessed directly on GitHub, too
```

- View the Figma design of the proposed mobile app through the link in the readme.

### Design
[FIGMA FILE](https://www.figma.com/design/cL08VX67cx0oN2h7fJSvVV/Misala-App-Design?node-id=0-1&t=pYkBzYITdCOZpBm0-1)

[PROTOTYPE LINK](https://www.figma.com/proto/cL08VX67cx0oN2h7fJSvVV/Misala-App-Design?node-id=0-1&t=pYkBzYITdCOZpBm0-1)


### Deployment Plan
- Models to be hosted on Roboflow and also accessible offline

- Misala Mobile App to be accessible offline and also online via an affordable cloud provider

- Models to be integrated with the Misala Mobile App for a good user experience and interaction with the solution

### Video Demo
[DEMO 1:Models](https://www.loom.com/share/007481837e0f4ddda5fd425de281479e?sid=d97121a0-03b0-4cd6-b275-92f2724913d6) 

[DEMO 2:Figma design](https://www.loom.com/share/ccedd95b5ca045d48458f4decce47efe?sid=c0ac3196-f3dd-42a8-8dff-0aa1d3c94416) 

---

## 2. **Final Version of Product/Solution(07/07/2025)**: Testing, Analysis, Discussion, and Recommendations

### Plant Identification Model

- Data Quality
<img width="547" height="104" alt="image" src="https://github.com/user-attachments/assets/3242c6a3-9d77-4088-95b5-05a50b424e70" />

- Vanilla model & use of optimization techniques
  - Vanilla model performed poorly and on using optimization techniques still got the same results despite using a lot of resources
  - This led to opting for pre-trained image models and fine tuning them with my data since most of them are trained on western images with less focus on medicinal plants
  - Alexnet could also have been a good option but I didn't get to explore it
    
- MobileNetV2 Base Model Option 1
  - Model that was eventually hosted and used for the mobile app and reinforcement learning
  - Test Accuracy: 0.9382274150848389 and Test Loss: 0.21519993245601654
  - Model Summary
  <img width="678" height="282" alt="image" src="https://github.com/user-attachments/assets/06d5c40b-eeef-47ca-abba-e15e31911a16" />
  
- MobileNetV2 Base Model Option 2
  - Model performed close to option 1 on test dataset
  - Final training accuracy: 0.9205357432365417 and Final validation accuracy: 0.38155514001846313
  - Model Summary
  <img width="657" height="336" alt="image" src="https://github.com/user-attachments/assets/07babdfd-9424-4c97-bf2d-3e7a0fe08b44" />
  
- Xception Base Model
  - Model provided good results for partitioned data but on testing it performed very poorly
  - Accuracy: 0.9990 and loss: 0.0070
  - Model Summary
  <img width="667" height="331" alt="image" src="https://github.com/user-attachments/assets/dfa13dd4-57c1-43fc-bfb8-87adb4f8e41f" />
  - Model accuracy and loss graph
  <img width="572" height="455" alt="image" src="https://github.com/user-attachments/assets/3f577f33-c125-4367-8c1d-c61e12e6e6de" />
  
- Resnet
  - Training accuracy and loss was too low
  - Model Image
  <img width="113" height="418" alt="image" src="https://github.com/user-attachments/assets/8c32c238-6950-4837-ba1f-a30f270f0188" />
  - Training and validation accuracy/loss
  <img width="1156" height="706" alt="image" src="https://github.com/user-attachments/assets/e013ce36-f227-4faf-aec2-9c6d7a9f03f0" />
- InceptionV3, EfficientNet Base Model and VGG16
  - The three equally performed poorly


### MisalaBot
- I figured out training an NLP rule-based chatbot using the NLTK library 



### Drone Simulation


### Discussion 
https://docs.google.com/document/d/1HPm0eI6mJhf1iMHqgrXYsI-u7PXo-DiJoFUqzTaY8PE/edit?usp=sharing


### Environment and Project Setup
- Every directory has project setup procedures.


### Video Demo and apk
https://drive.google.com/drive/folders/1t8IZyRJ25tv2JuG1cWdDpuUVNPzhJMHn?usp=drive_link

---
