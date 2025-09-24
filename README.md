# Local Gradle Testing Guide

-----

## 1\. Clone the Project

Clone the repository to your local machine:

```bash
git clone https://github.com/tauhidhasan811/ocrapp.git
```

-----

## 2\. Configure OpenWeather API Key

Open the **weater\_service.dart** file and add your OpenWeather API key:

```
final String apiKey = "YOUR_API_KEY";
```

-----

## 3\. Configure Gradle Wrapper (Default Setup)

Edit the file:

```
<project-root>/gradle/wrapper/gradle-wrapper.properties
```

Set the distribution URL (this is set by default):

```
distributionUrl=https://services.gradle.org/distributions/gradle-8.12-all.zip
```

-----

## 4\. Build the Project

Run the following command from the project root (in terminal):

```bash
gradlew.bat build
```

⚠️ If the Gradle distribution fails to download automatically, follow the manual setup steps below.

-----

## Manual Gradle Setup

### Step 1: Download Gradle

Download **gradle-8.12-all.zip** from the official releases:
👉 [https://gradle.org/releases/](https://gradle.org/releases/)

### Step 2: Save Locally

Place the downloaded file in a local directory, for example:

```
C:\<user-name>\.gradle\wrapper\dists\gradle-8.12-all.zip
```

### Step 3: Update gradle-wrapper.properties

Open:

```
<project-root>/gradle/wrapper/gradle-wrapper.properties
```

Replace the distribution URL with the local file path:

```
distributionUrl=file:///C:/<user-name>/.gradle/wrapper/dists/gradle-8.12-all.zip
```

-----
