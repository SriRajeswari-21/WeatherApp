# 🌤️ SwiftUI Weather App

A modern **SwiftUI Weather App** that displays live weather information for multiple cities with a clean UI, smooth navigation, persistent storage, and a polished iOS experience.

---

## 📱 Features

### 🏁 Landing Screen
- Entry screen for the app
- Smooth navigation flow into the app
- Integrated **Launch Screen** for native iOS startup experience

---

### 📍 City List Screen
- Displays a list of cities
- Each row shows:
  - City name
  - Live weather icon
- Fully tappable rows using `NavigationStack` & `NavigationLink`
- Search functionality to filter cities

---

### 🌦️ Weather Detail Screen
- Displays **live weather data** for the selected city
- Includes:
  - 🌡 Temperature
  - 💧 Humidity
  - 🌧 Rain
  - 🌬 Wind Speed
- Data shown using **clean card-style UI (2×2 grid)**
- Weather icon updates dynamically based on:
  - Weather code
  - Day / Night state

---

## 💾 Core Data Persistence

- Uses **Core Data** to store:
  - City name
  - Latitude & longitude
  - Temperature
  - Weather code
  - Day / Night information
- Enables:
  - Faster loading
  - Cached data across app launches
- Core Data updates automatically when fresh API data is fetched

---

## 🎨 UI & UX

- 🌙 Dark theme design
- 🎨 Custom background colors
- 🧭 White navigation titles
- 📱 Responsive layouts using `VStack` & `HStack`
- 🚀 Custom **App Icon**
- 🖼️ Native **Launch Screen**

---

## 🧱 Architecture

The app follows **MVVM (Model–View–ViewModel)** architecture.

### Views
- `LandingScreen`
- `CityListView`
- `LocationDetailView`

### ViewModels
- `CityListViewModel`
- `LocationDetailViewModel`

### Models
- `WeatherResponse` – API response model
- `Location` – UI model
- `WeatherLocation` – Core Data entity

---

## 🔑 Key Components

- `WeatherServiceProtocol` – Abstraction for weather API
- `WeatherService` – API implementation
- `PersistenceController` – Core Data stack
- `Weather` enum – Maps weather codes to system icons
- `LocationDetailViewModel` – Handles API calls & Core Data updates

---

## 🛠️ Tech Stack

- **Language:** Swift
- **Framework:** SwiftUI
- **Architecture:** MVVM
- **Persistence:** Core Data
- **Concurrency:** async / await
- **Networking:** URLSession
- **State Management:** `ObservableObject`, `@Published`
- **iOS Version:** iOS 16+

---

## 🚀 How to Run

1. Clone the repository:
 
   git clone https://github.com/SriRajeswari-21/WeatherApp
2.  Open the project in Xcode:

   open Weather.xcodeproj


3.Select an iOS Simulator or physical device

4.Build & Run ▶️
