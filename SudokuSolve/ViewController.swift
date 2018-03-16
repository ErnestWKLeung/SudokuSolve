//
//  ViewController.swift
//  SudokuSolve
//
//  Created by Ernest Leung on 4/6/2016.
//  Copyright © 2016 ernestleung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var mainView: UIView!
    @IBOutlet var output_text: [UILabel]!

    @IBOutlet var input_text: [UITextField]!
    
    var number_sets: [[Bool]]!
    var board_number: [Int]!
    var square_sets: [[Int]]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        number_sets = Array(repeating: Array( repeating: true , count: 9), count: 81)
        board_number = Array(repeating: 0, count: 81)
        square_sets = Array(repeating: Array( repeating: 0, count: 9), count: 9)
        square_sets[0] = [ 0,  1,  2,  9, 10, 11, 18, 19, 20]
        square_sets[1] = [ 3,  4,  5, 12, 13, 14, 21, 22, 23]
        square_sets[2] = [ 6,  7,  8, 15, 16, 17, 24, 25, 26]
        square_sets[3] = [27, 28, 29, 36, 37, 38, 45, 46, 47]
        square_sets[4] = [30, 31, 32, 39, 40, 41, 48, 49, 50]
        square_sets[5] = [33, 34, 35, 42, 43, 44, 51, 52, 53]
        square_sets[6] = [54, 55, 56, 63, 64, 65, 72, 73, 74]
        square_sets[7] = [57, 58, 59, 66, 67, 68, 75, 76, 77]
        square_sets[8] = [60, 61, 62, 69, 70, 71, 78, 79, 80]
        // Do any additional setup after loading the view, typically from a nib.
        
        setup_constraints()
        show_input(true)
        show_result(false)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setup_constraints(){
        
        for i in 0..<81 {
            output_text[i].translatesAutoresizingMaskIntoConstraints = false
            input_text[i].translatesAutoresizingMaskIntoConstraints = false
            
            if i < 9 {
                let toc = NSLayoutConstraint(item: output_text[i], attribute: .top, relatedBy: .equal, toItem: mainView, attribute: .top, multiplier: 1.0, constant: 20)
                mainView.addConstraint(toc)
                let tic = NSLayoutConstraint(item: input_text[i], attribute: .top, relatedBy: .equal, toItem: mainView, attribute: .top, multiplier: 1.0, constant: 20)
                mainView.addConstraint(tic)
            }else{
                let toc = NSLayoutConstraint(item: output_text[i], attribute: .top, relatedBy: .equal, toItem: output_text[i-9], attribute: .bottom, multiplier: 1.0, constant: 8)
                mainView.addConstraint(toc)
                let tic = NSLayoutConstraint(item: input_text[i], attribute: .top, relatedBy: .equal, toItem: input_text[i-9], attribute: .bottom, multiplier: 1.0, constant: 8)
                mainView.addConstraint(tic)
            }
            if i != 0 {
                let woc = NSLayoutConstraint(item: output_text[i], attribute: .width, relatedBy: .equal, toItem: output_text[i-1], attribute: .width, multiplier: 1.0, constant: 0)
                mainView.addConstraint(woc)
                
                let wic = NSLayoutConstraint(item: input_text[i], attribute: .width, relatedBy: .equal, toItem: input_text[i-1], attribute: .width, multiplier: 1.0, constant: 0)
                mainView.addConstraint(wic)
                let hoc = NSLayoutConstraint(item: output_text[i], attribute: .height, relatedBy: .equal, toItem: output_text[i-1], attribute: .height, multiplier: 1.0, constant: 0)
                mainView.addConstraint(hoc)
                
                let hic = NSLayoutConstraint(item: input_text[i], attribute: .height, relatedBy: .equal, toItem: input_text[i-1], attribute: .height, multiplier: 1.0, constant: 0)
                mainView.addConstraint(hic)
            }
            if i % 9 == 0 {
                let loc = NSLayoutConstraint(item: output_text[i], attribute: .left, relatedBy: .equal, toItem: mainView, attribute: .left, multiplier: 1.0, constant: 20)
                mainView.addConstraint(loc)
                let lic = NSLayoutConstraint(item: input_text[i], attribute: .left, relatedBy: .equal, toItem: mainView, attribute: .left, multiplier: 1.0, constant: 20)
                mainView.addConstraint(lic)
            }else if i % 9 == 8 {
                let roc = NSLayoutConstraint(item: output_text[i], attribute: .right, relatedBy: .equal, toItem: mainView, attribute: .right, multiplier: 1.0, constant: -20)
                mainView.addConstraint(roc)
                let ric = NSLayoutConstraint(item: input_text[i], attribute: .right, relatedBy: .equal, toItem: mainView, attribute: .right, multiplier: 1.0, constant: -20)
                mainView.addConstraint(ric)
            }else {
                
                let loc = NSLayoutConstraint(item: output_text[i], attribute: .left, relatedBy: .equal, toItem: output_text[i-1], attribute: .right, multiplier: 1.0, constant: 8)
                mainView.addConstraint(loc)
                let lic = NSLayoutConstraint(item: input_text[i], attribute: .left, relatedBy: .equal, toItem: input_text[i-1], attribute: .right, multiplier: 1.0, constant: 8)
                mainView.addConstraint(lic)
                let roc = NSLayoutConstraint(item: output_text[i], attribute: .right, relatedBy: .equal, toItem: output_text[i-1], attribute: .left, multiplier: 1.0, constant: -8)
                mainView.addConstraint(roc)
                let ric = NSLayoutConstraint(item: input_text[i], attribute: .right, relatedBy: .equal, toItem: input_text[i-1], attribute: .left, multiplier: 1.0, constant: -8)
                mainView.addConstraint(ric)
            }
        }

    }

    func show_input(_ show : Bool){
        for i in 0..<81 {
            input_text[i].isHidden = !show
        }
    }

    func show_result(_ show : Bool){
        for i in 0..<81 {
            output_text[i].isHidden = !show
        }
    }
    
    @IBAction func setBoard(_ sender: AnyObject) {
        show_input(true)
        show_result(false)
    }
    
    @IBAction func processBoard(_ sender: AnyObject) {
        getInput()
        show_input(false)
        show_result(true)
        
        searchHorizontal()
        searchVertical()
        searchSquare()
        
        setSecond()
        searchHorizontal()
        searchVertical()
        searchSquare()
        
//        checkHorizontalUnique()
//        backTracking()
        
        showResultBoard()


        
        
    }
    
    @IBAction func backTrack(_ sender: UIButton) {
        getInput()
        show_input(false)
        show_result(true)
        backTracking()
    }
    
    @IBAction func clickField(_ sender: UITextField) {
        sender.text = ""
    }
    
    @IBAction func finishField(_ sender: UITextField) {
        if sender.text == "" {
            sender.text = "0"
        }
    }
    
    func getInput(){
        //! get input from board
        for i in 0..<81 {
            //! reset all chance
            for j in 0..<9 {
                number_sets[i][j] = true
            }
            if let idx = Int(input_text[i].text!) {
                for j in 0..<9 {
                    if idx == 0 { break }
                    if j != (idx-1) {
                        number_sets[i][j] = false
                    }
                }
                board_number[i] = (idx == 0) ? 0 : idx
            }
        }
    }
    
    func searchHorizontal(){
        for i in 0..<81 {
            let fi = i / 9
//            print( "floor number \(fi)" )
            for j in 0..<9 {
                if board_number[fi * 9 + j] == 0 { continue }
                if (fi * 9 + j) == i { continue }
                number_sets[i][board_number[fi * 9 + j] - 1] = false
            }
        }
    }
    
    func searchVertical(){
        var lower : Int = 0
        for i in 0..<81 {
            lower = i % 9

            for j in stride(from: lower, to: 81, by:9) {
                if i == j { continue }
                if board_number[j] == 0 { continue }
                number_sets[i][board_number[j] - 1] = false
            }
        }
    }
    
    func searchSquare(){
        var hi : Int = 0
        var vi : Int = 0
        for i in 0..<81 {
            vi = (i % 9) / 3
            hi = i / 27
            var curr_set : [Int] = square_sets[vi + hi * 3]
            for j in 0..<9 {
                if i == curr_set[j] { continue }
                if board_number[curr_set[j]] == 0 { continue }
                number_sets[i][ board_number[curr_set[j]] - 1 ] = false
            }
        }
    }
    
    func checkHorizontalUnique(){
//        var num_set = Array( count: 9, repeatedValue: 0)
//        for i in 0..<81 {
//            let fi = i / 9
//            //! from left to right
//            for j in 0..<9 {
////                if board_number[fi * 9 + j] == 0 { continue }
//                if (fi * 9 + j) == i { continue }
//                number_sets[i][board_number[fi * 9 + j] - 1] = false
//                for k in 0..<9 {
//                    if number_sets[fi*9+j][k] {
////                        num_set[k] =
//                    }
//                }
//            }
//        }
//        //! for each row
//            //! traverse each cell in a row
//                //! if idx
    }
  
    func checkSquareUnique(){
//        var hi : Int = 0
//        var vi : Int = 0
//        for i in 0..<81 {
//            vi = (i % 9) / 3
//            hi = i / 27
//            var curr_set : [Int] = square_sets[vi + hi * 3]
//            for j in 0..<9 {
//                if i == curr_set[j] { continue }
////                if board_number[curr_set[j]] == 0 { continue }
//                
//                number_sets[i][ board_number[curr_set[j]] - 1 ] = false
//            }
//        }
//        var num_set = Array( count : 9, repeatedValue: 0 )
//        for i in 0..<9{
//            var curr_sq : [Int] = square_sets[i]
//            for j in 0..<9{
//                var curr_set = number_sets[curr_sq[j]]
//                for k in 0..<9{
//                    if curr_set[k] {
////                        num_set[k] = num_set[k] > 0 ? 10 :
//                    }
//                }
//            }
//        }
    }
    
    func showResultBoard(){
        //! show result board
        var result_str : String
        for i in 0..<81 {
            result_str = ""
            var digit_count = 0
            for j in 0..<9 {
                if number_sets[i][j] {
                    result_str += String((j+1))
                    digit_count = digit_count + 1
                }
            }
            if digit_count != 1 {
                output_text[i].font = output_text[i].font.withSize(9)
            }else{
                output_text[i].font = output_text[i].font.withSize(20)
                input_text[i].text = result_str
            }
            output_text[i].text = result_str
        }
    }
    
    func setSecond(){
        var value = 0
        for i in 0..<81{
            var digit_count = 0
            
            for j in 0..<9 {
                if number_sets[i][j] {
                    digit_count = digit_count + 1
                    value = j + 1
                }
            }
            if digit_count == 1 {
                board_number[i] = value
            }
        }
    }
    
    func backTracking(){
        var result = Array( repeating: 0, count: 81 )
        var duplicate = false
        var currValue = 0
        var lower = 0, vi = 0, hi = 0
        var i = 0
        for m in 0..<81{
            if board_number[m] != 0 {
                result[m] = board_number[m]
                output_text[m].text = String(result[m])
            }else{
                output_text[m].text = ""
            }
        }
        repeat{
            currValue = 0
            if board_number[i] == 0 {
//                result[i] = board_number[i]
//            }else{
                repeat{
                    currValue = currValue + 1
                    //! check horizontal unique
                    let fi = i / 9
                    duplicate = false
                    for j in 0..<9 {
                        if (fi * 9 + j) == i { continue }
                        if result[fi * 9 + j] == currValue {
                            duplicate = true
                            continue
                        }
                    }
                    //! check vertical unique
                    lower = i % 9
                    for j in stride(from: lower, to: 81, by:9) {
                        if i == j { continue }
                        if result[j] == currValue {
                            duplicate = true
                            continue
                        }
                    }
                    
                    //! check square unique
                    vi = (i % 9) / 3
                    hi = i / 27
                    var curr_set : [Int] = square_sets[vi + hi * 3]
                    for j in 0..<9 {
                        if i == curr_set[j] { continue }
                        if result[curr_set[j]] == currValue{
                            duplicate = true
                            continue
                        }
                    }
                    
                    if !duplicate {
                        result[i] = currValue
                        output_text[i].text = String(result[i])
//                        print("assign \(i) value \(currValue)")
                    }else{
                        if currValue >= 9 {
//                            if (i==19) && (result[2]==3) && (result[3]==6) && (result[4]==2) && (result[5]==4) && (result[6]==5) && (result[10]==6) && (result[12]==9) && (result[13]==3) && (result[14]==7) && (result[16]==1) && (result[18]==7){
//                                print("break")
//                            }
                            var j = 1
                            var found = false
                            repeat {
                                if i < j {
//                                    print("error i: \(i) j: \(j) ")
                                    return
                                }
                                if (board_number[i-j] == 0) && (result[i-j] != 9){
//                                    print("i: \(i) j: \(j) result:\(result[i-j])")
                                    i = i-j
                                    currValue = result[i]
                                    result[i] = 0
                                    found = true
                                    j = 1
                                }else{
                                    //! when back track, reset current cell first
//                                    if board_number[i-j] == 0 {
//                                        result[i-j] = 0
//                                        print("reset to 0 : \(i-j)")
//                                    }
                                    if (result[i-j] == 9) && (board_number[i-j]==0) {
                                        result[i-j] = 0
                                    }
                                    j = j + 1
//                                    print("reset i: \(i) j: \(j)")
                                }
                            } while !found
//                            print("back track i: \(i) j: \(j) result:\(currValue)")
                        }
//                        print("duplicate i: \(i) value:\(currValue)")
                    }
                } while duplicate
            }
            i = i + 1
        } while i < 81
        
        for i in 0..<81{
            output_text[i].text = String(result[i])
//            print("print \(i) : value \(result[i])")
        }
    }
}

