//
//  ViewController.swift
//  Canvas
//
//  Created by angel zambrano on 8/29/21.
//

import UIKit

// TODO: Draw
// CG Context
// Video 1: https://www.youtube.com/watch?v=E2NTCmEsdSE
// Video 2:

protocol CanvasDelegate: class {
    func get(brush: Brush)
    func brushes(brushes: [Brush])
}

class ViewController: UIViewController {
    // the label that containts the title
    var settingsButton = UIButton() // the settingsButton
    var viewButton = UIView() // the UIView the encapsulates the button
    let canvas  = Canvas() // creates a canvas
    var Currentbrushes = [Brush]() // initializes an empty array of brushes
    
    
    override func loadView() {
        self.view = canvas
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "My Canvas"
        updateViews()
        updateConstraints()
//        view.addSubview(canvas)
//        canvas.frame = view.frame
        canvas.backgroundColor = .white
        
//        self.view.sendSubviewToBack(canvas)
        Currentbrushes.append(contentsOf: generateBrushes())
        

    }
    
    
    func generateBrushes() -> [Brush] {
        let canvas1 =  Brush(nameOfBrush: "Cool Brush 1", lengthOfBrush: 20, color: .blue, radius: 10)
        let canvas2 =  Brush(nameOfBrush: "Cool Brush 2", lengthOfBrush: 30, color: .red, radius: 10)
        let canvas3 =    Brush(nameOfBrush: "lazy Brush 3", lengthOfBrush: 40, color: .brown, radius: 10)
        let canvas4 =    Brush(nameOfBrush: "trip Brush 4", lengthOfBrush: 50, color: .gray, radius: 10)
        let canvas5 =      Brush(nameOfBrush: "coffee Brush 5", lengthOfBrush: 10, color: .orange, radius: 10)
        let canvas6 = Brush(nameOfBrush: "cofefe Brush 6", lengthOfBrush: 20, color: .purple, radius: 10)
        
        return [canvas1, canvas2, canvas3, canvas4, canvas5, canvas6]
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        canvas.clean()
    }
    
    func updateViews() {
        // create the view
        viewButton.backgroundColor = .white // set the color the for the viewButton
        viewButton.translatesAutoresizingMaskIntoConstraints = false
        viewButton.layer.cornerRadius = 30
        viewButton.layer.borderWidth = 5
        viewButton.layer.borderColor = UIColor.init(red: 64/255, green: 186/255, blue: 213/255, alpha: 1).cgColor
        view.addSubview(viewButton)
        
        // add shadow
        viewButton.addShadow2(offset: CGSize(width: 2, height: 2), color: UIColor.black, radius: 2, opacity: 0.35)
        
        // setting up the setting button
        settingsButton.setBackgroundImage(UIImage(named: "Setting"), for: .normal)
        settingsButton.backgroundColor = .clear
        settingsButton.addTarget(self, action: #selector(settingsButtonWasPressed), for: .touchUpInside)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(settingsButton)

    }
    
    
    @objc fileprivate func settingsButtonWasPressed() {
        // initialize ChooseABrushViewController
        let pushViewController = ChooseABrushViewController(with: Currentbrushes)
        // implement delegate to set the brush
        pushViewController.delegate = self
        
        // push view controller
        navigationController?.pushViewController(pushViewController, animated: true)
    }
    
    func  updateConstraints() {
        // constraints for the view Button
        NSLayoutConstraint.activate([
            viewButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            viewButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            viewButton.widthAnchor.constraint(equalToConstant: 60),
            viewButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        // constrain for the settings button that is inside of the view Button
        NSLayoutConstraint.activate([
            settingsButton.topAnchor.constraint(equalTo: viewButton.topAnchor, constant: 60 * 0.29),
            settingsButton.leadingAnchor.constraint(equalTo: viewButton.leadingAnchor, constant: (60 * 0.29)),
            settingsButton.trailingAnchor.constraint(equalTo: viewButton.trailingAnchor, constant: -(60 * 0.29) - 0.5),
            settingsButton.bottomAnchor.constraint(equalTo: viewButton.bottomAnchor, constant: -(60 * 0.29) - 0.5),
        ])
    
    }
    
    
    
}


extension UILabel {
    func update(text: String, textAlignment: NSTextAlignment, font: UIFont, color: UIColor ) {
        self.text = text
        self.textAlignment = textAlignment
        self.font = font
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textColor = color
    }
    
}

extension UIView {

  
    func addShadow2(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowOpacity =  opacity
        layer.shadowRadius = radius
    }
    
}


extension ViewController: CanvasDelegate {
    func brushes(brushes: [Brush]) {
        Currentbrushes = brushes
    }
    
    func get(brush: Brush) {
        canvas.StroColor = brush.color.cgColor // gets the current Brush collor
        canvas.setWidth(width: CGFloat(brush.lengthOfBrush))
    }

    
    
}

// cool extension of UIColor
// https://stackoverflow.com/questions/30332724/what-does-shift-left-actually-do-in-swift
extension UIColor {
      func toHexString() -> String {
          var r:CGFloat = 0
          var g:CGFloat = 0
          var b:CGFloat = 0
          var a:CGFloat = 0

          getRed(&r, green: &g, blue: &b, alpha: &a)

         // What is this doing
          let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0

          return String(format:"#%06x", rgb)
      }
  }
