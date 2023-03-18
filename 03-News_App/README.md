# NewsApp

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
The News App is a sophisticated mobile application that enables users to stay up-to-date with the latest news from a vast array of sources. Through seamless integration with the News API, the application enables users to display and cache images, creating a compelling list of news articles that can be easily accessed and enjoyed.

Upon selecting a news article, the application leverages the powerful SafariServices to display the full article, providing users with a seamless and immersive reading experience. The News App's advanced caching features further enhance its performance, enabling smooth and effortless browsing even when connectivity is limited.

Overall, the News App is a powerful mobile application that offers an unparalleled browsing experience for news enthusiasts. Its sophisticated design and robust features make it an excellent choice for anyone looking to stay up-to-date with the latest news from around the world.
## General info

### Human Interface Guidelines
* The application uses Apple's Human Interface Guidelines, native UI elements and it also adapts to the dark mode.

### Project Setup
The application views are all written in code.

In order to run the application you must have an API key provided by: [newsapi](https://newsapi.org/)


## Screenshots

News List            |  News Detail in Safari
:-------------------------:|:-------------------------:
![](./img/S1.png)  |  ![](./img/S2.png)


## Technologies
* Swift
* Xcode
* UIKit
* Foundation
* NSCache

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

* Using NSCache to cache images
* Make Network API calls
* Build programmatic layout
* Use MVVM architecture
* Build reusable views
* Custom Image View with Shadow
* Implement SafariServices

## Contact
Kevin Topollaj, email: kevintopollaj@gmail.com - feel free to contact me!
