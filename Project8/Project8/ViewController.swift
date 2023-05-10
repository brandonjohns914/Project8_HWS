//
//  ViewController.swift
//  Project8
//
//  Created by Brandon Johns on 4/27/23.
//

import UIKit

class ViewController: UIViewController {
    
    //UILabel
    var cluesLabel: UILabel!
    var answersLabel: UILabel!
    var scoreLabel: UILabel!
    
    //UITextField
    var currentAnswer: UITextField!                                                             //Users Current answer
   
    //Button
    var letterButtons = [UIButton]()
    var activatedButtons = [UIButton]()
    let submit = UIButton(type: .system)
    let clear = UIButton(type: .system)
    
    //UIView
    let buttonsView = UIView()                                                                                                                          //center on screen
    
    var solutions = [String]()
    var level: Int = 1
    
    var score: Int = 0
    {
        didSet
        {
            scoreLabel.text = "Score: \(score)"
        }//didset
    }//score
    
    
    override func loadView() {
        view = UIView()                                                                                         // parent of all UIkit
                                                                                                                //creates a big empty view
        view.backgroundColor = .white
        
        
        //scoreLabel
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false                                            // making autolayout constraints by hand
        scoreLabel.textAlignment = .right                                                                       //aligns text to right
        scoreLabel.text = "Score: 0"
        view.addSubview(scoreLabel)
        
        
        //cluesLabel
        cluesLabel = UILabel()
        cluesLabel.translatesAutoresizingMaskIntoConstraints = false
        cluesLabel.font = UIFont.systemFont(ofSize: 24)
        cluesLabel.text = "CLUES"
        cluesLabel.numberOfLines = 0
        cluesLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(cluesLabel)
        
        
        //answersLabel
        answersLabel = UILabel()
        answersLabel.translatesAutoresizingMaskIntoConstraints = false
        answersLabel.font = UIFont.systemFont(ofSize: 24)
        answersLabel.text = "ANSWERS"
        answersLabel.textAlignment = .right
        answersLabel.numberOfLines = 0
        answersLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(answersLabel)
        
        
        //currentAnswer
        currentAnswer = UITextField()
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.placeholder = "Tap letters to guess"
        currentAnswer.textAlignment = .center
        currentAnswer.font = UIFont.systemFont(ofSize: 44)
        currentAnswer.isUserInteractionEnabled = false                                           // stops keyboard from showing up so users cannot type
        view.addSubview(currentAnswer)
        
        
        //submit
        submit.translatesAutoresizingMaskIntoConstraints = false
        submit.setTitle("SUBMIT", for: .normal)
        submit.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)            // user pressed call submitTapped
                                                                                                //self = submit button
                                                                                                // .touchUpInside user pressed down on the botton
                                                                                                // user pressed submit call submit
        view.addSubview(submit)
        
        
        //clear
        clear.translatesAutoresizingMaskIntoConstraints = false
        clear.setTitle("CLEAR", for: .normal)
        submit.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)            // user pressed call clearTapped
                                                                                                //self = submit button
                                                                                                // .touchUpInside user pressed down on the botton
                                                                                                // user pressed submit call submit
        view.addSubview(clear)
        
        
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)
        
                                                                                                // sets the constraints an array
        NSLayoutConstraint.activate([
                                                                                                //layoutMarginsGuide = the layouts dont run into the left and right margins of the screen
                                                                                                //              indented on each edge
            
            
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),          // top pins it to the top of the screen
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor), // right pins it to the right of the screen
            
            
                                                                                                    // pin the top of the clues label to the bottom of the score label
            cluesLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),                      // clues label top is equal to score bottom
            
                                                                                                                    // pin the leading edge of the clues label to the leading edge of our layout margins
                                                                                                                    // adding 100 for some space
            cluesLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 100),   //left
                                                                                                                  // leading edge to the leading anchor
                                                                                                                  // constant of 100 for space
            cluesLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.6, constant: -100),
                                                                                                                // Margin from the left
                                                                                                                // 60% of the screen and subtract 100 for indent
                                                                                                        
            
                                                                                                                //pin the top of the answers label to the bottom of the score label
            answersLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),                                // equal to the score label
            answersLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -100),
                                                                                                                //answers label  trailing edge of margins minus 100
            answersLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.4, constant: -100),
                                                                                                                // width of 40% of the screen minus 100
            answersLabel.heightAnchor.constraint(equalTo: cluesLabel.heightAnchor),                              //answers matches height of clues
            
            
            
            
            currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),                                //centers horizontally
            currentAnswer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),                   // half width of the screen
            currentAnswer.topAnchor.constraint(equalTo: cluesLabel.bottomAnchor, constant: 20),                 // 20 points below clues label
            
            
            
            submit.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor),                                   // equal current answer bottom
            submit.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),                       // equal to view horizontal minus 100
            submit.heightAnchor.constraint(equalToConstant: 44),                                                //44 size of the botton
            
            clear.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),                         // equal to view horizontal plus 100
            clear.centerYAnchor.constraint(equalTo: submit.centerYAnchor),                                      // centers vertially based on submit button
            clear.heightAnchor.constraint(equalToConstant: 44),                                                 // 44 size
            
            buttonsView.widthAnchor.constraint(equalToConstant: 750),                                           //buttons view is 750X320
            buttonsView.heightAnchor.constraint(equalToConstant: 320),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),                                  // anchoring it horizontally
            buttonsView.topAnchor.constraint(equalTo: submit.bottomAnchor, constant: 20),                       // 20 points space from submit button
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant:  -20)  // setting it to view bottom layout minus 20
            ]) // end of array
        
        let width = 150
        let height = 80
        
                                                                                                                // 20 buttons 4X5 grid
        for row in 0..<4                                                                                        //button rows of 0-3
        {
            for column in 0..<5                                                                                 // button columns 0-5
            {
                
                                                                                                                //creates new button of size 36
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
                
                
                letterButton.setTitle("WWW", for: .normal)                                                      //button temp text
                
                letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)              // call letterTapped when any letterbutton is tapped
                
                                                                                                                // calculates frame of the button using row and cols
                let frame = CGRect(x: column * width, y: row * height, width: width, height: height)
                letterButton.frame = frame
                
                buttonsView.addSubview(letterButton)                                                            //add to buttons view
                letterButtons.append(letterButton)                                                              // add to buttons array
            }//column
        }//row
    }//loadView
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLevel()
        
        
        
    }//viewDidLoad

    @objc func letterTapped(_ sender: UIButton)
    {
        guard let buttonTitle = sender.titleLabel?.text else {return}                                           // if not title exit letter tapped
        
        currentAnswer.text = currentAnswer.text?.appending(buttonTitle)                                         // moves current answer to text view
        activatedButtons.append(sender)                                                                         // sender when the user tapps  it
                                                                                                                // holds all buttons player as tapped before submitted
        
        sender.isHidden = true                                                                                  // hides button after is tapped
        
    }//LetterTapped
    
    @objc func submitTapped(_ sender: UIButton)
    {
        guard let answerText = currentAnswer.text else {return}                                                // checks to make sure exists if not exit
        
        if let solutionPosition = solutions.firstIndex(of: answerText)                                         // firstIndex of = which solution matched users choice
        {
            activatedButtons.removeAll()                                                                       // removes user activated button
            
            var splitsAnswers = answersLabel.text?.components(separatedBy: "\n")
            
            splitsAnswers?[solutionPosition] = answerText
            answersLabel.text = splitsAnswers?.joined(separator: "\n")                                         // joins the buttons that were tapped into one word
            
            currentAnswer.text = ""
            score += 1                                                                                         // adds score
            
            if score % 7 == 0                                                                                  // 7 questions all answered move on to next level
            {
                let ac = UIAlertController(title: "Well Done!", message: "Are you ready for the next level?", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Lets Go!", style: .default, handler: levelUp))
                present(ac, animated: true)
            }//end if
            
        }//solutionPosition
        
    }//submitTapped
    
    
    func levelUp(action: UIAlertAction)
    {
        level += 1                                                                                              // moves on to level2.txt and so on 
        solutions.removeAll(keepingCapacity: true)                                                              // keeps first level answers moves onto next level
        loadLevel()                                                                                             //loads the new level
        
        for button in letterButtons
        {
            button.isHidden = false
                                                                                                                // shows buttons again on new level
        }//end for
    }//levelUp
    
    


    @objc func clearTapped(_ sender: UIButton)
    {
        currentAnswer.text = ""                                                                             // clears current answer text
        
        for button in activatedButtons                                                                      // shows all buttons
        {
            button.isHidden = false
        } //end for
        
        activatedButtons.removeAll()                                                                        // removes all user pressed buttons
        
    }//clearTapped
    
    
    
    func loadLevel()
    {
        var clueString: String = ""
        var solutionString: String  = ""
        var letterBits = [String]()
        
        if let levelFileURL = Bundle.main.url(forResource: "level\(level)", withExtension: "txt")                                       
        {                                                                                                   //if file exists
            if let levelContents = try? String(contentsOf: levelFileURL)                                    // if found convert to string
            {
                var lines = levelContents.components(separatedBy: "\n")                                     // individual lines
                lines.shuffle()                                                                             // shuffle lines
                
                
                for (index, line) in lines.enumerated()                                                     //Tuple
                {                                                                                           //  index each time ran
                                                                                                            // line each line
                
                    let parts = line.components(separatedBy: ": ")                                          // divides string text at the :
                                                                                                
                    let answer = parts[0]                                                                   //left
                    let clue = parts[1]                                                                     //right
                    
                    clueString +=  "\(index + 1). \(clue)\n"                                                // string in clues label starting at index from enumerated + 1
                    
                    let solutionWord = answer.replacingOccurrences(of:  "|", with:  "")                     // finds the solution using "|"
                    
                    solutionString += "\(solutionWord.count) letters\n"                                     // counts the length of the word now that | is gone
                    solutions.append(solutionWord)                                                          // added to the array
                    
                    let bits = answer.components(separatedBy: "|")                                          // adds the words seperated by |
                    letterBits += bits                                                                      // sets them to the array
                    
                    
                }//for loop
            }//levelContents
        }//levelFileURL
        
        cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)                        //trims spaces and new lines
        answersLabel.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)
        
        letterButtons.shuffle()
        
        if letterButtons.count == letterBits.count                                                          //buttons are equal to the letters being broken up by |
        {
            for i in 0..<letterButtons.count
            {
                letterButtons[i].setTitle(letterBits[i], for: .normal)                                      // counts through letter buttons and sets it to letter bits
            }// end for
        }// end if
        
    }//loadLevel
    
    
}//UIViewController

