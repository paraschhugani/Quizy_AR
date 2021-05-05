/*:
# Please:
* 1. Use the app in Portrait mode
* 2. Have [1 meter square Area](https://www.google.com/search?q=1+meter+square) plane  in front of you for best UI experience with ArView.
* 3. Make sure to have "Enable Results" off:
 
 ![contrller image](enabel.png)
 */

/*:
 # Game Level 2
 
 ## Anwer this easy Question and you will play AR Game level 2
 
 # Points to consider here:
 
 
 * ### Step 1:
 Detecting a Horizontal plane and you will be able to see a basketball and a goal post , make sure you have good lights and only Hit start button.
 * ### Step 2:
 Now you can play the game using [Special Joystick Controller.](https://github.com/paraschhugani)
 also you can use Bounce Button to bounce the ball.
 
 ![contrller image](joystickButton.png)
  */





/*:
 # Thank you to review my WWDC APP.
  From [Paras Chhugani.](https://github.com/paraschhugani)
 */


import SwiftUI
import PlaygroundSupport


struct ContentView : View {
    
    @State var Gamesit = "Stage2Question"
    
    var body: some View {
        ZStack(alignment: .bottom, content: {
            
            
            Text("Game Completed !!")
                .font(.system(size: 85))
                .bold()
                .foregroundColor(.green)
                .offset(x: 30.0, y: -150.0)
            
            Text("Thank you to review my WWDC app !!")
                .font(.system(size: 65))
                .bold()
                .foregroundColor(.purple)
                .offset(x: 10.0, y: 50.0)
            
            Text("from: Paras Chhugani")
                .font(.system(size: 65))
                .bold()
                .foregroundColor(.blue)
                .offset(x: 0.0, y: 250.0)
            
            if Gamesit == "Stage2Question"{
                quiz2(Gamesit: $Gamesit, questionNo: 1)
                    .offset(x: 0.0, y: -40.0)
                    .overlay(
                        Text("Stage 2")
                            .font(.system(size: 60))
                            .bold()
                            .foregroundColor(.blue)
                            .offset(x: 00, y: -350.0)
                    )
            }
            else if Gamesit == "Stage2Game"{
                ball2(Gamesit: $Gamesit)
            }
            
            
        })
        
    }
}

import Foundation

//code for structureing the Questions
struct Question {
    let text: String
    
    //Multiple choice questions have multiple answers, an Array of Strings would work for our quiz data.
    let answers: [String]
    //Look at the data in the quiz array, there is a seperate string that is the correctAnswer.
    let rightAnswer: String
    
    //The initialiser needs to be updated to match the new multiple choice quiz data.
    init(q: String, a: [String], correctAnswer: String) {
        text = q
        answers = a
        rightAnswer = correctAnswer
    }
}


//code for structureing the Quiz Brain
struct QuizBrain {
    
    var score = 0
    
    let quiz = [
        Question(q: "Which is the largest organ in the human body?", a: ["Heart", "Skin", "Large Intestine"], correctAnswer: "Skin"),
        Question(q: "Five dollars is worth how many nickels?", a: ["25", "50", "100"], correctAnswer: "100"),
        Question(q: "What do the letters in the GMT time zone stand for?", a: ["Global Meridian Time", "Greenwich Mean Time", "General Median Time"], correctAnswer: "Greenwich Mean Time"),
        Question(q: "What is the French word for 'hat'?", a: ["Chapeau", "Écharpe", "Bonnet"], correctAnswer: "Chapeau"),
        Question(q: "In past times, what would a gentleman keep in his fob pocket?", a: ["Notebook", "Handkerchief", "Watch"], correctAnswer: "Watch"),
        Question(q: "How would one say goodbye in Spanish?", a: ["Au Revoir", "Adiós", "Salir"], correctAnswer: "Adiós"),
        Question(q: "Which of these colours is NOT featured in the logo for Google?", a: ["Green", "Orange", "Blue"], correctAnswer: "Orange"),
        Question(q: "What alcoholic drink is made from molasses?", a: ["Rum", "Whisky", "Gin"], correctAnswer: "Rum"),
        Question(q: "What type of animal was Harambe?", a: ["Panda", "Gorilla", "Crocodile"], correctAnswer: "Gorilla"),
        Question(q: "Where is Tasmania located?", a: ["Indonesia", "Australia", "Scotland"], correctAnswer: "Australia")
    ]
    
    func getQuestionText(questionNumber:Int) -> String {
        return quiz[questionNumber].text
    }
    
    //Need a way of fetching the answer choices.
    func getAnswers(questionNumber:Int) -> [String] {
        return quiz[questionNumber].answers
    }
    
    
    
    mutating func checkAnswer(userAnswer: String , questionNumber:Int) -> Bool {
        //Need to change answer to rightAnswer here.
        if userAnswer == quiz[questionNumber].rightAnswer {
            score += 1
            return true
        } else {
            return false
        }
    }
}

//code for quiz2UI 
struct quiz2: View {
    
    @Binding var Gamesit: String
    
    let questionNo: Int
    
    var body: some View {
        
        ZStack{
            
            Image(uiImage: #imageLiteral(resourceName: "3.png"))
                .resizable()
                .frame(width: 730, height: 700, alignment: .center)
                .cornerRadius(100)
                .offset(x: 0.0, y: 100.0)
            
            
            Button(action: {
                
                Gamesit = "Stage2Game"
                
            }, label: {
                Text("Next")
                    .foregroundColor(.white)
                    .frame(width: 200, height: 70, alignment: .center)
                    .background(Color.blue)
                    .cornerRadius(100)
                    .font(.title)
            }).offset(x: 230.0, y: 380.0)
            
            Q2Element(questionNumber: questionNo, Gamesit: $Gamesit)
            
        }
    }
}

struct Q2Element: View {
    
    let questionNumber : Int
    
    @Binding var Gamesit: String
    
    var quizBrain = QuizBrain()
    
    var body: some View {
        Button(action: {
            print("Qustion Clicked")
        }, label: {
            Text("Q. " + quizBrain.getQuestionText(questionNumber: questionNumber))
                .frame(width: 650, height: 100, alignment: .center)
                .background(Color.white.opacity(0.7))
                .cornerRadius(100)
                .font(.title)
        }).offset(x: 0.0, y: -170.0)
        
        VStack( spacing: 10, content:{
            
            
            Answerquiz2(Gamesit: $Gamesit, optionName: "A", optionText: quizBrain.getAnswers(questionNumber: questionNumber)[0] , questionNO: questionNumber)
            Answerquiz2(Gamesit: $Gamesit, optionName: "B", optionText: quizBrain.getAnswers(questionNumber: questionNumber)[1] , questionNO: questionNumber)
            Answerquiz2(Gamesit: $Gamesit, optionName: "C", optionText: quizBrain.getAnswers(questionNumber: questionNumber)[2] , questionNO: questionNumber)
        }).offset(x: 150.0, y: 50.0)
    }
    
}

struct Answerquiz2: View {
    
    @Binding var Gamesit: String
    
    let optionName : String
    
    let optionText : String
    
    @State var questionNO : Int
    
    var quizBrain = QuizBrain()
    
    @State private var optionColor = Color.white
    
    var body: some View {
        Button(action: {
            
            
            if optionText == quizBrain.quiz[questionNO].rightAnswer{
                optionColor = Color.green
                
                Gamesit = "Stage2Game"
                
            }
            
            
            print(optionName+" clicked")
        }, label: {
            Text(optionName + ". " + optionText)
                .frame(width: 250, height: 70, alignment: .center)
                .background(optionColor)
                .cornerRadius(100)
                .font(.title)
        })
    }
}


//struct quiz2_Previews: PreviewProvider {
//    static var previews: some View {
//        quiz2()
//            .previewDevice(PreviewDevice(rawValue: "iPad (8th generation)"))
//    }
//}



//code for ball2 Structureing ArView GAme2

import SwiftUI
import RealityKit
import Combine


var ball2prof:[Entity] = []

struct ball2: View {
    @Binding var Gamesit: String
    
    
    @State private var startgameopacity = 1.0
    
    var body: some View {
        
        ZStack(alignment: .bottom, content: {
            
            
            ARViewContainerball2()
                .edgesIgnoringSafeArea(.all)
            
            ball2CONTROLLER(Gamesit: $Gamesit)
            
            
        })
    }
}




struct ARViewContainerball2: UIViewRepresentable {
    
    //      let arView = ARView(frame: .zero)
    let arView = ARView(frame: .zero, cameraMode: .ar, automaticallyConfigureSession: true)
    
    func makeUIView(context: Context) -> ARView {
        
        print("here the position of camera is ", arView.cameraTransform)
        
        let anchor = AnchorEntity(plane: .horizontal , minimumBounds: [0.2 , 0.2])
        //        plane: .horizontal , minimumBounds: [0.2 , 0.2]
        
        arView.scene.addAnchor(anchor)
        
        
        var cancellable: AnyCancellable? = nil
        
        cancellable = ModelEntity.loadModelAsync(contentsOf: #fileLiteral(resourceName: "soccerBall.usdz"))
            .append(ModelEntity.loadModelAsync(contentsOf: #fileLiteral(resourceName: "Soccer_Goal.usdz")))
            .append(ModelEntity.loadModelAsync(contentsOf: #fileLiteral(resourceName: "Soccer_Goal.usdz")))
            .collect()
            .sink(receiveCompletion: { error in
                print("ERROR : \(error)")
                cancellable?.cancel()
            }, receiveValue: { entities in
                for entity in entities {
                    print("\(entity) herre addd ////////////////////////////////////////////////")
                    entity.setScale(SIMD3<Float>(0.02 , 0.02 , 0.02), relativeTo: anchor)
                    entity.generateCollisionShapes(recursive: true)
                    ball2prof.append(entity)
                    anchor.addChild(entity)
                    cancellable?.cancel()
                }
            })
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}


struct ball2CONTROLLER: View {
    
    @Binding var Gamesit: String
    
    var body: some View {
        HStack(spacing: UIScreen.main.bounds.size.width/3.4){
            Button{
                print("spring PRESSED")
            } label : {
                ball2spring(imagename: "figure.wave.circle")
            }
            ZStack{
                Joystick(Gamesit: $Gamesit)
                    .offset(x: 50, y: 0.0)
            }
        }
    }
}




struct ball2spring: View {
    
    let imagename: String
    
    @State var ButtonText = "Start"
    
    var body: some View {
        Button{
            if ButtonText == "Start"{
                ball2prof[1].position.x = -0.5
                ball2prof[2].position.x = 0.5
                ball2prof[2].transform.rotation = simd_quatf(angle: .pi, axis: [0,1,0])
                
                ButtonText = "Bounce"
            }
            else{
                print("ARROW \(imagename) PRESSED")
                ball2ArrowsClicked(Arrow: imagename)
            }
        } label : {
            Image(systemName: "arrowtriangle.up.circle.fill")
                .resizable()
                .frame(width: 170 ,height: 170)
                .aspectRatio(1/1, contentMode: .fit)
                .padding(20)
                .foregroundColor(.green)
        }
        .cornerRadius(15)
        .overlay(
            Text("\(ButtonText)")
                .offset(x: 0, y: 50)
                .font(.title)
                .foregroundColor(.white)
        )
    }
}


func ball2ArrowsClicked(Arrow: String){
    
    switch Arrow {
    case "figure.wave.circle":
        ball2jump(time: 0.0 , u : 5)
    default:
        print(Arrow)
    }
    
}


func ball2jump(time: Float , u: Float){
    
    let newDistance = (Float(u)*time) - 5*pow(time, 2.0)
    print(newDistance)
    if !(newDistance < 0) {
        let seconds = 0.03
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            ball2prof[0].position.y = (newDistance/50)*3
            ball2jump(time: time+0.1 , u:u)
        }
    }
    else{
        let seconds = 0.03
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            ball2prof[0].position.y = 0
            //            code to give a bounce effect to ball
            if !(u < 2){
                ball2jump(time: 0 , u:u/1.5)
            }
        }
    }
}

func ball2GoLeft() {
    print("position of ball here \(ball2prof[0].position.x)")
    ball2prof[0].position.x -= 0.1
    
    if ball2prof[0].position.x < -0.499{
        print("hello here position here xi is jifooi")
        ContentView().Gamesit = "Stage2Question"
        
    }
}

func ball2GoRight() {
    print("position of ball here \(ball2prof[0].position.x)")
    ball2prof[0].position.x += 0.1
    
    if ball2prof[0].position.x > 0.499{
        ContentView().Gamesit = "Stage2Question"
        //        ball2().Gamesit = "Stage1Game"
    }
}

//
//struct ball2_Previews : PreviewProvider {
//    static var previews: some View {
//        ball2()
//            .previewDevice(PreviewDevice(rawValue: "iPad (8th generation)"))
////            .previewLayout(.fixed(width: 1024, height: 768))
//    }
//}


//code for JOystick ui ,, Controller for the GAme part2
import SwiftUI

struct Joystick: View {
    
    @Binding var Gamesit: String
    
    @State var isRotating = false
    @State var angleValue: CGFloat = 0.0
    
    var body: some View {
        
        ZStack{
            BackgroundView()
            
            Circle()
                .fill(Color.lightShadow)
                .overlay(
                    Circle()
                        .stroke(Color.dipCircle1 , lineWidth: 30)
                        .blur(radius: 5)
                    
                )
                .frame(width: 60, height: 60)
            
            Group {
                Circle()
                    .fill(Color.viewackground)
                    .overlay(
                        Circle()
                            .stroke(Color.white.opacity(0.5) , lineWidth: 3)
                            .blur(radius: 4)
                            .offset(x: 2, y: 2)
                            .mask(Circle())
                    )
                    .overlay(
                        Circle()
                            .stroke(Color.black.opacity(0.8) , lineWidth: 6)
                            .blur(radius: 4)
                            .offset(x: -2, y: -2)
                            .mask(Circle())
                    )
                    .frame(width: 90, height: 90)
                
                KnobTopCircles()
            }
            .offset(x: isRotating ? -30 : 0.0)
            .rotationEffect(.degrees(Double(angleValue)))
            
            //            IndicatorView()
            
            Circle()
                .fill(Color.white.opacity(0.001))
                .gesture(
                    DragGesture(minimumDistance: 0.0)
                        .onChanged({value in
                            self.change(location: value.location)
                        })
                        .onEnded({_ in
                            isRotating = false
                        })
                )
                .frame(width: 300, height: 300)
            
            //              Text("\(String.init(format: "%.0f" , angleValue))")
            //                  .font(.title)
            //                  .bold()
            //                  .foregroundColor(.black)
            //                  .offset(y:-300)
            
        }
    }
    private func change(location: CGPoint){
        let vector1 = CGVector(dx: location.x - 150, dy: location.y - 150)
        let vector2 = CGVector(dx: 0 - 150, dy: 0 - 150)
        
        let angleV1V2 = atan2(vector2.dy, vector2.dx) - atan2(vector1.dy, vector1.dx)
        
        var degree = angleV1V2 * CGFloat(180.0 / .pi)
        
        if degree < 0 { degree += 360}
        
        isRotating = true
        angleValue = 360 - degree
        fun()
        
    }
    
    func fun(){
        let zsin = sin(Double(Float(angleValue)) * Double.pi / 180)
        let xcos = cos(Double(Float(angleValue)) * Double.pi / 180)
        ball2Movement(sinus: Float(zsin), cosine: Float(xcos))
    }
    
    func ball2Movement(sinus: Float , cosine: Float){
        let z = 0.01 * sinus
        let x = 0.01 * cosine
        
        print("movement of z : \(z) and x: \(x)")
        
        if z < 0 && ball2prof[0].position.z >= -0.5{
            print(ball2prof[0].position.z)
            ball2prof[0].position.z -= z
        }
        
        else if z > 0 && ball2prof[0].position.z <= 0.5{
            print(ball2prof[0].position.z)
            ball2prof[0].position.z -= z
        }
        
        if x > 0 && ball2prof[0].position.x >= -0.5{
            print(ball2prof[0].position.x)
            ball2prof[0].position.x -= x
        }
        
        else if x < 0 && ball2prof[0].position.x <= 0.5{
            print(ball2prof[0].position.x)
            ball2prof[0].position.x -= x
        }
        
        
        //code to change view
        if ball2prof[0].position.x >= 0.499 && ((ball2prof[0].position.z - 0.0) <= 0.1 && (ball2prof[0].position.z - 0.0) >= -0.1){
            Gamesit = "Gameover"
        }
        
        else if ball2prof[0].position.x <= -0.499 && ((ball2prof[0].position.z - 0.0) <= 0.1 && (ball2prof[0].position.z - 0.0) >= -0.1){
            Gamesit = "Gameover"
        }
        
        
    }
    
    
}

struct IndicatorView: View{
    var body: some View{
        ZStack{
            Circle()
                .stroke(style: StrokeStyle(lineWidth: 6, lineCap: .round,dash: [1 ,40], dashPhase: 20))
                .frame(width: 250, height: 250)
            
            Circle()
                .trim(from: 0.0, to: 1.0)
                .stroke(RadialGradient(
                            gradient: Gradient(colors: [Color.white, Color.white.opacity(0.001)]),
                            center: .top,
                            startRadius: 0,
                            endRadius: 100) ,
                        style: StrokeStyle(lineWidth: 6, lineCap: .round)
                )
                .frame(width: 250, height: 250)
                .clipShape(
                    Circle()
                        .stroke(style: StrokeStyle(lineWidth: 6, lineCap: .round,dash: [1 ,40], dashPhase: 20))
                )
        }
    }
}

struct KnobTopCircles: View{
    var body: some View{
        ZStack{
            KnobView()
                .offset(x: 30)
            KnobView()
                .offset(x: -30)
            KnobView()
                .offset(y: 30)
            KnobView()
                .offset(y: -30)
        }
    }
}

struct KnobView: View{
    var body: some View{
        Circle()
            .fill(Color.clear)
            .overlay(
                Circle()
                    .stroke(Color.lightShadow , lineWidth: 4)
                    .blur(radius: 4)
                    .offset(x: 2, y: 2)
                    .mask(Circle())
            )
            .overlay(
                Circle()
                    .stroke(Color.darkShadow , lineWidth: 4)
                    .blur(radius: 4)
                    .offset(x: -2, y: -2)
                    .mask(Circle())
            )
            .frame(width: 8, height: 8)
    }
}

extension Color {
    static let viewackground = Color.init(red: 42/255 , green: 51/255 , blue: 67/255)
    static let lightShadow = Color.init(red: 47/255 , green: 56/255 , blue: 74/255)
    static let darkShadow = Color.init(red: 13/255 , green: 16/255 , blue: 24/255)
    
    static let dipCircle = LinearGradient(
        gradient: Gradient(colors: [lightShadow.opacity(0.3), darkShadow.opacity(0.3)]), startPoint: .topLeading , endPoint: .bottomTrailing
    )
    
    static let dipCircle1 = LinearGradient(
        gradient: Gradient(colors: [lightShadow, darkShadow]), startPoint: .topLeading , endPoint: .bottomTrailing
    )
    
}

//struct Joystick_Previews: PreviewProvider {
//    static var previews: some View {
//        Joystick()
//    }
//}

struct BackgroundView: View {
    var body: some View {
        Circle()
            .fill(Color.lightShadow)
            .overlay(
                Circle()
                    .stroke(Color.dipCircle , lineWidth: 50)
            )
            .overlay(
                Circle()
                    .stroke(Color.dipCircle , lineWidth: 35)
                    .blur(radius: 10)
                    .offset(x: 10.0, y: 10.0)
                    .mask(Circle().stroke(lineWidth: 40))
            )
            .overlay(
                Circle()
                    .stroke(Color.darkShadow.opacity(0.8) , lineWidth: 35)
                    .blur(radius: 10)
                    .offset(x: -10.0, y: -10.0)
                    .mask(Circle().stroke(lineWidth: 40))
            )
            .overlay(
                Circle()
                    .stroke(Color.lightShadow.opacity(0.9) , lineWidth: 35)
                    .blur(radius: 10)
                    .offset(x: 5.0, y: 5.0)
                    .mask(Circle().stroke(lineWidth: 40))
            )
            .overlay(
                Circle()
                    .stroke(Color.darkShadow.opacity(0.8) , lineWidth: 35)
                    .blur(radius: 10)
                    .offset(x: -5.0, y: -5.0)
                    .mask(Circle().stroke(lineWidth: 40))
            )
            .overlay(
                Circle()
                    .stroke(Color.lightShadow , lineWidth: 6)
                    .blur(radius: 4)
                    .offset(x: 2.0, y: 2.0)
            )
            .overlay(
                Circle()
                    .stroke(Color.darkShadow , lineWidth: 6)
                    .blur(radius: 4)
                    .offset(x: -2.0, y: -2.0)
            )
            
            .frame(width: 120, height: 120)
    }
}




PlaygroundPage.current.setLiveView(ContentView())

