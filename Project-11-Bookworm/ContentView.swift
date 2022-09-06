//
//  ContentView.swift
//  Project-11-Bookworm
//
//  Created by Luca Capriati on 2022/09/05.
//
//  Project 11 - Challange 1: Right now it’s possible to select no title, author, or genre for books, which causes a problem for the detail view. Please fix this, either by forcing defaults, validating the form, or showing a default picture for unknown genres – you can choose.
//  Project 11 - Challange 2: Modify ContentView so that books rated as 1 star are highlighted somehow, such as having their name shown in red.
//  Project 11 - Challange 3: Add a new “date” attribute to the Book entity, assigning Date.now to it so it gets the current date and time, then format that nicely somewhere in DetailView.

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    // Sort FetchRequest with the use of SortDescriptor. Can have more than one sort and will work in order of code.
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.title),
        SortDescriptor(\.author)
    ]) var books: FetchedResults<Book>
    
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(books) { book in
                    NavigationLink {
                        DetailView(book: book)
                    } label: {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            VStack(alignment: .leading) {
                                Text(book.title ?? "Unknown Title")
                                    .font(.headline)
                                    // Project 11 - Challange 2
                                    .foregroundColor(book.rating == 1 ? .red : .primary)
                                Text(book.author ?? "Unknown Author")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    //  .opacity(book.rating == 1 ? 0.5 : 1)
                }
                .onDelete(perform: deleteBooks)
            }
            .navigationTitle("Bookworm")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddScreen.toggle()
                    } label: {
                        Label("Add book", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                AddBookView()
            }
        }
    }
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            moc.delete(book)
        }
        
        //  comment this line out if you wish to test the edit and swipe to delete action without deleting the content from storage.
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
