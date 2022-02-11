//
//  CarouselView.swift
//  Carousel
//
//  Created by Roman Fedotov on 11.02.2022.
//

import SwiftUI

struct CarouselView: View {
    
    @Binding var tabs: [Tab]
    @Binding var currentIndex: Int
    
    @State var fakeIndex: Int = 0
    
    @State var offset: CGFloat = 0
    
    var body: some View {
        
        TabView(selection: $fakeIndex) {
            
            ForEach(tabs) { tab in
                
                VStack(spacing: 10) {
                    
                    Spacer()
                    
                    Text("Your Condition")
                        .font(.title3.bold())
                        .foregroundColor(.gray)
                    
                    Text(tab.title)
                        .font(.largeTitle.bold())
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    Image(systemName: "checkmark.circle")
                        .font(.system(size: 75, weight: .light))
                        .foregroundColor(.green)
                        .padding(.bottom)
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white)
                .cornerRadius(30)
                .padding(.horizontal, 50)
                .overlay(
                    GeometryReader { proxy in
                        Color.clear
                            .preference(key: OffsetKey.self, value: proxy.frame(in: .global).minX)
                    }
                )
                .onPreferenceChange(OffsetKey.self, perform: { offset in
                    self.offset = offset
                })
                .tag(getIndex(tab: tab))
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(height: 350)
        .padding(.top, 20)
        .onChange(of: offset) { newValue in
            
            if fakeIndex == 0 && offset == 0 {
                fakeIndex = tabs.count - 2
            }
            if fakeIndex == tabs.count - 1  && offset == 0 {
                fakeIndex = 1
            }
        }
        .onAppear {

            guard var first = tabs.first else {
                return
            }
            guard var last = tabs.last else {
                return
            }

            first.id = UUID().uuidString
            last.id = UUID().uuidString

            tabs.append(first)
            tabs.insert(last, at: 0)

            fakeIndex = 1
        }
    }
    
    func getIndex(tab: Tab) -> Int {
        let index = tabs.firstIndex { currentTab in
            return currentTab.id ==  tab.id
        } ?? 0
        
        return index
    }
}

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
