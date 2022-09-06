//
//  DetailView.swift
//  Project-11-Bookworm
//
//  Created by Luca Capriati on 2022/09/06.
//

import SwiftUI

struct DetailView: View {
    let book: Book
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre ?? "Fantasy")
                    .resizable()
                    .scaledToFit()
                
                Text(book.genre?.uppercased() ?? "FANTASY")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundStyle(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                    .offset(x: -5, y: -5)
            }
            
            Text(book.author ?? "Unkown Author")
                .font(.title)
                .foregroundColor(.secondary)
            Text(book.review ?? "No Review")
                .padding()
            
            RatingView(rating: .constant(Int(book.rating)))
                .font(.largeTitle)
        }
        .navigationBarTitle(book.title ?? "Unkown Book")
        .navigationBarTitleDisplayMode(.inline)
    }
}
