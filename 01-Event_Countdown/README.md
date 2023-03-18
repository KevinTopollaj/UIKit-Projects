# Event Countdown

## Table of contents
* [Description](#description)
* [General info](#general-info)
* [Screenshots](#screenshots)
* [Technologies](#technologies)
* [Architecture](#architecture)
* [DesignPattern](#designpattern)
* [Features](#features)
* [Contact](#contact)

## Description
Event Countdown is a mobile application where you can store events and each event has a title, a specific date that it is planed to happen, the year, month and day remaining until that date and a background image.

The user is able to add events, see the event detail and edit a specific event, and all this data are added, updated and displayed from CoreData.

## General info

### Human Interface Guidelines
* The application uses Apple's Human Interface Guidelines, native UI elements and it also adapts to the dark mode.

### Project Setup
The application views are all written in code and using storyboard.


## Screenshots

Event List            |  Add Event
:-------------------------:|:-------------------------:
![](./img/S1.png)  |  ![](./img/S2.png)

Event Detail           |  Edit Event
:-------------------------:|:-------------------------:
![](./img/S3.png)  |  ![](./img/S4.png)


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
* Coordinator
* Service
* Dependency Injection

## Features
* Display events and their data in a table view from CoreData.
* Add event.
* Display Details for a specific event.
* Edit event.

## Contact
Kevin Topollaj, email: kevintopollaj@gmail.com - feel free to contact me!
