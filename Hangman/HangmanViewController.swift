//
//  ViewController.swift
//  Hangman
//
//  Created by Gene Yoo on 10/13/15.
//  Copyright © 2015 cs198-ios. All rights reserved.
//

import UIKit

class HangmanViewController: UIViewController {
    
    @IBOutlet weak var hangman: UIImageView!
    @IBOutlet weak var letters: UILabel!
    @IBOutlet weak var guessALetter: UITextField!
    @IBOutlet weak var lettersGuessed: UILabel!
    var counter = 1
    var x: Hangman!
    var gameOver = false
    
//    @IBAction func newGame(sender: AnyObject) {
//        gameOver = false
//        counter = 1
//        lettersGuessed.text = " "
//        hangman.image = UIImage(named: "hangman\(counter).gif")
//        x = Hangman()
//        x.start()
//        letters.text = x.knownString
//        
//    }
    
    @IBAction func newGame() {
        gameOver = false
        counter = 1
        lettersGuessed.text = " "
        hangman.image = UIImage(named: "hangman\(counter).gif")
        x = Hangman()
        x.start()
        letters.text = x.knownString
        letters.becomeFirstResponder()
    }
    
    @IBAction func guess(sender: AnyObject) {
        if gameOver {
            return
        }
        if let guess = guessALetter.text {
            guessALetter.text = ""
            if (guess.isEmpty) {
                return
            }
            let char = guess.lowercaseString[guess.startIndex]
            if (char >= "a" && char <= "z") {
                if (x.guessLetter(String(char))) {
                    letters.text = x.knownString
                    if (!x.knownString!.containsString("_")) {
                        gameOver = true
                        alert(false)
                        return
                        
                    }
                } else {
                    counter += 1
                    hangman.image = UIImage(named: "hangman\(counter).gif")
                    if (counter == 7) {
                        gameOver = true
                        alert(true)
                        return
                    }
                }
                lettersGuessed.text = x.guesses()
            }
        }
    }
    
//    @IBAction func guess(sender: AnyObject) {
//        if gameOver {
//            return
//        }
//        if let guess = guessALetter.text {
//            guessALetter.text = ""
//            if (guess.isEmpty) {
//                return
//            }
//            let char = guess.lowercaseString[guess.startIndex]
//            if (char >= "a" && char <= "z") {
//                if (x.guessLetter(String(char))) {
//                    letters.text = x.knownString
//                    if (!x.knownString!.containsString("_")) {
//                        gameOver = true
//                        alert(false)
//                        return
//
//                    }
//                } else {
//                    counter += 1
//                    hangman.image = UIImage(named: "hangman\(counter).gif")
//                    if (counter == 7) {
//                        gameOver = true
//                        alert(true)
//                        return
//                    }
//                }
//                lettersGuessed.text = x.guesses()
//            }
//        }
//        
//    }
    
    func alert(lose: Bool) {
        var title = ""
        var msg2 = ""
        if (!lose) {
            title = "Congratulations!"
            msg2 = "You won!"
        } else {
            title = "You lost"
            msg2 = "The answer was : \(x.answer!.lowercaseString)"
        }
        let actionSheetController: UIAlertController = UIAlertController(title: title, message: msg2, preferredStyle: .Alert)
        
        let OK: UIAlertAction = UIAlertAction(title: "Ok", style: .Default) { action -> Void in
        }
        actionSheetController.addAction(OK)
        
        self.presentViewController(actionSheetController, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        newGame()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

