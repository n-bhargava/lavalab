//
//  ContentView.swift
//  lavalab
//
//  Created by Naysa Bhargava on 9/13/24.
//

import SwiftUI
struct ContentView: View {
    @State private var isSideBarOpened = false
    @StateObject private var viewModel = FileViewModel()
    @State private var isGridView = true
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("All Projects")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Button(action: { isGridView = true }) {
                            Image(systemName: "square.grid.2x2")
                                .foregroundColor(isGridView ? .primary : .secondary)
                        }
                        
                        Button(action: { isGridView = false }) {
                            Image(systemName: "list.bullet")
                                .foregroundColor(!isGridView ? .primary : .secondary)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    if isGridView {
                        ScrollView {
                            LazyVGrid(columns: [GridItem(.flexible())], spacing: 20) {
                                ForEach(viewModel.files) { file in
                                    FileRow(file: file)
                                        .frame(height: 300)
                                }
                            }
                            .padding(.horizontal)
                        }
                    } else {
                        List(viewModel.files) { file in
                            HStack {
                                Image(systemName: "doc.text.fill")
                                    .foregroundColor(.accentColor)
                                VStack(alignment: .leading) {
                                    Text(file.title)
                                        .font(.headline)
                                    Text(file.lastModified)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding(.vertical, 8)
                        }
                        .listStyle(PlainListStyle())
                    }
                }
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        FloatingActionButton(action: {
                            print("Add new file")
                        })
                        .padding(.trailing, 20)
                        .padding(.bottom, 20)
                    }
                }
            }
            .navigationBarItems(leading: Button(action: { isSideBarOpened.toggle() }) {
                Image(systemName: "line.horizontal.3")
            }, trailing: Button(action: { print("search") }) {
                Image(systemName: "magnifyingglass")
            })
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image(.aroLogo)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 30)
                }
            }
        }
        .overlay(
            Sidebar(isSidebarVisible: $isSideBarOpened)
        )
    }
}


struct FileRow: View {
    let file: File
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.1))
                    .aspectRatio(3/2, contentMode: .fit)
                
                Image(systemName: "doc.text.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color.accentColor)
                    .frame(width: 60, height: 60)
            }
            .frame(height: 200)
            
            Text(file.title)
                .font(.headline)
                .foregroundColor(.primary)
            
            Text(file.lastModified)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 2)
    }
}

struct FloatingActionButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "plus")
                .foregroundColor(.white)
                .font(.title2)
                .frame(width: 60, height: 60)
                .background(Color.accentColor)
                .clipShape(Circle())
                .shadow(radius: 4)
        }
    }
}


#Preview {
    ContentView()
}
