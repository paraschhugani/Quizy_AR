/*:
 # QuizyAR
 
 ## Introduction to this Playground Book
 This Book is my submission for WWDC Swift Student Challenge  2021.
 
 It allows you to Test your self with Quiz and with a right Answer you get
 to play an Augmented Reality intreractive game.

 The game after the Right answer trigers a reward system for students to learn more and enjoy at the same time
 */
 
/*:
# Please:
* 1. Use the app in Portrait mode
* 2. Have [1 meter square Area](https://www.google.com/search?q=1+meter+square) plane  in front of you for best UI experience with ArView.
* 3. Make sure to have "Enable Results" off:
 
 ![contrller image](enabel.png)
 
 */

/*:
 # Game Level 1
 
 ## Anwer this easy Question and you will play AR Game level 1
 
 # Points to consider here:
 
 
 
 * ### Step 1:
 Please make sure to use Live View in full screen in [Portrait mode](https://github.com/paraschhugani).
 * ### Step 2:
 Detecting a Horizontal plane and you will be able to see a basketball and a goal post , make sure you have good lights and only Hit start button.
 ![contrller image](BallAndGoal.png)
 * ### Step 3:
 Now you can play the game using purple controller .
   also you can use Bounce Button to bounce the ball.
 
 
  ![contrller image](purplebutton.png)
 
  */


/*:
  Game Level 2 -> click [here](@next) to go to [Game stage 2](@next). I hear its awesome.
 */



/*:
 # Credits
 1. 3D  Objects  ->
 Basketball  and Goal-post : [Turbo squid free Resources](https://www.turbosquid.com/3d-model/free/basketball-ball?synonym=basketball+(ball)) .
 
 2. USDZ converter ->
 Obj to usdz : [Apple's  Reality Converter](https://developer.apple.com/news/?id=01132020a) .
 
 3. And last but not the least : [Apple Documentation](https://developer.apple.com/documentation/) and  help from [Swift Forums](https://forums.swift.org/) .
 */
//update 18:02 17 APR


import SwiftUI
import PlaygroundSupport


struct ContentView : View {
    
    @State var Gamesit = "Stage1Question"
    
    var body: some View {
        ZStack(alignment: .bottom, content: {
            
            Text(" Stage 1 completed , Go on next page .... !!")
                .font(.system(size: 85))
                .bold()
                .foregroundColor(.green)
                .offset(x: 0.0, y: -150.0)
                .frame(alignment: .center)
            
            if Gamesit == "Stage1Question"{
                quiz1(Gamesit: $Gamesit, questionNo: 0)
                    .offset(x: 0.0, y: -40.0)
                    .overlay(
                        Text("Stage 1")
                            .font(.system(size: 60))
                            .bold()
                            .foregroundColor(.blue)
                            .offset(x: 00, y: -350.0)
                    )
            }
            
            else if Gamesit == "Stage1Game"{
                ball1(Gamesit: $Gamesit)
            }
            
        })
        
    }
}


//code for quizUI 1 
struct quiz1: View {
    
    @Binding var Gamesit: String
    
    let questionNo: Int
    
    var body: some View {
        
        ZStack{
            
            Image(uiImage: #imageLiteral(resourceName: "part 1 (1).png"))
                .resizable()
                .frame(width: 730, height: 700, alignment: .center)
                .cornerRadius(100)
                .offset(x: 0.0, y: 100.0)
            
            
            Button(action: {
                
                Gamesit = "Stage\(questionNo + 1)Game"
                
            }, label: {
                Text("Next")
                    .foregroundColor(.white)
                    .frame(width: 200, height: 70, alignment: .center)
                    .background(Color.blue)
                    .cornerRadius(100)
                    .font(.title)
            }).offset(x: 230.0, y: 380.0)
            
            Q1Element(questionNumber: questionNo, Gamesit: $Gamesit)
            
        }
    }
}

struct Q1Element: View {
    
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
            
            
            Answerquiz1(Gamesit: $Gamesit, optionName: "A", optionText: quizBrain.getAnswers(questionNumber: questionNumber)[0] , questionNO: questionNumber)
            Answerquiz1(Gamesit: $Gamesit, optionName: "B", optionText: quizBrain.getAnswers(questionNumber: questionNumber)[1] , questionNO: questionNumber)
            Answerquiz1(Gamesit: $Gamesit, optionName: "C", optionText: quizBrain.getAnswers(questionNumber: questionNumber)[2] , questionNO: questionNumber)
        }).offset(x: 150.0, y: 50.0)
    }
    
}

struct Answerquiz1: View {
    
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
                
                Gamesit = "Stage1Game"
                
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




import SwiftUI
import RealityKit
import Combine

//code for ball ArView Game1
var ball1prof:[Entity] = []

struct ball1: View {
    @Binding var Gamesit: String
    
    @State private var startgameopacity = 1.0
    
    var body: some View {
        
        ZStack(alignment: .bottom, content: {
            
            
            ARViewContainerball1()
                .edgesIgnoringSafeArea(.all)
            
            ball1CONTROLLER(Gamesit: $Gamesit)
            
            
        })
        .overlay(
            Text("Make a goal")
                .font(.system(size: 60))
                .bold()
                .foregroundColor(.blue)
                .offset(x: 0.0, y: -350.0)
        )
        
    }
}




struct ARViewContainerball1: UIViewRepresentable {
    
    //      let arView = ARView(frame: .zero)
    let arView = ARView(frame: .zero, cameraMode: .ar, automaticallyConfigureSession: true)
    //      arView.enableTapGesture()
    
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
                    ball1prof.append(entity)
                    anchor.addChild(entity)
                    cancellable?.cancel()
                }
            })
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

//ball1 controller with pruple BUttons on right
struct ball1CONTROLLER: View {
    
    @Binding var Gamesit: String
    
    var body: some View {
        HStack(spacing: UIScreen.main.bounds.size.width/4.0){
            Button{
                print("PUNCH PRESSED")
            } label : {
                ball1spring(imagename: "figure.wave.circle") }
            .padding(20)
            ZStack{
                VStack(spacing: 10 ){
                    HStack (spacing: 10){
                        ball1Buttoun(Gamesit: $Gamesit, imagename: "arrow.left")
                        Image(systemName: "command.circle")
                            .resizable()
                            .frame(width: 40 ,height: 40)
                            .aspectRatio(1/1, contentMode: .fit)
                            .padding(20)
                            .foregroundColor(.white)
                        ball1Buttoun(Gamesit: $Gamesit, imagename: "arrow.right")
                    }
                    .background( Color.purple)
                    .cornerRadius(32)
                }
            }
        }
    }
}


struct ball1Buttoun: View {
    
    @Binding var Gamesit: String
    
    let imagename: String
    
    var body: some View {
        Button{
            print("ARROW \(imagename) PRESSED")
            
            arowClicked(Arrow: imagename)
            
            
            
        } label : {
            Image(systemName: imagename)
                .resizable()
                .frame(width: 40 ,height: 40)
                .aspectRatio(1/1, contentMode: .fit)
                .padding(20)
                .foregroundColor(.white)
        }
        .background( Color.purple)
        .cornerRadius(15)
    }
    
    
    func arowClicked(Arrow: String){
        
        switch Arrow {
        case "arrow.left":
            arrowGoLeft()
        case "arrow.right":
            arrowGoRight()
        default:
            print(Arrow)
        }
        
    }
    
    func arrowGoLeft() {
        
        
        print("position of ball here \(ball1prof[0].position.x)")
        ball1prof[0].position.x -= 0.1
        
        if ball1prof[0].position.x < -0.499{
            print("level 1 complete")
            
            
            Gamesit = "Stage2Question"
        }
    }
    
    func arrowGoRight() {
        print("position of ball here \(ball1prof[0].position.x)")
        ball1prof[0].position.x += 0.1
        
        if ball1prof[0].position.x > 0.499{
            print("level 1 complete")
            
            Gamesit = "Stage2Question"
        }
    }
    
}


struct ball1spring: View {
    
    let imagename: String
    
    @State var ButtonText = "Start"
    
    var body: some View {
        Button{
            if ButtonText == "Start"{
                ball1prof[1].position.x = -0.5
                ball1prof[2].position.x = 0.5
                ball1prof[2].transform.rotation = simd_quatf(angle: .pi, axis: [0,1,0])
                
                ButtonText = "Bounce"
            }
            else{
                print("ARROW \(imagename) PRESSED")
                ball1ArrowsClicked(Arrow: imagename)
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

func ball1ArrowsClicked(Arrow: String){
    
    switch Arrow {
    case "figure.wave.circle":
        ball1jump(time: 0.0 , u : 5)
    case "arrow.left":
        ball1GoLeft()
    case "arrow.right":
        ball1GoRight()
    default:
        print(Arrow)
    }
    
}
func ball1jump(time: Float , u: Float){
    
    let newDistance = (Float(u)*time) - 5*pow(time, 2.0)
    print(newDistance)
    if !(newDistance < 0) {
        let seconds = 0.03
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            ball1prof[0].position.y = (newDistance/50)*3
            ball1jump(time: time+0.1 , u:u)
        }
    }
    else{
        let seconds = 0.03
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            ball1prof[0].position.y = 0
            //            code to give a bounce effect to ball
            if !(u < 2){
                ball1jump(time: 0 , u:u/1.5)
            }
        }
    }
}

func ball1GoLeft() {
    print("position of ball here \(ball1prof[0].position.x)")
    ball1prof[0].position.x -= 0.1
    
    if ball1prof[0].position.x < -0.499{
        print("hello here position here xi is jifooi")
        ContentView().Gamesit = "Stage2Question"
        
    }
}

func ball1GoRight() {
    print("position of ball here \(ball1prof[0].position.x)")
    ball1prof[0].position.x += 0.1
    
    if ball1prof[0].position.x > 0.499{
        ContentView().Gamesit = "Stage2Question"
        //        ball1().Gamesit = "Stage1Game"
    }
}




PlaygroundPage.current.setLiveView(ContentView())

