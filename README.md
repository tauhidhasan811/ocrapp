# Instructions for Local Gradle Testing

1. First, clone the project folder to your local disk using the command:  
   ```bash
   git clone https://github.com/tauhidhasan811/ocrapp.git
   ```

2. Then go to `<project-root>\android\gradle\wrapper` and set the `gradle-8.12-all` file path. There are two options:

---

## Option 1: Manual Download

1. Download `gradle-8.12-all.zip` from the official Gradle releases: [https://gradle.org/releases/](https://gradle.org/releases/)  
2. Save it in a local folder, for example:  
   ```
   C:\<user-name>\.gradle\wrapper\dists\gradle-8.12-all.zip
   ```
3. Open `gradle-wrapper.properties` located at:  
   ```
   <project-root>\gradle\wrapper\gradle-wrapper.properties
   ```
4. Set the distribution URL to use the local file:  
   ```
   distributionUrl=file\:///C:/<user-name>/.gradle/wrapper/dists/gradle-8.12-all.zip
   ```
5. Run the build using:  
   ```bash
   gradlew.bat build
   ```

---

## Option 2: Automatic Download

1. Open `gradle-wrapper.properties` and keep the distribution URL as:  
   ```
   distributionUrl=https\://services.gradle.org/distributions/gradle-8.12-all.zip
   ```
2. When running `gradlew.bat build`, Gradle will automatically download the required distribution.
