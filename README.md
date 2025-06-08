# Misala App
## 1. **About the Project**
Misala is an ML-powered mobile app that automates the identification and multilingual documentation of traditional African medicinal plants, preserving indigenous knowledge, promoting biodiversity conservation, and enhancing community health.

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
- Models to be hosted on Roboflow

- Models to be integrated with the Misala Mobile App for a good user experience and interaction with the solution

### Video Demo
[DEMO 1:Models](https://www.loom.com/share/007481837e0f4ddda5fd425de281479e?sid=d97121a0-03b0-4cd6-b275-92f2724913d6) 

[DEMO 2:Figma design](https://www.loom.com/share/ccedd95b5ca045d48458f4decce47efe?sid=c0ac3196-f3dd-42a8-8dff-0aa1d3c94416) 

---
