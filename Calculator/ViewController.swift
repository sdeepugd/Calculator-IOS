//
//  ViewController.swift
//  Calculator
//
//  Created by Deepak S on 16/05/20.
//  Copyright © 2020 Deepak S. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    enum opMode {
        case noMode
        case add
        case subtract
        case multiply
        case divide
    }
    
    var currentOpMode:opMode=opMode.noMode
    var firstOperand:String?=""
    @IBOutlet weak var resultLabel: UILabel!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.resultLabel.text="0"
    }

    func resetmems(){
        currentOpMode=opMode.noMode
        self.firstOperand=""
    }
    
    func resetAll(){
        self.resultLabel.text="0"
        resetmems()
    }
    
    @IBAction func clearTapped(_ sender: Any) {
        resetAll()
    }
    
    func normaliseRes(res:Float)->String{
        let resstr:String="\(res)"
        let intRes:Int = Int(res)
        let intresstr = "\(intRes)"
        if(intresstr+".0" == resstr){
            return intresstr
        }
        return resstr
    }
    
    @IBAction func compute(_ sender: UIButton) {
        if(currentOpMode != .noMode){
            let secondOprstr:String = self.resultLabel.text!
            guard let secondOperand:Float = Float(secondOprstr) else{return}
            guard let firstOp:Float = Float(self.firstOperand!) else{return}
            
            var res:Float = 0
            switch currentOpMode {
            case .add:
                res=firstOp+secondOperand
            case .divide:
                res=firstOp/secondOperand
            case .multiply:
                res=firstOp*secondOperand
            case .subtract:
                res=firstOp-secondOperand
            default:
                res=0
            }
        
            self.resultLabel.text="\(normaliseRes(res:res))"
            resetmems()
        }
    }
    
    @IBAction func numberTapped(_ sender: Any) {
        if(self.resultLabel.text == "0"){
            self.resultLabel.text = ""
        }
        let numButton = sender as! UIButton
        guard let num = numButton.title(for: .normal) else { return }
        self.resultLabel.text?.append(num)
    }
    
    
    @IBAction func opTapped(_ sender: UIButton) {
        let opstr = sender.title(for: .normal)
        self.firstOperand = self.resultLabel.text
        self.resultLabel.text="0"
        switch(opstr){
        case "/":
            currentOpMode = .divide
        case "x":
            currentOpMode = .multiply
        case "-":
            currentOpMode = .subtract
        case "+":
            currentOpMode = .add
        default:
            currentOpMode = .noMode
        }
    }
    
}

