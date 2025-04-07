plugins {
    id("com.google.gms.google-services") version "4.3.15" apply false
}

buildscript {
    dependencies {
        classpath("com.google.gms:google-services:4.3.15")
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// ضبط مسارات build لتكون خارج مجلد android مباشرة (اختياري لتحسين التنظيم)
val newBuildDir = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.set(newBuildDir)

subprojects {
    val newSubBuildDir = newBuildDir.dir(project.name)
    project.layout.buildDirectory.set(newSubBuildDir)
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
