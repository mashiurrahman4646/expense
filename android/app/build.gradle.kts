plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.your_expense"
    compileSdk = 36

    // ndkVersion = "27.0.12077973" // Remove if not needed

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.your_expense"
        minSdk = 23
        targetSdk = 34
        versionCode = project.properties["flutter.versionCode"]?.toString()?.toIntOrNull() ?: 1
        versionName = project.properties["flutter.versionName"]?.toString() ?: "1.0.0"
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}