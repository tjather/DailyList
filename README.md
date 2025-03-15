# DailyList

## **Project Overview**  
**Daily List** is a simple and intuitive **to-do list app** designed for iOS. It allows users to create, manage, and organize tasks into separate lists. Tasks can be **added, checked off, searched for, and deleted**. The app leverages **Realm Database** for persistent storage and **SwipeCellKit** for smooth swipe-to-delete functionality.  

## **Team Members**  
- **Talha Ather**  
- **Jake Davis**  

## **Technology Stack**  
- **Language**: Swift **5.6.1**  
- **Framework**: UIKit  
- **Database**: RealmSwift  
- **iOS Deployment Target**: 13.0  
- **Third-Party Libraries**:  
  - **[RealmSwift](https://www.mongodb.com/docs/atlas/app-services/tutorial/swiftui/)** – For local data persistence.  
  - **[SwipeCellKit](https://github.com/SwipeCellKit/SwipeCellKit)** – Enables swipe gestures for deleting tasks.  

## **Features**  
- **Task Management** – Add, check off, and delete tasks.  
- **Category Organization** – Group tasks into user-defined lists.  
- **Swipe-to-Delete** – Uses **SwipeCellKit** for smooth task deletion.  
- **Search Functionality** – Quickly find tasks containing specific keywords.  
- **Persistent Storage** – All data is saved locally using **Realm Database**.  

## **Design & Architecture**  
### **Architectural Patterns**  
- **Model-View-Controller (MVC)** – Ensures separation of concerns by organizing the app into three components:
  - **Model**: Manages data and business logic using **RealmSwift**.
  - **View**: Handles the user interface using **UIKit**.
  - **Controller**: Bridges the Model and View, managing user interactions and updating the UI.

### **Design Patterns Used**  
- **Template Design Pattern** – Used for reusability across table views, allowing a base table view controller (`TableViewController`) to be extended by specific views (`ListViewController` and `CategoryViewController`).
- **Singleton Pattern** – Utilized in `CategoriesSingleton` to manage category storage and retrieval efficiently, ensuring a single source of truth.
- **Delegate Pattern** – Implements communication between the `ListViewController` and `SearchBar`, enabling dynamic filtering of tasks based on user input.
- **Factory Pattern** – Simplifies object creation by abstracting instance creation logic for tasks and categories.
- **Observer Pattern (Replaced)** – Initially considered for notifications but replaced with the **Template Pattern** for better scalability and maintainability.

## **System Implementation & Development Insights**  
- The **original plan** was to implement the **Observer pattern** for notifications, but it was replaced with the **Template Pattern** due to implementation challenges.  
- **Realm Database** made local data storage seamless, eliminating the need for cloud-based solutions.  
- Using **MVC** ensured **efficient UI updates** when users added or deleted tasks.  
- **Design patterns like Singleton and Delegate** improved code organization and maintainability.  
