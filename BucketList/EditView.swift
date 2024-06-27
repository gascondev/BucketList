//
//  EditView.swift
//  BucketList
//
//  Created by Álvaro Gascón on 26/6/24.
//

import SwiftUI



struct EditView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var viewModel: ViewModel
    
    var onSave: (Location) -> Void
    var onDelete: () -> Void
    

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Place name", text: $viewModel.name)
                    TextField("Description", text: $viewModel.description)
                }
                Section("Nearby…") {
                    switch viewModel.loadingState {
                    case .loaded:
                        ForEach(viewModel.pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ") +
                            Text(page.description)
                                .italic()
                        }
                    case .loading:
                        Text("Loading…")
                    case .failed:
                        Text("Please try again later.")
                    }
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                                    Button(role: .destructive) {
                                        onDelete()
                                        dismiss()
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    Button("Save") {
                                        let newLocation = viewModel.createNewLocation()
                                        onSave(newLocation)
                                        dismiss()
                                    }
                                }
            }
            .task {
                await viewModel.fetchNearbyPlaces()
            }
        }
    }
    
    init(location: Location, onSave: @escaping (Location) -> Void, onDelete: @escaping () -> Void) {
        self.onSave = onSave
        self.onDelete = onDelete
        _viewModel = State(initialValue: ViewModel(location: location))

   
    }
}

#Preview {
    EditView(location: .example, onSave: { _ in }, onDelete: { })
}
