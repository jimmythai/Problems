//
//  BorderProblemView.swift
//  Problems
//
//  Created by Atsushi Yamamoto on 2022/09/21.
//

import SwiftUI

struct BorderProblemView: View {
    var body: some View {
        ScrollView {
            HStack {
                Spacer()
                VStack(spacing: 14) {
                    VStack {
                        Text("strokeBorder")
                        
                        Circle()
                            .strokeBorder(.blue.opacity(0.8), lineWidth: 20)
                            .background(.red)
                            .frame(width: 100, height: 100)
                            .padding()
                    }
                    
                    VStack {
                        Text("stroke")
                        
                        Circle()
                            .stroke(.blue.opacity(0.8), lineWidth: 20)
                            .background(.red)
                            .frame(width: 100, height: 100)
                            .padding()
                    }
                }
                Spacer()
            }
        }
    }
}

struct BorderProblemView_Previews: PreviewProvider {
    static var previews: some View {
        BorderProblemView()
    }
}
