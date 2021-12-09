//
//  BrushTableViewCell.swift
//  Canvas
//
//  Created by angel zambrano on 8/29/21.
//

import UIKit

class BrushTableViewCell: UITableViewCell {
    
    var brushView = UIView()
    var nameOfBrushLabel = UILabel() // sets the label for the name of the brush
    var colorLabel = UILabel() // creates a label for the color that is being used
    var brush = UIView() // the brush view
    var drawingHeightConstraints: NSLayoutConstraint?  // the constraint variable for the height anchor of the brush view
    var widthConstraint: NSLayoutConstraint? // the constraint variable for the width anchor of the brush view
        
    var length: Float?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setViews()
        setConstraints()
        print("Init")
    }

    
    // configured the cell
    func configureCell(canva: Brush) {
        nameOfBrushLabel.text = canva.nameOfBrush
        brush.backgroundColor = canva.color
        colorLabel.text = canva.color.toHexString()

        // create constraints for the width and height anchor
//        widthConstraint?.constant = brush.widthAnchor.constraint(equalToConstant: CGFloat(canva.lengthOfBrush))
//        drawingHeightConstraints.con = brush.heightAnchor.constraint(equalToConstant: CGFloat(canva.lengthOfBrush))
    
        widthConstraint?.constant = CGFloat(canva.lengthOfBrush)
        drawingHeightConstraints?.constant = CGFloat(canva.lengthOfBrush)
        
//        widthConstraint?.isActive = true
//        drawingHeightConstraints?.isActive = true
        
        // update the corner radius
        brush.layer.cornerRadius = CGFloat(canva.radius)
        print("\(canva.nameOfBrush) - \(canva.lengthOfBrush)")
    }
    
    
    func selectCell() {
        // set the colors for the brush
        brushView.layer.borderWidth = 3
        brushView.layer.borderColor = UIColor.init(red: 87/255, green: 194/255, blue: 218/255, alpha: 1).cgColor
        // change the color of the labels
        nameOfBrushLabel.textColor = UIColor.init(red: 87/255, green: 194/255, blue: 218/255, alpha: 1)
        colorLabel.textColor = UIColor.init(red: 87/255, green: 194/255, blue: 218/255, alpha: 1)
        
    }
    
    func deselect() {
        // remove the borderWidth color
        brushView.layer.borderWidth = 0
        brushView.layer.borderColor = .none
        // change the color of the labels
        nameOfBrushLabel.textColor = .black
        colorLabel.textColor = UIColor.init(red: 179/255, green: 179/255, blue: 179/255, alpha: 1)
    }
    
    func setViews() {
    
        brushView.backgroundColor = UIColor.init(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
        brushView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(brushView)
        
        nameOfBrushLabel.update(text: "Small Brush", textAlignment: .left, font: UIFont.boldSystemFont(ofSize: 14), color: .black)
        contentView.addSubview(nameOfBrushLabel)
        
        // creates the colorLabel
        colorLabel.update(text: "Color: #565656", textAlignment: .left, font: UIFont.boldSystemFont(ofSize: 12), color: UIColor.init(red: 179/255, green: 179/255, blue: 179/255, alpha: 1))
        contentView.addSubview(colorLabel)
        
        brush.backgroundColor = .red // sets the background color to red
        brush.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(brush) // adds the view to the content view
    }
    
    func setConstraints() {
        
        // sets the contraints for the brush view
        NSLayoutConstraint.activate([
            brushView.widthAnchor.constraint(equalToConstant: 58),
            brushView.heightAnchor.constraint(equalToConstant: 58),
            brushView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            brushView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 14)
        ])
        // sets the constraints for the nameOfBrushLabel
        NSLayoutConstraint.activate([
            nameOfBrushLabel.leadingAnchor.constraint(equalTo: brushView.trailingAnchor, constant: 23),
            nameOfBrushLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 34),
            
        ])
        // set constraints for the colorLabel
        NSLayoutConstraint.activate([
            colorLabel.leadingAnchor.constraint(equalTo: brushView.trailingAnchor, constant: 23),
            colorLabel.topAnchor.constraint(equalTo: nameOfBrushLabel.bottomAnchor, constant: 0)
        ])
        // sets the constraint for the view
        NSLayoutConstraint.activate([
            brush.centerXAnchor.constraint(equalTo: brushView.centerXAnchor),
            brush.centerYAnchor.constraint(equalTo: brushView.centerYAnchor),
//            brush.widthAnchor.constraint(equalToConstant: CGFloat(10)),
//            brush.heightAnchor.constraint(equalToConstant: CGFloat(10)),
            
        ])
        
        // creates variable constraints
        widthConstraint = brush.widthAnchor.constraint(equalToConstant: 10)
        drawingHeightConstraints = brush.heightAnchor.constraint(equalToConstant: 10)
        
        widthConstraint?.isActive = true
        drawingHeightConstraints?.isActive = true

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
