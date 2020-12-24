//
//  ContentView.swift
//  Rock Paper Scissor
//
//  Created by Joon Park  on 12/21/20.
//

import SwiftUI

struct ContentView: View {
        
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var rightWrong = Bool.random()
    
    @State private var options = ["Rock", "Paper", "Scissors"]
    
    @State private var score = 0
    
    @State private var numQuestion = 0
    
    @State private var numRound = 1
    
    @State private var result = false
    
    
    var trueFalse: String{
        if rightWrong == true{
            return "Win"
        }
        else{
            return "Lose"
        }
    }
    
    var body: some View {

        ZStack {
            AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack (spacing: 30){
                VStack {
                    Text("The computer chooses:  ").font(.title)
                    Text(options[correctAnswer]).font(.largeTitle).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    
                    Text("Your aim is to:  ").font(.title)
                    Text(trueFalse).font(.largeTitle).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    
                    ForEach(0 ..< options.count) { number in
                        Button(action: {self.compare(number)
                            
                        }, label: {
                            HStack (spacing: 10) {
                                Image(systemName: "star.fill").foregroundColor(.yellow)
                                Text(self.options[number]).font(.largeTitle).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).foregroundColor(.black)
                            }.frame(height: 120)
                        
                        })
                    }
                    Spacer()
                }
            }
        }.alert(isPresented: $result) {
            Alert(title: Text("Well Done!"), message: Text("Your total score is \(score)"), dismissButton: .default(Text("Continue")) {
                self.gameOver()
            })
        }
    }
    
    func subsequentRound() {
        numRound += 1
        correctAnswer = Int.random(in: 0...2)
        rightWrong = Bool.random()
        
    }
    
    
    func compare(_ number: Int){
        if correctAnswer == 2 && number == 0 && rightWrong {
            score += 1
        }
        
        else if correctAnswer == 1 && number == 2 && rightWrong {
            score += 1
        }
        
        else if correctAnswer == 0 && number == 1 && rightWrong {
            score += 1
        }
        
        else if correctAnswer == 1 && number == 0 && !rightWrong {
            score += 1
        }
        
        else if correctAnswer == 2 && number == 1 && !rightWrong {
            score += 1
        }
        
        else if correctAnswer == 0 && number == 2 && !rightWrong {
            score += 1
        }
        
        if numRound == 10 {
            result = true
        }
        
        subsequentRound()
    }
    
    func gameOver() {
        score = 0
        numRound = 1
        subsequentRound()
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
