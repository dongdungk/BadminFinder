buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        // Firebase Auth 및 Google Services 플러그인 경로
        classpath("com.google.gms:google-services:4.4.0")

        // Android Gradle Plugin (AGP) - 이전에 있던 버전과 일치해야 함
        classpath("com.android.tools.build:gradle:8.2.0") // 버전 확인 필요

        // Kotlin Gradle Plugin - 이전에 있던 버전과 일치해야 함
        // classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:1.9.20")
    }
}


allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
