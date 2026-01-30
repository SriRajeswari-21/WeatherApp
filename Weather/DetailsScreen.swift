import SwiftUI

struct LocationDetailView: View {

    let location: Location

    @StateObject private var viewModel =
        LocationDetailViewModel(
            weatherService: WeatherService(
                networkService: HttpNetworking()
            )
        )

    var body: some View {
        VStack(spacing: 24) {

            Spacer()

            // City Name
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.medium)
                .foregroundColor(.white)

            // Weather Icon
            if let weather = viewModel.weather {
                let icon = Weather(
                    weatherCode: weather.current.weatherCode,
                    isDay: weather.current.isDay == 1
                ).icon

                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .foregroundColor(.yellow)
            }

               

            // Temperature (API driven)
            if viewModel.isLoading {
                ProgressView()
                    .tint(.white)
            } else if let weather = viewModel.weather {
                
                VStack(spacing: 16) {

                    // TOP ROW
                    HStack(spacing: 16) {

                        // Temperature Card
                        VStack(spacing: 8) {
                            Image(systemName: "thermometer")
                                .font(.title2)

                            Text(
                                "\(Int(weather.current.temperature2M)) \(weather.currentUnits.temperature2M)"
                            )
                            .font(.headline)

                            Text("Temperature")
                                .font(.caption)
                                .opacity(0.7)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black.opacity(0.25))
                        .cornerRadius(16)

                        // Humidity Card
                        VStack(spacing: 8) {
                            Image(systemName: "drop.fill")
                                .font(.title2)

                            Text(
                                "\(weather.current.relativeHumidity2M) \(weather.currentUnits.relativeHumidity2M)"
                            )
                            .font(.headline)

                            Text("Humidity")
                                .font(.caption)
                                .opacity(0.7)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black.opacity(0.25))
                        .cornerRadius(16)
                    }

                    // BOTTOM ROW
                    HStack(spacing: 16) {

                        // Rain Card
                        VStack(spacing: 8) {
                            Image(systemName: "cloud.rain.fill")
                                .font(.title2)

                            Text(
                                "\(Int(weather.current.rain)) \(weather.currentUnits.rain)"
                            )
                            .font(.headline)

                            Text("Rain")
                                .font(.caption)
                                .opacity(0.7)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black.opacity(0.25))
                        .cornerRadius(16)

                        // Wind Card
                        VStack(spacing: 8) {
                            Image(systemName: "wind")
                                .font(.title2)

                            Text(
                                "\(Int(weather.current.windSpeed10M)) \(weather.currentUnits.windSpeed10M)"
                            )
                            .font(.headline)

                            Text("Wind")
                                .font(.caption)
                                .opacity(0.7)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black.opacity(0.25))
                        .cornerRadius(16)
                    }
                }
                .foregroundColor(.white)
                .padding(.horizontal)



            } else if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
            }

            // Description (still dummy text)
//            Text("""
//            A warm breeze drifted through the streets as the afternoon sun hovered behind a veil of scattered clouds. In the north, the air felt dry and dusty, while the southern coast carried the familiar scent of moisture from the sea. Somewhere in the distance, dark monsoon clouds gathered slowly, hinting at an evening shower.
//            """)
//            .font(.body)
//            .foregroundColor(.white.opacity(0.7))
//            .padding(.horizontal)
//            .multilineTextAlignment(.leading)

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("BGcolor"))
        .ignoresSafeArea()

        // Navigation Title Styling
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Locations")
                    .foregroundColor(.white)
                    .font(.headline)
            }
        }

        // API call
        .task {
            await viewModel.loadWeather(
                latitude: location.latitude,
                longitude: location.longitude, locationName: location.name
            )
        }
    }
}
