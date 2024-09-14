//
//  FileModel.swift
//  lavalab
//
//  Created by Naysa Bhargava on 9/13/24.
//

import SwiftUI

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
        files = [
            File(title: "Assignment 1", lastModified: "1m ago"),
            File(title: "Lab 3", lastModified: "40m ago"),
            File(title: "Workbook Ch. 3", lastModified: "2 hrs ago"),
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
