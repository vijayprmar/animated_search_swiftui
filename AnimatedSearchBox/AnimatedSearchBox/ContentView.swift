//
//  ContentView.swift
//  AnimatedSearchBox
//
//  Created by Vijay Parmar on 02/12/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var strings = ["'Food'", "'Restaurants'", "'Groceries'", "'Beverages'", "'Bread'", "'Pizza'", "'Biryani'", "'Burger'", "'Bajji'", "'Noodles'", "'Soup'", "'Sandwich'", "'Biscuits'", "'Chocolates'"]
    @State private var currentIndex = 0
    @State private var currentLabel: String = "'Food'"
    @State private var nextLabel: String = "'Restaurants'"
    @State private var currentOpacity: Double = 1
    @State private var nextOpacity: Double = 0
    @State private var currentOffset: CGFloat = 0
    @State private var nextOffset: CGFloat = 20
    @State private var timer: Timer? = nil
    
    var body: some View {
        VStack {
            // Search TextField with magnifying glass icon
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .padding(.leading, 10)
                ZStack(alignment: .leading) {
                    HStack {
                        
                            Group {
                                Text("Search for")
                                // Labels for the animated placeholder text
                                ZStack(alignment: .leading) {
                                    Text(currentLabel)
                                        .opacity(currentOpacity)
                                        .offset(y: currentOffset)
                                    Text(nextLabel)
                                        .opacity(nextOpacity)
                                        .offset(y: nextOffset)
                                }
                                .onAppear {
                                    animateLabels()
                                }
                            }
                            .foregroundColor(.gray)
                        
                        Spacer()
                    }
                   
                }
            }
            .frame(height: 50) // Adjust based on your view height
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .padding()
        }
       
    }
    
    func stopTimer() {
        timer?.invalidate()
    }
    
    func resumeTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { _ in
            updateLabels()
        }
    }
    
    func animateLabels() {
        currentLabel = strings[currentIndex]
        nextLabel = strings[(currentIndex + 1) % strings.count]
        
        timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { _ in
            updateLabels()
        }
    }
    
    func updateLabels() {
        withAnimation(.easeInOut(duration: 1.0)) {
            currentOpacity = 0
            currentOffset = -20
            nextOpacity = 1
            nextOffset = 0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            // Reset the positions after the animation completes
            currentLabel = nextLabel
            currentOpacity = 1
            currentOffset = 0
            nextOpacity = 0
            nextOffset = 20
            
            currentIndex = (currentIndex + 1) % strings.count
            nextLabel = strings[(currentIndex + 1) % strings.count]
        }
    }
    
}

#Preview {
    ContentView()
}
