# Misala App
## 1. **About the Project**
There has been extreme biodiversity loss taking place in `KALONU AREA` over the past 5 years.
Misala is an ML-Powered mobile app with automated identification and multilingual documentation of traditional african medicinal plants for preservation of indigenous knowledge, biodiversity conservation, and community health Iimprovement.

The project consists of:
- African medicinal plant identification model
- NLP Rule-Based Chatbot
- Reinforcement learning + identification model for drone simulation

### Research Proposal(05/28/2025)

[PROPOSAL](https://docs.google.com/document/d/1RpQLqegaGXdicoSxc8O93Bt4YJyuiTJr/edit?usp=sharing&ouid=116463373145295427131&rtpof=true&sd=true)

---

## 2. **Initial Software Product/Solution Demonstration(06/08/2025)**

### GitHub Repo

[REPO](https://github.com/cynthianekesa/Misala-App.git)

### Plant identification model
- 26 classes with 6535 images already split into 81% train, 11% validate, and 8% test data taken in different lighting and weather conditions, while putting into consideration both healthy and diseased plant parts for a non-biased model

- Overview of initial metrics, sizes and aspect ratios of the images in the dataset

![image](https://github.com/user-attachments/assets/1c6d4801-4312-489a-88bd-45cda61691fa)

![image](https://github.com/user-attachments/assets/f86f53ff-a6b7-47c8-aa0a-b9a5eb241e5c)

![image](https://github.com/user-attachments/assets/1430e120-a786-49f3-82d6-9fac952d9fe5)

- Test Accuracy: 0.9382274150848389 and Test Loss: 0.21622663736343384

- Training and validation accuracy vs loss

  ![image](https://github.com/user-attachments/assets/b285118e-ea7d-4c52-a905-e703fa2a9bad)

- Trained models converted to tensorflow lite format to enable offline access

- GPU crashed while doing approach 2 training(Xception model)


### NLP Rule-Based Chatbot
- Used NLP because its lightweight, easy to use and can enable offline access of the model

- Initial example of chatbot behaviour
  
![image](https://github.com/user-attachments/assets/1dab6759-4d50-491a-90d5-0157372e2304)


### Reinforcement learning for plant identification using drones
- This unique usecase popped up during research and also motivated by 3.2 summative work.

- Initial environment(to be developed further)

![image](https://github.com/user-attachments/assets/1bed5b26-90c5-4c55-8ad4-45e296c76e29)

- Going forward is to add more actions, improve the GUI of the environment and integrate the plant identification trained model.


### Environment and Project Setup
To set up the environment and run the project, follow these steps:

- Clone the repository

```bash
git clone https://github.com/cynthianekesa/Misala-App.git
cd Misala-App
Here you will have access to the google collab notebooks hence you can view Explatory Data Analysis(EDA) and test model performance either by opening the notebook to lead you directly to google colllab or using visual studio code as it is.
The google collabs can be accessed directly on github too
```

- View figma design of the proposed mobile app through the link on readme.

### Design
[FIGMA FILE](https://www.figma.com/design/cL08VX67cx0oN2h7fJSvVV/Misala-App-Design?node-id=0-1&t=pYkBzYITdCOZpBm0-1)

[PROTOTYPE LINK](https://www.figma.com/proto/cL08VX67cx0oN2h7fJSvVV/Misala-App-Design?node-id=0-1&t=pYkBzYITdCOZpBm0-1)


### Deployment Plan
- Models to be hosted on Roboflow

- Models to be integrated with the Misala Mobile App for good user experience and interaction with the solution

### Video Demo
[DEMO] 

---
