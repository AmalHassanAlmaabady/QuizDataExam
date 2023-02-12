

import UIKit

struct QuizData {
    static var data = [
        Dataset(
            questionString: "Who was one of the creators of the Swift languages?",
        correctAnswer : 1,
        answerA : "Steve Jobs",
        answerB : "Chris Lattner",
        answerC : "Steve Wozniak",
        answerD : "Ronald Wayne"
        ),
        Dataset(
            questionString: "Apple was cewated in what year?",
        correctAnswer : 0,
        answerA : "1976",
        answerB : "1989",
        answerC : "1990",
        answerD : "2002"
        ),
        Dataset(
            questionString: "The first iphone was released on what day?",
        correctAnswer : 0,
        answerA : "June 2007",
        answerB : "October 2010",
        answerC : "May 2011",
        answerD : "June 2011"
        ),
        Dataset(
            questionString: "The currect iphone has 6GB RAM. The first iphone had how much RAM?",
        correctAnswer : 2,
        answerA : "1 GB ",
        answerB : "3 GB ",
        answerC : "128 MB ",
        answerD : "It had no RAM "
        ),
        Dataset(
            questionString: "When was Objective-C Created?",
            correctAnswer : 3,
            answerA : "1961",
            answerB : "1976",
            answerC : "1980",
            answerD : "1984"
        ),
    ]
}

struct Dataset {
    var questionString = String()
    var correctAnswer = Int()
    var answerA = String()
    var answerB = String()
    var answerC = String()
    var answerD = String()
}
struct QuizBank{
    static var quizzes = [QuizData]()
}

class ViewController: UIViewController {

    //IBOutlet of questions view
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var firstChoic: UIButton!
    @IBOutlet weak var secondChoic: UIButton!
    @IBOutlet weak var thirdChoic: UIButton!
    @IBOutlet weak var fourthChoic: UIButton!
    @IBOutlet weak var firstView: UIView! // view of questions
    
    //IBOutlet of correct view
    @IBOutlet weak var correctView: UIView!
    @IBOutlet weak var textOfCorrectAnswer: UILabel!
    
    //IBOutlet of incorrect view
    @IBOutlet weak var incorrectView: UIView!
    @IBOutlet weak var textOfIncorrectAnswer: UILabel!
    
    //IBOutlet of result view
    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var textOfResultScore: UILabel!
    
    var countCorrestAnswer = 0 // Count the correct answer
    var counterOfquestions = 0 // Count the number of question
    var correctAnswerForEachQuestion = 0 // Correct answer for each question
    
    @IBOutlet weak var sizeOfProgressBar: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        design()
        showQuestion()
        
    }
    
    func design(){ // For design each lable and buttons like cornerRadius and borderColor
        
        questionLabel.layer.masksToBounds = true
        questionLabel.layer.cornerRadius = 4
        
        firstChoic.layer.cornerRadius = firstChoic.frame.height / 2
        firstChoic.layer.borderWidth = 2
        firstChoic.layer.borderColor = UIColor.white.cgColor
        
        secondChoic.layer.cornerRadius = secondChoic.frame.height / 2
        secondChoic.layer.borderWidth = 2
        secondChoic.layer.borderColor = UIColor.white.cgColor
        
        thirdChoic.layer.cornerRadius = thirdChoic.frame.height / 2
        thirdChoic.layer.borderWidth = 2
        thirdChoic.layer.borderColor = UIColor.white.cgColor
        
        fourthChoic.layer.cornerRadius = fourthChoic.frame.height / 2
        fourthChoic.layer.borderWidth = 2
        fourthChoic.layer.borderColor = UIColor.white.cgColor
        
    }
    
    func showQuestion(){
        firstView.isHidden = false // show the questions view
        correctView.isHidden = true // Hidden the correct answer view
        incorrectView.isHidden = true // Hidden the incorrect answer view
        resultView.isHidden = true // Hidden the result view
        
        if counterOfquestions == 5 { // check if finish the quiz show the result else will show next question
            showTotalScore()
        }else{
            sizeOfProgressBar.progress = Float((counterOfquestions) + 1) / 5 // show the progress bar under lable of question
            let dataOfQuiz = QuizData.data[counterOfquestions]
            questionLabel.text = dataOfQuiz.questionString
            firstChoic.setTitle(dataOfQuiz.answerA, for: .normal)
            secondChoic.setTitle(dataOfQuiz.answerB, for: .normal)
            thirdChoic.setTitle(dataOfQuiz.answerC, for: .normal)
            fourthChoic.setTitle(dataOfQuiz.answerD, for: .normal)
            correctAnswerForEachQuestion = dataOfQuiz.correctAnswer
        }
    }
    
    func showTotalScore () {
        firstView.isHidden = true // Hidden the questions view
        correctView.isHidden = true // Hidden the correct answer view
        incorrectView.isHidden = true // Hidden the incorrect answer view
        resultView.isHidden = false // show the result view
        textOfResultScore.text = "Your score is : \(countCorrestAnswer) out of 5"
        
    }
    
    func lableOfCorrestAnswer(){
        firstView.isHidden = true // Hidden the questions view
        correctView.isHidden = false // show the correct answer view
        incorrectView.isHidden = true // Hidden the incorrect answer view
        resultView.isHidden = true // Hidden the result view
        let dataOfQuiz = QuizData.data[counterOfquestions]
        if correctAnswerForEachQuestion == 0{
            textOfCorrectAnswer.text = "\(dataOfQuiz.answerA) \nCorrect !\nScore : \(countCorrestAnswer)"
        }else if correctAnswerForEachQuestion == 1{
            textOfCorrectAnswer.text = "\(dataOfQuiz.answerB) \nCorrect !\nScore : \(countCorrestAnswer)"
            textOfCorrectAnswer.textColor = .white
        }else if correctAnswerForEachQuestion == 2{
            textOfCorrectAnswer.text = "\(dataOfQuiz.answerC) \nCorrect !\nScore : \(countCorrestAnswer)"
            textOfCorrectAnswer.textColor = .white
        }else{
            textOfCorrectAnswer.text = "\(dataOfQuiz.answerD) \nCorrect !\nScore : \(countCorrestAnswer)"
            textOfCorrectAnswer.textColor = .white
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+3.0, execute: self.showQuestion) // deadline to go to next questions
    }
    
    func lableOfIncorrestAnswer() {
        textOfIncorrectAnswer.text = "NOT QUITE"
        firstView.isHidden = true // Hidden the questions view
        correctView.isHidden = true // Hidden the correct answer view
        incorrectView.isHidden = false // show the incorrect view
        resultView.isHidden = true // Hidden the result view
        DispatchQueue.main.asyncAfter(deadline: .now()+3.0, execute: self.showQuestion) // deadline to go to next questions
    }
    
    //IBAction
    @IBAction func firstChoicAction(_ sender: Any) {
        if (correctAnswerForEachQuestion == 0){ // check if correct answer is first choic or not
            countCorrestAnswer += 1 // increase the score
            lableOfCorrestAnswer() // show the correct answer view
        }else{
            lableOfIncorrestAnswer()// show the incorrect answer view
        }
        counterOfquestions += 1 // increase the counter to go to next question
        
    }

    
    @IBAction func secondChoicAction(_ sender: Any) {
        if (correctAnswerForEachQuestion == 1){ // check if correct answer is second choic or not
            countCorrestAnswer += 1 // increase the score
            lableOfCorrestAnswer() // show the correct answer view
        }else{
            lableOfIncorrestAnswer()// show the incorrect answer view
        }
        counterOfquestions += 1// increase the counter to go to next question
    }
    
    @IBAction func thirdChoicAction(_ sender: Any) {
        if (correctAnswerForEachQuestion == 2){ // check if correct answer is third choic or not
            countCorrestAnswer += 1 // increase the score
            lableOfCorrestAnswer() // show the correct answer view
        }else{
            lableOfIncorrestAnswer()// show the incorrect answer view
        }
        counterOfquestions += 1// increase the counter to go to next question
    }
    
    
    @IBAction func fourthChoicAction(_ sender: Any) {
        if (correctAnswerForEachQuestion == 3){ // check if correct answer is fourth choic or not
            countCorrestAnswer += 1 // increase the score
            lableOfCorrestAnswer() // show the correct answer view
        }else{
            lableOfIncorrestAnswer() // show the incorrect answer view
        }
        counterOfquestions += 1// increase the counter to go to next question
        
    }
    
}

