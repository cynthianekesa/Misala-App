# Project Setup

To set up the environment and run the project, follow these steps:

1. Install `node js` on your pc.

2. Clone the repository

```bash
git clone https://github.com/cynthianekesa/Misala-App
cd Misala Mobile App
```

3. Run `npm install` in the root of the project directory. This will install the required dependencies.

4. Run `npm start`.

5. Click `a` to open app on emulator

6. Install `expo go app` in android phone/emulator to interact with the app.

7. If you encounter an error while using expo go make sure you add the following lines of code in your .env file which is created at the root of the project directory but gitignored when pushing to GitHub.

```bash
EXPO_PUBLIC_APPWRITE_PROJECT_ID=687667cd00185d00e40c
EXPO_PUBLIC_APPWRITE_ENDPOINT=https://fra.cloud.appwrite.io/v1
EXPO_PUBLIC_APPWRITE_BUNDLE_ID=com.cynthianekesa.misala
```

---
