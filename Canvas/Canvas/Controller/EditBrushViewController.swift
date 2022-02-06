//
//  EditBrushViewController.swift
//  Canvas
//
//  Created by angel zambrano on 8/29/21.
//

import UIKit


// purpose:  this VC is in charge of editing created brushes
//           and as well as creating a way for a brush to be created

enum State {
    case editing, adding
}


class EditBrushViewController: UIViewController {
    let initialView = UIView()
    let dismissButton = UIButton()
    let nameOfBrushLbl = UILabel()
    let nameOfBrushTxtfld = UITextField()
    let sizeLbl = UILabel()
    let sizeView = UIView()
    var sizeSlider = UISlider()
    let colorLbl = UILabel()
    let colorView = UIView()
    let imageView = UIImageView()
    let colorButton = UIButton()
    let borderRadiusLbl = UILabel()
    let borderRadiusView = UIView()
    let borderRadiusSlider = UISlider()
    let saveButton = UIButton()
    let brush = UIView()
    let colorwepwo = UIColorWell() // You just have to implement it
    var drawingHeightConstraints: NSLayoutConstraint?
    var widthConstraint: NSLayoutConstraint?
    
    lazy var currentBrush = Brush(nameOfBrush: "placeholder", lengthOfBrush: 0, color: .darkGray, radius: 0)
    
    // MARK: delegates
    var delegate: EditProtocol?
    
    /// the state of the viewcontroller.
    /// Aditing  means that you are editing an exisiting product and adding means you are creating a new product.
    var state: State
    
    
    // MARK: initializers
    
    // called when editing a brush
    init(currentBrush: Brush) {
        state = .editing
        super.init(nibName: nil, bundle: nil)
        self.currentBrush = currentBrush
        configure(currentBrush: currentBrush)
    }
   
    // initializer when  adding adding a new brush
    init() {
        state = .adding
        super.init(nibName: nil, bundle: nil)
    }
    
    // Storyboard init
    // nothing to do here
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: life cyle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white // sets view background color to white
        // Do any additional setup after loading the view.
        // we could get rid of this
        setViews()
        setconstraints()
    }
    
    
    // MARK: helper functions
    
    func configure(currentBrush: Brush) {
        // sets the default state of the views
        nameOfBrushTxtfld.text = currentBrush.nameOfBrush
        brush.backgroundColor = currentBrush.color
        brush.layer.cornerRadius = CGFloat(currentBrush.radius)
        sizeSlider.value  = Float(currentBrush.lengthOfBrush)
        borderRadiusSlider.value = Float(currentBrush.radius)
        drawingHeightConstraints?.constant = CGFloat(currentBrush.lengthOfBrush)
        widthConstraint?.constant = CGFloat(currentBrush.lengthOfBrush)
    }

    
    // MARK: button methods
    
    @objc func saveButtonWasPressed() {
        // fill the info into the current brush
        currentBrush.nameOfBrush = nameOfBrushTxtfld.text ?? ""
        currentBrush.radius = Double(borderRadiusSlider.value)
        currentBrush.lengthOfBrush = Float(sizeSlider.value)
        currentBrush.color = currentBrush.color
        
        // check the current state the VC is in
        if state == .adding { // adding means that you will save
            // you add a new brush
            delegate?.save(brush: currentBrush)
            self.dismiss(animated: true, completion: nil) // dismiss the VC
        } else if state == .editing { // editing means that you will modify an existing brush
            // you edit an existing product
            delegate?.edit(brush: currentBrush)  // delegate info back
            self.dismiss(animated: true, completion: nil) // dismisses VC
        }
        
    }
    
    
    // ERROR: with this
    // Unsure on how to fi
    @objc func presentColorPicker() {
         let colorPicker = UIColorPickerViewController()
         colorPicker.delegate = self
         colorPicker.selectedColor = .black
         colorPicker.title = "Selected Color"
        present(colorPicker, animated: true, completion: nil)
     }
    
    @objc fileprivate func borderRadiusSliderWasPressed() {
        // TODO: finish implementation
        brush.layer.cornerRadius = CGFloat(Float(borderRadiusSlider.value))
    }
    
    @objc fileprivate func colorButtonWasPressed() {
        presentColorPicker() // celling the color picker
    }
    
    // MARK: slider changed
    @objc fileprivate func sliderChanged() {
            // changees the width and height constraints
        currentBrush.lengthOfBrush = Float(CGFloat(sizeSlider.value))
        widthConstraint?.constant = CGFloat(sizeSlider.value)
        drawingHeightConstraints?.constant = CGFloat(sizeSlider.value)
        print("Slider: \(sizeSlider.value)")
    }
    
    // called when button is pressed
    @objc func dismissButtonWasPress() {
        // TODO: send info back
        
        // dismiss
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: VIEWS
    
    // creates the views
    func setViews() {
        // sets the initialView
        initialView.backgroundColor = UIColor.init(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
        initialView.translatesAutoresizingMaskIntoConstraints = false // sets the contraints
        view.addSubview(initialView) // adds the initial view
        // sets up the dismiss button
        dismissButton.setBackgroundImage(UIImage(named: "cancel1"), for: .normal)
        dismissButton.translatesAutoresizingMaskIntoConstraints = false // sets the contraints
        dismissButton.addTarget(self, action: #selector(dismissButtonWasPress), for: .touchUpInside)
        view.addSubview(dismissButton)
        
        // set name of brush label
        nameOfBrushLbl.update(text: "NAME", textAlignment: .center, font: UIFont.boldSystemFont(ofSize: 12), color: UIColor.init(red: 181/255, green: 181/255, blue: 181/255, alpha: 1))
        view.addSubview(nameOfBrushLbl)
        // set up for the nametextfield
        nameOfBrushTxtfld.placeholder = "enter a name"
        nameOfBrushTxtfld.layer.masksToBounds = false
        nameOfBrushTxtfld.font = UIFont.systemFont(ofSize: 12)
        nameOfBrushTxtfld.borderStyle = .none
        nameOfBrushTxtfld.layer.cornerRadius = 8
        nameOfBrushTxtfld.backgroundColor = UIColor.init(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
        // create padding for the textfield
        let nameOfBrushTxtfldPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.nameOfBrushTxtfld.frame.height))
        nameOfBrushTxtfld.leftView = nameOfBrushTxtfldPaddingView
        nameOfBrushTxtfld.leftViewMode = UITextField.ViewMode.always
        nameOfBrushTxtfld.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameOfBrushTxtfld)
        // set the sizeLbl
        sizeLbl.update(text: "SIZE", textAlignment: .center, font: UIFont.boldSystemFont(ofSize: 12), color: UIColor.init(red: 181/255, green: 181/255, blue: 181/255, alpha: 1))
        view.addSubview(sizeLbl)
        //set the  sizeView
        sizeView.backgroundColor = UIColor.init(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
        sizeView.layer.cornerRadius = 8
        sizeView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sizeView)// adds the sizeView
        // set the sizeSlider
        sizeSlider.maximumValue = 50
        sizeSlider.minimumValue = 10 // lowest size Slider
        sizeSlider.translatesAutoresizingMaskIntoConstraints = false
        sizeSlider.setThumbImage(UIImage(named: "Ellipse 7"), for: .normal) // changes the size of the thumb
        sizeSlider.tintColor = UIColor(cgColor: CGColor.init(red: 229/255, green: 229/255, blue: 229/255, alpha: 1))
        sizeSlider.addTarget(self, action: #selector(sliderChanged), for: .valueChanged)
        view.addSubview(sizeSlider)
                                                                // Color area
        // set the color label
        colorLbl.update(text: "COLOR", textAlignment: .center, font: UIFont.boldSystemFont(ofSize: 12), color: UIColor.init(red: 181/255, green: 181/255, blue: 181/255, alpha: 1))
        view.addSubview(colorLbl)
        // set up for the colorView
        colorView.backgroundColor = UIColor.init(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
        colorView.translatesAutoresizingMaskIntoConstraints = false
        colorView.layer.cornerRadius = 8
        view.addSubview(colorView)
        // creates the imageViews
        imageView.image = UIImage(named: "image 8")
        imageView.layer.cornerRadius = 53/2
        self.imageView.layer.masksToBounds = true

        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        // creates image button
        colorButton.backgroundColor = .gray
        colorButton.layer.cornerRadius = 44/2
        colorButton.layer.borderWidth = 4
        colorButton.layer.borderColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 1 ).cgColor
        colorButton.translatesAutoresizingMaskIntoConstraints = false
        colorButton.addTarget(self, action: #selector(colorButtonWasPressed), for: .touchUpInside)
        view.addSubview(colorButton)
        // creating border radius label
        borderRadiusLbl.update(text: "BORDER RADIUS", textAlignment: .center, font: UIFont.boldSystemFont(ofSize: 12), color: UIColor.init(red: 181/255, green: 181/255, blue: 181/255, alpha: 1))
        view.addSubview(borderRadiusLbl)
        //  creating radius View
        borderRadiusView.backgroundColor = UIColor.init(red: 249/255, green: 249/255, blue: 249/255, alpha: 1) // color grey
        borderRadiusView.translatesAutoresizingMaskIntoConstraints = false
        borderRadiusView.layer.cornerRadius = 8 // creates rounded corners
        view.addSubview(borderRadiusView)
        // creating borderRadiusSlider
        // set the sizeSlider
        borderRadiusSlider.maximumValue = 50
        borderRadiusSlider.minimumValue = 0
        borderRadiusSlider.translatesAutoresizingMaskIntoConstraints = false
        borderRadiusSlider.setThumbImage(UIImage(named: "Ellipse 7"), for: .normal) // changes the size of the thumb
        borderRadiusSlider.tintColor = UIColor(cgColor: CGColor.init(red: 229/255, green: 229/255, blue: 229/255, alpha: 1))
        borderRadiusSlider.addTarget(self, action: #selector(borderRadiusSliderWasPressed), for: .valueChanged)
        view.addSubview(borderRadiusSlider)
        // saveButton
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(UIColor.init(red: 56/255, green: 186/255, blue: 215/255, alpha: 1), for: .normal)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.addTarget(self, action: #selector(saveButtonWasPressed), for: .touchUpInside)
        view.addSubview(saveButton)
        // creating the brush
        brush.backgroundColor = .gray
        brush.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(brush)
        
        // set up the info for the new vc
        sizeSlider.value = Float(currentBrush.lengthOfBrush)
        brush.backgroundColor = currentBrush.color
        colorButton.backgroundColor = currentBrush.color
        borderRadiusSlider.value = Float(currentBrush.radius)
        nameOfBrushTxtfld.text  = (currentBrush.nameOfBrush == "placeholder") ? (.none) : currentBrush.nameOfBrush
    }
    
    // sets up the view constraints
    func setconstraints() {
        // sets he constraints for the top initial View
        NSLayoutConstraint.activate([
            initialView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            initialView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            initialView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            initialView.heightAnchor.constraint(equalToConstant: 230)
        ])
        
        // sets the constraints for the dissmiss button
        NSLayoutConstraint.activate([
            dismissButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            dismissButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 13)
        ])
        // sets the constraints for the name label
        NSLayoutConstraint.activate([
            nameOfBrushLbl.topAnchor.constraint(equalTo: initialView.bottomAnchor, constant: 36),
            nameOfBrushLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 58)
        ])
        
        // set up for the textfield
        NSLayoutConstraint.activate([
            nameOfBrushTxtfld.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            nameOfBrushTxtfld.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -34),
            nameOfBrushTxtfld.topAnchor.constraint(equalTo: nameOfBrushLbl.bottomAnchor, constant: 8),
            nameOfBrushTxtfld.heightAnchor.constraint(equalToConstant: 44)
        ])
        // set up constraints for the the sizeLbl
        NSLayoutConstraint.activate([
            sizeLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 61),
            sizeLbl.topAnchor.constraint(equalTo: nameOfBrushTxtfld.bottomAnchor, constant: 34)
        
        ])
        // set the constraints for he sizeView
        NSLayoutConstraint.activate([
            sizeView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 37),
            sizeView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -37),
            sizeView.topAnchor.constraint(equalTo: sizeLbl.bottomAnchor, constant: 8),
            sizeView.heightAnchor.constraint(equalToConstant: 67)
            
        ])
        
     // set the constraints fro the size slider
        NSLayoutConstraint.activate([
            sizeSlider.leadingAnchor.constraint(equalTo: sizeView.leadingAnchor, constant: 24),
            sizeSlider.trailingAnchor.constraint(equalTo: sizeView.trailingAnchor, constant: -24),
            sizeSlider.centerYAnchor.constraint(equalTo: sizeView.centerYAnchor)
        ])
    // sets the constraints for the colorLbl
        NSLayoutConstraint.activate([
            colorLbl.topAnchor.constraint(equalTo: sizeView.bottomAnchor, constant: 34),
            colorLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 61)
        ])
    // sets the constraints of the colorView
        NSLayoutConstraint.activate([
            colorView.topAnchor.constraint(equalTo: colorLbl.bottomAnchor, constant: 8),
            colorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 37),
            colorView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -37),
            colorView.heightAnchor.constraint(equalToConstant: 99)
        ])
        // sets the imageView
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: colorView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: colorView.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 53),
            imageView.heightAnchor.constraint(equalToConstant: 53),
        ])
        // sets the colorButton
        NSLayoutConstraint.activate([
            colorButton.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            colorButton.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            colorButton.widthAnchor.constraint(equalToConstant: 45),
            colorButton.heightAnchor.constraint(equalToConstant: 45)
        ])
        // sets the constraints for the border radius lbl
        NSLayoutConstraint.activate([
            borderRadiusLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 61),
            borderRadiusLbl.topAnchor.constraint(equalTo: colorView.bottomAnchor, constant: 34)
        
        ])
        // sets the constraints for the borderRadiusView
        NSLayoutConstraint.activate([
            
            borderRadiusView.topAnchor.constraint(equalTo: borderRadiusLbl.bottomAnchor, constant: 8),
            borderRadiusView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 37),
            borderRadiusView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -37),
            borderRadiusView.heightAnchor.constraint(equalToConstant: 67)
        ])
        
        
        // sets the constraints for the borderRadiusSlider
        NSLayoutConstraint.activate([
            borderRadiusSlider.leadingAnchor.constraint(equalTo: borderRadiusView.leadingAnchor, constant: 24),
            borderRadiusSlider.trailingAnchor.constraint(equalTo: borderRadiusView.trailingAnchor, constant: -24),
            borderRadiusSlider.centerYAnchor.constraint(equalTo: borderRadiusView.centerYAnchor)
        ])
        // sets the constraints for the save button
        NSLayoutConstraint.activate([
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15)
        ])
        // set up constraints for the brush
        NSLayoutConstraint.activate([
            brush.centerXAnchor.constraint(equalTo: initialView.centerXAnchor),
            brush.centerYAnchor.constraint(equalTo: initialView.centerYAnchor),
        ])
        
        // creates variable constraints
        widthConstraint = brush.widthAnchor.constraint(equalToConstant: CGFloat(currentBrush.lengthOfBrush))
        drawingHeightConstraints = brush.heightAnchor.constraint(equalToConstant: CGFloat(currentBrush.lengthOfBrush))
        
        widthConstraint?.isActive = true
        drawingHeightConstraints?.isActive = true
    }
}

extension EditBrushViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        // called when the selectedColor change
        colorButton.backgroundColor = viewController.selectedColor
        // fill the data model
        currentBrush.color =   viewController.selectedColor
        // fill the view
        brush.backgroundColor = currentBrush.color
    }

    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        // the view controller dismiss
        print("viewcontroler dismiss")

        
    }
}


