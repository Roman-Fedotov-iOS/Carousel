//
//  Home.swift
//  Carousel
//
//  Created by Roman Fedotov on 10.02.2022.
//

import SwiftUI

struct Home: View {
    
    @State var tabs: [Tab] = [
    Tab(title: "3+ Years \nExercising"),
    Tab(title: "Fitness Underground"),
    Tab(title: "Intense Course"),
    Tab(title: "Power For Kids"),
    Tab(title: "Outdoor Fitness")
    ]
    
    @State var currentIndex: Int = 0
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            HStack {
                
                Button {
                    
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.body.bold())
                        .foregroundColor(.white)
                        .frame(width: 40, height: 40)
                        .background(
                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder(Color.white.opacity(0.6), lineWidth: 1)
                        )
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("skip".uppercased())
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
            }
            .overlay(
                HStack(spacing: 4) {
                    
                }
            )
            .padding()
            
            ScrollView(getRect().height < 750 ? .vertical : .init(), showsIndicators: false) {
                
                VStack(spacing: 20) {
                    
                    Text("Prepare for training")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 20)
                    
                    Text("Let`s create a \nunique training plan \nfor yourself")
                        .font(.system(size: 38, weight: .bold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .lineLimit(4)
                    
                    
                    CarouselView(tabs: $tabs, currentIndex: $currentIndex)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
        
            LinearGradient(colors: [
            Color("bg1"),
            Color("bg2")
            ], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
        )
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}
