//
//  ButtonProblemView.swift
//  Problems
//
//  Created by Atsushi Yamamoto on 2022/09/09.
//

import SwiftUI

struct ButtonProblemView: View {
    var body: some View {
        ScrollView {
            let spacing: CGFloat = 14
            VStack(spacing: spacing) {
                VStack(spacing: spacing) {
                    VStack {
                        Text("Simple button")
                        
                        Button("Button", action: tap)
                    }
                    
                    VStack {
                        Text("Button with padding and background (❌wrong)")
                        
                        Button("Button", action: tap)
                            .foregroundColor(.white)
                            .padding()
                            .background(.orange)
                    }
                    
                    VStack {
                        Text("Button with padding and background (✅correct)")
                        
                        Button(action: tap) {
                            Text("Button")
                                .foregroundColor(.white)
                                .padding()
                                .background(.orange)
                        }
                    }
                    
                    VStack {
                        Text("Button with rounded corners (❌wrong)")
                        
                        Button(action: tap) {
                            Text("Button")
                                .foregroundColor(.white)
                                .padding()
                                .cornerRadius(4)
                                .background(.orange)
                        }
                    }
                    
                    VStack {
                        Text("Button with rounded corners (✅correct)")
                        
                        Button(action: tap) {
                            Text("Button")
                                .foregroundColor(.white)
                                .padding()
                                .background(.orange)
                                .cornerRadius(4)
                        }
                    }
                    
                    VStack {
                        Text("Button with a border and rounded corners (❌wrong)")
                        
                        Button(action: tap) {
                            Text("Button")
                                .foregroundColor(.orange)
                                .padding()
                                .border(.orange, width: 2)
                                .cornerRadius(10)
                        }
                    }
                    
                    VStack {
                        Text("Button with a border and rounded corners (✅correct)")
                        
                        Button(action: tap) {
                            Text("Button")
                                .foregroundColor(.orange)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .strokeBorder(.orange, lineWidth: 2)
                                )
                        }
                    }
                }
                
                VStack(spacing: spacing) {
                    VStack {
                        Text("Button with a border, rounded corners and background (❌wrong)")
                        
                        Button(action: tap) {
                            Text("Button")
                                .foregroundColor(.orange)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .strokeBorder(.orange, lineWidth: 2)
                                        .background(.purple)
                                )
                        }
                    }
                    
                    let roundedRectangle = RoundedRectangle(cornerRadius: 10)
                    
                    VStack {
                        Text("Button with a border, rounded corners and background (✅correct 1)")
                        
                        Button(action: tap) {
                            Text("Button")
                                .foregroundColor(.orange)
                                .padding()
                                .background(
                                    roundedRectangle
                                        .strokeBorder(.orange, lineWidth: 2)
                                        .background(
                                            roundedRectangle
                                                .foregroundColor(.purple)
                                        )
                                )
                        }
                    }
                    
                    VStack {
                        Text("Button with a border, rounded corners and background (✅correct 2)")
                        
                        Button(action: tap) {
                            Text("Button")
                                .foregroundColor(.orange)
                                .padding()
                                .background(
                                    roundedRectangle
                                        .strokeBorder(.orange, lineWidth: 2)
                                        .background(.purple)
                                )
                                .clipShape(roundedRectangle)
                        }
                    }
                    
                    VStack {
                        Text("Full-width button")
                        
                        Button(action: tap) {
                            HStack {
                                Spacer()
                                Text("Button")
                                Spacer()
                            }
                            .foregroundColor(.white)
                            .padding()
                            .background(.orange)
                        }
                    }
                    
                    VStack {
                        Text("Button with images")
                        
                        Button(action: tap) {
                            HStack {
                                Image(systemName: "house")
                                Text("Button")
                            }
                            .foregroundColor(.white)
                            .padding()
                            .background(.orange)
                        }
                    }
                    
                    VStack {
                        Text("Disabled button (❌wrong)")
                        
                        Button(action: tap) {
                            Text("Button")
                                .foregroundColor(.white)
                                .padding()
                                .background(.orange)
                        }
                        .disabled(true)
                    }
                    
                    VStack {
                        Text("Disabled button (✅correct)")
                        
                        Button(action: tap) {
                            Text("Button")
                                .tint(.white)
                                .padding()
                                .background(.orange)
                        }
                        .disabled(true)
                    }
                }
            }
        }
    }
    
    func tap() {
        print("tapped")
    }
}

struct ButtonProblemView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonProblemView()
    }
}
