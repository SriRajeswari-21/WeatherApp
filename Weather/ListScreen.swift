import SwiftUI

struct CityListView: View {
    

    @StateObject private var viewModel = CityListViewModel()

    var body: some View {
        VStack(spacing: 16) {

            // Search Bar
            TextField("Search location", text: $viewModel.searchText)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .padding(.horizontal)
            if viewModel.isAdding {
                                HStack {
                                    TextField("Enter city name", text: $viewModel.searchLocation)
                                        .textFieldStyle(.roundedBorder)

                                    Button("Add") {
                                        Task {
                                            await viewModel.addCity()
                                            viewModel.isAdding = false
                                        }
                                    }
                                }
                                .padding()
                            }

            List(viewModel.locations) { location in
                NavigationLink(destination: LocationDetailView(location: location)) {

                    HStack(spacing: 16) {
                        

                        Text(location.name)
                            .font(.headline)
                            .foregroundColor(.white)
                         Spacer()
                        
                        Image(systemName: location.weather.icon)
                            
                            .foregroundColor(.yellow)
                    }
                }
                .buttonStyle(PlainButtonStyle())
                .listRowBackground(Color.clear)   // row bg transparent
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)   // 👈 KEY LINE
        }.onAppear {
            viewModel.fetchLocations()
        }
        .background(Color("BGcolor"))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Locations")
                    .foregroundColor(.white)
                    .font(.headline)
                
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.isAdding.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                    }
                }
        }
// 👈 your app bg
       // .navigationTitle("Locations").foregroundStyle(Color.white)
    }
}
   

#Preview {
    NavigationStack {
        CityListView()

        
    }
  
}
