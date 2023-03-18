# PhotoBrowser

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
Photo Browser is a cutting-edge mobile application designed to provide an exceptional browsing experience for images sourced from the Pexels API. With Photo Browser, users can effortlessly display and cache a virtually unlimited number of images by leveraging an innovative infinite scrolling feature.

By tapping on a specific image, users can view the full version of the image, allowing for a more immersive and engaging browsing experience. The application's advanced caching capabilities further enhance its performance, providing a seamless user experience even with a slow or unreliable internet connection.

Overall, Photo Browser is a high-performance mobile application that leverages advanced caching and infinite scrolling features to provide an unparalleled browsing experience for Pexels API images. Its intuitive interface and user-centric design make it an excellent choice for anyone looking to browse and discover beautiful images on their mobile device.

## General info

### Human Interface Guidelines
* The application uses Apple's Human Interface Guidelines, native UI elements and it also adapts to the dark mode.

### Project Setup
The application views are all written in code.


## Screenshots

Images List            |  Image Detail
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

* Delegation
* Target / Action

## Features

* Abstract Networking Layer
* Enum for Endpoint Management
* Swift Generics
* Protocol Oriented Approach
* Efficiently Loading Images in TableView
* Loading Network Images
* Async Image Loading and Caching
* Handle image download cancellation when row is no longer visible
* Handle cell reuse in tableView
* Infinite Loading Cell

## Contact
Kevin Topollaj, email: kevintopollaj@gmail.com - feel free to contact me!
