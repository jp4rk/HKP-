//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Joon Park  on 12/20/20.
//

import SwiftUI


struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}


extension View{
    func changeView () -> some View {
        self.modifier(Title())
    }
}

struct ContentView: View {
    
    @State private var answer = ""

    var body: some View {
        Form{
            Section{
                TextField("Your title", text: $answer)
            }
        
            Section{
                
                Text("\(answer)")
                    .changeView()
                
            }
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
