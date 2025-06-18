allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
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

android {
    // 👇 Add this line inside the android block
    ndkVersion = "27.0.12077973"

    compileSdk = 34
    namespace = "com.example.eduvian"

    defaultConfig {
        applicationId = "com.example.eduvian"
        // ... other config
    }
    // ... rest of android config
}
