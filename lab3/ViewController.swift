//
//  ViewController.swift
//  lab3
//
//  Created by Kateryna Kononenko on 2/9/17.
//  Copyright © 2017 Kateryna Kononenko. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var canvas: UIView!
    
    @IBOutlet weak var textBox: UITextField!
    
    @IBOutlet weak var backgroundButton: UIButton!
    
    let path = UIBezierPath()
    var  array : Array<CGPoint> = []
    var currLine: Line?
    var curLine: DrawLine?
    
    var currentColor : UIColor = .red
    var currentWidth : CGFloat = 1
    
    var allViews = [UIView]()
    var isChangingBackgroundColor = false
    
    var initialPosition: CGPoint!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func undoButtonPressed(_ sender: Any) {
        guard let lastView = allViews.last else { return }
        lastView.removeFromSuperview()
        allViews.removeLast()
    }
 
    @IBAction func clearView(_ sender: Any) {
        clearScreen()
    }
    
    @IBAction func colorButtonPressed( _ sender: UIButton) {
        if isChangingBackgroundColor == false {
            currentColor = sender.backgroundColor!
        } else {
            canvas.backgroundColor = sender.backgroundColor!
        }
    }
    
    @IBAction func thicknessChanged(_ sender: UISlider) {
        currentWidth = CGFloat(sender.value)
    }
    
    @IBAction func addText(_ sender: Any) {
        textBox.isHidden = !textBox.isHidden
    }
    @IBAction func resetBackgroundPressed(_ sender: Any) {
        canvas.backgroundColor = UIColor.white
    }
    
    func clearScreen(){
        for v in allViews {
            v.removeFromSuperview()
        }
        allViews = []
    }
    
    @IBAction func backgroundPressed(_ sender: UIButton) {
        isChangingBackgroundColor = !isChangingBackgroundColor
        sender.backgroundColor = isChangingBackgroundColor ? .lightGray : .clear
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        
        
        let touchPoint = (touches.first)!.location(in: canvas) as CGPoint
    
        curLine = DrawLine(frame: canvas.frame)
        curLine?.color = currentColor
        curLine?.lineWidth = currentWidth
        curLine?.newArray.append(touchPoint)
        
        view.addSubview(curLine!)
        print("Touches begin!")
        
        initialPosition = touchPoint
    }
    
    
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        let movePoint = (touches.first)!.location(in: canvas) as CGPoint
 
        curLine?.newArray.append(movePoint)
    
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = (touches.first)!.location(in: canvas) as CGPoint
        
        if touchPoint == initialPosition {
            let dot = UIView(frame: CGRect(x: 0, y: 0, width: currentWidth, height: currentWidth))
            dot.layer.cornerRadius = currentWidth/2
            dot.clipsToBounds = true
            dot.backgroundColor = currentColor
            dot.center = touchPoint
            
            canvas.addSubview(dot)
            allViews.append(dot)
        } else {
            allViews.append(curLine!)
        }
    }
}



