//
//  FileModel.swift
//  lavalab
//
//  Created by Naysa Bhargava on 9/13/24.
//

import SwiftUI

// Update your File model to remove the thumbnailURL if it's no longer needed
struct File: Identifiable {
    let id = UUID()
    var title: String
    var lastModified: String
}


// ViewModel to manage files
class FileViewModel: ObservableObject {
    @Published var files: [File] = []
    
    init() {
        loadFiles()
    }
    
    func loadFiles() {
        // In a real app, this would fetch data from an API
        files = [
            File(title: "Assignment 1", lastModified: "1m ago"),
            File(title: "Lab 3", lastModified: "40m ago"),
            File(title: "Workbook Ch. 3", lastModified: "2 hrs ago"),
            // Add more sample files as needed
        ]
    }
}


// Preview
struct FileRow_Previews: PreviewProvider {
    static var previews: some View {
        FileRow(file: File(title: "Assignment 1", lastModified: "1m ago"))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
