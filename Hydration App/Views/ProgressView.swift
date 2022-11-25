//
//  ProgressView.swift
//  Hydration App
//
//  Created by Michał Ganiebny on 23/11/2022.
//

import SwiftUI

struct ProgressView: View {
    
    @State var progressValue:Float = 0
    @EnvironmentObject var model: DrinkModel
    
    var progressText: String {
        if self.progressValue < 0.3 {
            return "Keep hydrating"
        }
        else if self.progressValue < 0.6 {
            return "Keep up the good work!"
        } else if self.progressValue < 1 {
            return "Just a little bit more"
        } else {
            return "Great Job!"
        }
    }
    
    var body: some View {
        
        ZStack {
            Color.blue
                .opacity(0.1)
                .ignoresSafeArea()
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Progress")
                            .font(.largeTitle)
                        .bold()
                        
                    }
                    Spacer()
                    
                }
                Spacer()
                
                ProgressBar(progress: self.$progressValue)
                    .frame(width: 250, height: 250)
                    .padding(40)
            
                
                Text(progressText)
                    .font(.headline)
                    .bold()
                    .padding(.bottom)
                
                Divider()
                
                HStack {
                    Text("History")
                        .font(.largeTitle)
                    .bold()
                    
                    Spacer()
                }
                
                if !model.drinks.isEmpty {
                    
                    
                    List {
                        ForEach(model.drinks) { drink in
                            ListRow(name: drink.name, emoji: drink.emoji, amount: drink.amount)
                            
                        }
                        .onDelete(perform: removeDrinks)
                    }
                    .scrollContentBackground(.hidden)
                    Spacer()
                }
                else {
                    Text("No drinks have been added yet")
                        .font(.caption)
                        .padding()
                    Spacer()
                }
            }
            .padding()
            
            
            
        }
        .onAppear {
            self.progressValue = 0
            model.calculateProgress()
            self.progressValue = model.progress
        }
        
        
    }
    func removeDrinks(at offsets: IndexSet) {
        model.drinks.remove(atOffsets: offsets)
        model.calculateProgress()
        self.progressValue = model.progress
        model.saveData()
    }
}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView().environmentObject(DrinkModel())
    }
}