//
//  ViewController.swift
//  Project8
//
//  Created by Brandon Johns on 4/27/23.
//

import UIKit

class ViewController: UIViewController {
    
    var cluesLabel: UILabel!
    var answersLabel: UILabel!
    var currentAnswer: UITextField!
    var scoreLabel: UILabel!
    var letterButtons = [UIButton]()
    let submit = UIButton(type: .system)
    let clear = UIButton(type: .system)
    let buttonsView = UIView()
    
    
    
    var activatedButtons = [UIButton]()
    var solutions = [String]()
    var score: Int = 0
    {
        didSet
        {
            scoreLabel.text = "Score: \(score)"
        }//didset
    }//score
    var level: Int = 1
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        scoreLabel.text = "score: 0"
        view.addSubview(scoreLabel)
        
        cluesLabel = UILabel()
        cluesLabel.translatesAutoresizingMaskIntoConstraints = false
        cluesLabel.font = UIFont.systemFont(ofSize: 24)
        cluesLabel.text = "CLUES"
        cluesLabel.numberOfLines = 0
        cluesLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(cluesLabel)
        
        answersLabel = UILabel()
        answersLabel.translatesAutoresizingMaskIntoConstraints = false
        answersLabel.font = UIFont.systemFont(ofSize: 24)
        answersLabel.text = "ANSWERS"
        answersLabel.textAlignment = .right
        answersLabel.numberOfLines = 0
        answersLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(answersLabel)
        
        currentAnswer = UITextField()
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.placeholder = "Tap letters to guess"
        currentAnswer.textAlignment = .center
        currentAnswer.font = UIFont.systemFont(ofSize: 44)
        currentAnswer.isUserInteractionEnabled = false                                           // stops keyboard from showing up so users cannot type
        view.addSubview(currentAnswer)
        
        
        
        submit.translatesAutoresizingMaskIntoConstraints = false
        submit.setTitle("SUBMIT", for: .normal)
        submit.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)            // user pressed call submitTapped
        view.addSubview(submit)
        
        
        clear.translatesAutoresizingMaskIntoConstraints = false
        clear.setTitle("CLEAR", for: .normal)
        submit.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)            // user pressed call clearTapped
        view.addSubview(clear)
        
        
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)
        
        NSLayoutConstraint.activate([
            
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),          // top
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor), // right
            
            cluesLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            cluesLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 100),   //left
            cluesLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.6, constant: -100),
            
            
            answersLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            answersLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -100),
            answersLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.4, constant: -100),
            answersLabel.heightAnchor.constraint(equalTo: cluesLabel.heightAnchor),
            
            
            currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentAnswer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            currentAnswer.topAnchor.constraint(equalTo: cluesLabel.bottomAnchor, constant: 20),
            
            
            submit.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor),
            submit.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
            submit.heightAnchor.constraint(equalToConstant: 44),
            
            clear.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
            clear.centerYAnchor.constraint(equalTo: submit.centerYAnchor),
            clear.heightAnchor.constraint(equalToConstant: 44),
            
            buttonsView.widthAnchor.constraint(equalToConstant: 750),
            buttonsView.heightAnchor.constraint(equalToConstant: 320),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.topAnchor.constraint(equalTo: submit.bottomAnchor, constant: 20),
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant:  -20)
            ]) // end of array
        
        let width = 150
        let height = 80
        
        for row in 0..<4
        {
            for column in 0..<5
            {
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
                letterButton.setTitle("WWW", for: .normal)
                letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
                
                let frame = CGRect(x: column * width, y: row * height, width: width, height: height)
                letterButton.frame = frame
                
                buttonsView.addSubview(letterButton)
                letterButtons.append(letterButton)
            }//column
        }//row
    }//loadView
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLevel()
        
        
        
    }//viewDidLoad

    @objc func letterTapped(_ sender: UIButton)
    {
        guard let buttonTitle = sender.titleLabel?.text else {return}
        
        currentAnswer.text = currentAnswer.text?.appending(buttonTitle)
        activatedButtons.append(sender)
        sender.isHidden = true // hides button after is tapped
        
    }//LetterTapped
    
    @objc func submitTapped(_ sender: UIButton)
    {
        guard let answerText = currentAnswer.text else {return}
        
        if let solutionPosition = solutions.firstIndex(of: answerText)
        {
            activatedButtons.removeAll()
            
            var splitsAnswers = answersLabel.text?.components(separatedBy: "\n")
            
            splitsAnswers?[solutionPosition] = answerText
            answersLabel.text = splitsAnswers?.joined(separator: "\n")
            
            currentAnswer.text = ""
            score += 1
            
            if score % 7 == 0
            {
                let ac = UIAlertController(title: "Well Done!", message: "Are you ready for the next level?", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Lets Go!", style: .default, handler: levelUp))
                present(ac, animated: true)
            }//end if
            
        }//solutionPosition
        
    }//submitTapped
    
    
    func levelUp(action: UIAlertAction)
    {
        level += 1
        solutions.removeAll(keepingCapacity: true)
        loadLevel()
        
        for button in letterButtons
        {
            button.isHidden = false
        }//end for
    }//levelUp
    
    
    @objc func clearTapped(_ sender: UIButton)
    {
        currentAnswer.text = ""
        
        for button in activatedButtons
        {
            button.isHidden = false
        } //end for
        
        activatedButtons.removeAll()
        
    }//clearTapped
    
    
    
    func loadLevel()
    {
        var clueString: String = ""
        var solutionString: String  = ""
        var letterBits = [String]()
        
        if let levelFileURL = Bundle.main.url(forResource: "level\(level)", withExtension: "txt")
        {
            if let levelContents = try? String(contentsOf: levelFileURL)
            {
                var lines = levelContents.components(separatedBy: "\n")
                lines.shuffle()
                
                
                for (index, line) in lines.enumerated()
                {
                    let parts = line.components(separatedBy: ": ")
                    let answer = parts[0]
                    let clue = parts[1]
                    
                    clueString +=  "\(index + 1). \(clue)\n"
                    
                    let solutionWord = answer.replacingOccurrences(of:  "|", with:  "")
                    solutionString += "\(solutionWord.count) letters\n"
                    solutions.append(solutionWord)
                    
                    let bits = answer.components(separatedBy: "|")
                    letterBits += bits
                    
                    
                }//for loop
            }//levelContents
        }//levelFileURL
        
        cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
        answersLabel.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)
        
        letterButtons.shuffle()
        
        if letterButtons.count == letterBits.count
        {
            for i in 0..<letterButtons.count
            {
                letterButtons[i].setTitle(letterBits[i], for: .normal)
            }// end for
        }// end if
        
    }//loadLevel
    
    
}//UIViewController

