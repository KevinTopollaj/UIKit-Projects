# ToDoList

## Table of contents
* [Description](#description)
* [General info](#general-info)
* [Demo](#demo)
* [Technologies](#technologies)
* [Architecture](#architecture)
* [DesignPattern](#designpattern)
* [Features](#features)
* [Contact](#contact)

## Description
The To Do List mobile application is a powerful productivity tool that enables users to create customized To Do Folders and associated To Do Items. Each Folder can be tailored to specific tasks or categories, allowing users to easily prioritize and organize their tasks.

The application leverages advanced technologies such as CoreData and Generics to ensure seamless and efficient data persistence, enhancing the overall user experience. This approach also makes the application more versatile and reusable, providing a solid foundation for future development and customization.

Overall, the To Do List mobile application is a sophisticated and versatile tool that offers an exceptional user experience for task management and organization. Its intuitive interface and robust feature set make it an excellent choice for anyone looking to enhance their productivity and streamline their daily tasks.

## General info

### Human Interface Guidelines
* The application uses Apple's Human Interface Guidelines, native UI elements and it also adapts to the dark mode.

### Project Setup
The application views are all written in code.

## Demo

<img src="demo.gif?raw=true" width="325px" height="650">

## Technologies
* Swift
* Xcode
* UIKit
* Foundation
* CoreData

## Architecture
#### Model-View-ViewModel (MVVM):
* Model: 
The Model where your data resides. Things like persistence, model objects, parsers, core data managers, and networking code live.
* View:
The user interface’s visual elements. In iOS, the view controller is inseparable from the concept of the view.
* ViewModel:
Updates the model from view inputs and updates views from model outputs.

## DesignPattern

* Singleton
* Target / Action

## Features

* Programmatic Layout
* Using CoreData
* Build Core Data Manager
* Fetched Results Controller with TableView
* Decouple DataSource, Data Providers for TableViews for better reuse
* Reusable Table View
* Generic Data Provider which can be used with any Table View
* Generic Data Source for Table View
* Lean View Controllers using Table View
* Code File Organisation

## Contact
Kevin Topollaj, email: kevintopollaj@gmail.com - feel free to contact me!


