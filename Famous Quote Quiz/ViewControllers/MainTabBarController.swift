//
//  MainTabBarController.swift
//  Famous Quote Quiz
//
//  Created by Dobromir Penev on 25.06.18.
//  Copyright © 2018 Dobromir Penev. All rights reserved.
//

import UIKit

class MainTabBarController: UIViewController {
    
    // MARK: - outlets and variables
    
    @IBOutlet var trueFalseModeView: UIView!
    @IBOutlet var multipleChoiceModeView: UIView!
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var singleAnswerLabel: UILabel!
    @IBOutlet weak var questionTrackerLabel: UILabel!
    @IBOutlet weak var scoreTrackerLabel: UILabel!
    @IBOutlet weak var progressVIew: UIView!
    @IBOutlet weak var multipleChoiceButton1: UIButton!
    @IBOutlet weak var multipleChoiceButton2: UIButton!
    @IBOutlet weak var multipleChoiceButton3: UIButton!
    
    var modeViewIndex = Indexes.trueFalseMode
    
    var qoutes = Quotes.init()
    var questionBank = [Question]()
    var questionCounter = 0
    var score = 0
    
    var correctAnswerAuthor = ""
    var singleAuthor = Author()
    var authorArray = [Author]()
    
    // MARK: - lifecycle events
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionBank = createQuestionBank(numberOfQuestions: 10)
        setUpView(viewIndex: modeViewIndex)
        loadQuestion()
        addObservers()
    }

    // MARK: - functions, methods and actions
    
    /**
     generate random number and take that index author of other quotes for wrong answers
     check if "fake" author is same as authentic author and if is same call its self to generate new "fake" author
     */
    func generateRandomAuthor(authenticAuthor: String)->Author{
        
        let randomNumber = Int(arc4random_uniform(UInt32(qoutes.list.count)))
        var fakeAuthor = qoutes.list[randomNumber].author
        
        if authenticAuthor.isEqual(fakeAuthor) {
          fakeAuthor = generateRandomAuthor(authenticAuthor: authenticAuthor).name
        }
        
        return Author(authorName: fakeAuthor, authentic: false)
    }
    
    /**
     take one quote from quote list adds this author then generate two "fake" authors
     :returns: object Question
     */
    func createQuestion()->Question{
        
        let randomNumber = Int(arc4random_uniform(UInt32(qoutes.list.count)))
        
        let quote = qoutes.list[randomNumber]
        
        var authors = [Author]()
        let authenticAuthor = quote.author
        
        let fakeAuthor = generateRandomAuthor(authenticAuthor: authenticAuthor)
        var fakeAuthor2 = generateRandomAuthor(authenticAuthor: authenticAuthor)
        
        if fakeAuthor2.name == fakeAuthor.name {
            while fakeAuthor.name == fakeAuthor2.name {
                fakeAuthor2 = generateRandomAuthor(authenticAuthor: authenticAuthor)
            }
        }
        
        authors.append(Author(authorName: authenticAuthor, authentic: true))
        authors.append(Author(authorName: fakeAuthor.name, authentic: false))
        authors.append(Author(authorName: fakeAuthor2.name, authentic: false))
        
        return Question(text: quote.quote, authors: authors)
    }
    
    /**
     create array of questions
     */
    func createQuestionBank(numberOfQuestions: Int)->[Question]{
        
        var arrayOfQuestions = [Question]()
        
        for _ in 0..<numberOfQuestions {
            arrayOfQuestions.append(createQuestion())
        }
        
        return arrayOfQuestions
    }
    
    /**
     add subview depend on selected mode
     */
    func setUpView(viewIndex: Int){
        
        if viewIndex == Indexes.trueFalseMode {
            baseView.addSubview(trueFalseModeView)
            trueFalseModeView.frame.size.width = view.frame.size.width
            return
        }
        
        if viewIndex == Indexes.multipleChoiceMode {
            baseView.addSubview(multipleChoiceModeView)
            multipleChoiceModeView.frame.size.width = view.frame.size.width
            return
        }
        
    }
    
    /**
     take one question from question bank and depend on mode fill the labels/buttons
     */
    func loadQuestion(){
        
        let qestion = questionBank[questionCounter]
        
        quoteLabel.text = qestion.quoteText

        correctAnswerAuthor = qestion.authors[0].name
        
        if modeViewIndex == Indexes.trueFalseMode {
            
            let randomNumber = Int(arc4random_uniform(2))
            singleAuthor = qestion.authors[randomNumber]
            
            singleAnswerLabel.text = singleAuthor.name
        }
        
        if modeViewIndex == Indexes.multipleChoiceMode {
            
            authorArray = qestion.authors
            authorArray.shuffle()
            
            multipleChoiceButton1.setTitle("\(authorArray[0].name)", for: .normal)
            multipleChoiceButton2.setTitle("\(authorArray[1].name)", for: .normal)
            multipleChoiceButton3.setTitle("\(authorArray[2].name)", for: .normal)
        }
        
        questionCounter += 1
        updateUI()
    }
    
    /**
     updating UI
     showing current question number, score and progress
     */
    func updateUI(){
    
        questionTrackerLabel.text = " Qestion : \(questionCounter)/10"
        scoreTrackerLabel.text = "Score : \(score)  "
        progressVIew.frame.size.width = (view.frame.size.width / 10) * CGFloat(questionCounter)
    }
    
    
    /**
     in true or false mode compares authentic property of presented author with what user select
     */
    func checkTrueOrFalseAnswer(selectedAnswer: Bool)->Bool{
        
        if singleAuthor.authentic == selectedAnswer {
            score += 1
            return true
        }
        else {
            return false
        }
    }
    
    /**
     in Multiple Choice mode check the selected author authentic property (if is true is correct author)
     :param: every one of buttons have tag, the tag is same as the index of author in the array of authors
     */
    func checkMultipleChoiceAnswer(tag: Int)->Bool {
        
        let result = authorArray[tag].authentic
        
        if result { score += 1 }
        
        return result
    }
    
    /**
     check if current question is less then 10th and if it is load next question else perform segue to score screen
     */
    func okHandeler(alert: UIAlertAction!){
        
        if questionCounter < 10 {
            loadQuestion()
        } else {
            performSegue(withIdentifier: Identificators.goToScoreId, sender: self)
        }
    }
    
    /**
     creates alert saying if user gets the answer right or wrong and tell him which is the right answer
     */
    func createAlert(result: Bool){
        
        let correctAnswer = "Correct!"
        let wrongAnswer = "Sorry, you are wrong!"
        let title = result ? correctAnswer : wrongAnswer
        let message = "The right answer is : \(correctAnswerAuthor)"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: okHandeler))
        present(alert, animated: true, completion: nil)
    }
    
    /**
     adding observers for restarting the quiz and to change mode
     */
    func addObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(MainTabBarController.restartQuiz), name: NSNotification.Name(rawValue: Identificators.notificationRestart), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(MainTabBarController.changeMode), name: NSNotification.Name(rawValue: Identificators.notificationChangeMode), object: nil)
    }
    
    /**
     check what user choose in true of false mode
     check answer
     and create alert to inform the user
     */
    @IBAction func trueOrFalsePressed(_ sender: UIButton) {
        
        let selectedAnswer = sender.tag == 1 ? true : false
        let answer = checkTrueOrFalseAnswer(selectedAnswer: selectedAnswer)
        
        createAlert(result: answer)
    }
    
    /**
     check what user choose in multiple choice mode
     check answer
     and create alert to inform the user
     */
    @IBAction func multipleChoicePressed(_ sender: UIButton) {
        
       let answer = checkMultipleChoiceAnswer(tag: sender.tag)
        createAlert(result: answer)
    }
    
    /**
     reset counters
     generate new 10 questions and
     load the first one
     */
    @objc func restartQuiz(){
        questionCounter = 0
        score = 0
        questionBank = createQuestionBank(numberOfQuestions: 10)
        loadQuestion()
    }
    
    /**
     change between true of false mode and multiple choice mode
     */
    @objc func changeMode(){
        modeViewIndex == Indexes.trueFalseMode ? (modeViewIndex = Indexes.multipleChoiceMode) : (modeViewIndex = Indexes.trueFalseMode)
        restartQuiz()
        setUpView(viewIndex: modeViewIndex)
    }
    
    /**
     accesses the score variable on score view controller and give it value of the current score
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Identificators.goToScoreId {
            let destination = segue.destination as? ScoreViewController
            destination?.score = self.score
            return
        }
    }
    
}
