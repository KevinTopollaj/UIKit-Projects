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
To Do List is a mobile application where you can add To Do Folders and for each Folder you can add To Do Items specific to that folder. All the data is persisted using CoreData and Generics to make the classes reusable.

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


