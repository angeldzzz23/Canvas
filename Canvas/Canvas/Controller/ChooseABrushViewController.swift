//
//  ChooseABrushViewController.swift
//  Canvas
//
//  Created by angel zambrano on 8/29/21.
//

import UIKit

//MARK: Delegate Methods
// protocol in charged of editing an exisiting
protocol EditProtocol: class {
    func edit(brush: Brush)
    func save(brush: Brush)
}


// the protocal in charged of saving a new
protocol saveProtocol: class {
    func saveProtocol(newBrush: Brush)
}


class ChooseABrushViewController: UIViewController {
    // the label that containts the title
    var titleLbl = UILabel()
    // the search bar textfield
    var titleTextField = UITextField()
    // table view
    var tableView = UITableView()
    // the identifier of the tableview
    let identifier = "brushID"
    // the trash Button
    let TrashView = UIView()
    let trashButton = UIButton() // creates a UIButton
    // the editButton
    let editView = UIView()
    let editButton = UIButton()
    
    /// the cell the user has chosen
    var selectedCell: BrushTableViewCell? = nil
    
    var delegate: CanvasDelegate?
    
    var canvasss: [Brush] = []
    
    init() {
        super.init(nibName: nil, bundle: nil)
        // first initializer
        let canvas1 =  Brush(nameOfBrush: "Cool Brush 1", lengthOfBrush: 20, color: .blue, radius: 10)
        let canvas2 =  Brush(nameOfBrush: "Cool Brush 2", lengthOfBrush: 25, color: .red, radius: 10)
        let canvas3 =    Brush(nameOfBrush: "lazy Brush 3", lengthOfBrush: 30, color: .brown, radius: 10)
        let canvas4 =    Brush(nameOfBrush: "trip Brush 4", lengthOfBrush: 50, color: .gray, radius: 10)
        let canvas5 =      Brush(nameOfBrush: "coffee Brush 5", lengthOfBrush: 20, color: .orange, radius: 10)
        let canvas6 = Brush(nameOfBrush: "cofefe Brush 6", lengthOfBrush: 10, color: .purple, radius: 10)
        
        
        canvasss = [canvas1, canvas2, canvas3, canvas4, canvas5, canvas6]
        
    }
    
    init(with brushes: [Brush]) {
        self.canvasss = brushes
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.contentSize.height = 100
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        if selectedCell != nil {
            let index = tableView.indexPath(for: selectedCell!)
            let brush = canvasss[index!.row]
            delegate?.get(brush: brush)
        }
        // saves the brushes to the intial controller
        delegate?.brushes(brushes: canvasss)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set the background color to white
        view.backgroundColor = .white
        title = "Brushes"
        updateViews() // calling update views
        updateConstraints() // calling update constraints
        
  
        // Do any additional setup after loading the view.
    }
    
    
    func updateViews() {
        
        // create a titleLabel
        titleLbl.update(text: "TITLE", textAlignment: .center, font: UIFont.boldSystemFont(ofSize: 14), color: UIColor.init(red: 181/255, green: 181/255, blue: 181/255, alpha: 1))
        view.addSubview(titleLbl)
        
        // creates the text field
        titleTextField.placeholder = "enter a name"
        titleTextField.layer.masksToBounds = false
        titleTextField.font = UIFont.systemFont(ofSize: 12)
        titleTextField.borderStyle = .none
        titleTextField.layer.cornerRadius = 8
        titleTextField.backgroundColor = UIColor.init(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
        let titleTextFieldPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.titleTextField.frame.height))
        titleTextField.leftView = titleTextFieldPaddingView
        titleTextField.leftViewMode = UITextField.ViewMode.always
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleTextField)
        
        // create tableview
        tableView.translatesAutoresizingMaskIntoConstraints  = false
        tableView.register(BrushTableViewCell.self, forCellReuseIdentifier: identifier)
        tableView.delegate = self
        tableView.dataSource  = self
        view.addSubview(tableView)
        
                                                // creating the trash button
        // create the view
        TrashView.backgroundColor = .white // set the color the for the viewButton
        TrashView.translatesAutoresizingMaskIntoConstraints = false
        TrashView.layer.cornerRadius = 30
        TrashView.layer.borderWidth = 5
        TrashView.layer.borderColor = UIColor.init(red: 215/255, green: 113/255, blue: 56/255, alpha: 1).cgColor
        view.addSubview(TrashView)
        
        // add shadow to the UIView
        TrashView.addShadow2(offset: CGSize(width: 2, height: 2), color: UIColor.black, radius: 2, opacity: 0.35)
        
        // sets
        trashButton.setBackgroundImage(UIImage(named: "Delete"), for: .normal)
        trashButton.backgroundColor = .clear
        trashButton.addTarget(self, action: #selector(trashButtonWasPressed), for: .touchUpInside)
        trashButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(trashButton)
        
                                                // creating the delete button
        
        editView.backgroundColor = .white // set the color the for the viewButton
        editView.translatesAutoresizingMaskIntoConstraints = false
        editView.layer.cornerRadius = 30
        editView.layer.borderWidth = 5
        editView.layer.borderColor = UIColor.init(red: 64/255, green: 186/255, blue: 213/255, alpha: 1).cgColor
        view.addSubview(editView)
        // add shadow to the UIView
        editView.addShadow2(offset: CGSize(width: 2, height: 2), color: UIColor.black, radius: 2, opacity: 0.35)
        // sets the editButton
        editButton.setBackgroundImage(UIImage(named: "Edit"), for: .normal)
        editButton.backgroundColor = .clear
        editButton.addTarget(self, action: #selector(editButtonWasPressed), for: .touchUpInside)
        editButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(editButton)
        
        // add a brush Button
        
//        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonWasPressed))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Brush", style: .plain, target: self, action: #selector(addButtonWasPressed))

//        navigationItem.rightBarButtonItem = add
    }
    
    
    @objc func addButtonWasPressed() {
        let presentVC = EditBrushViewController() // initializers the Edit BrushViewcontroller
        // implement delegate
        presentVC.delegate = self
        // present VC
        self.present(presentVC, animated: true, completion: nil)
    }

    
    // deleting selectedBrush
   @objc func trashButtonWasPressed() {
    if let selectedIndexPath = tableView.indexPathForSelectedRow {
        let index = selectedIndexPath.row // gets the index of the selectedIndexPath
        canvasss.remove(at: index) // removes data from our array of canvases
        selectedCell?.deselect() // deselects the selectedCell
        selectedCell = nil // sets the selectedCell to nil
        tableView.reloadData() // refreshes the table view
        }
    }
    
    
    @objc func editButtonWasPressed() {
        // check if any cell is pressed by verifying there is a selected cell
        if selectedCell != nil { // there is a selected cell
            // get the selected cell and intialize the EditBrushViewController
            if let index = tableView.indexPathForSelectedRow?.row {
                let presentVC = EditBrushViewController(currentBrush: canvasss[index] )
                // assings delegate to self
                presentVC.delegate = self
                self.present(presentVC, animated: true, completion: nil)
            }
        }
        //TODO: Delegate so that we receive info
        print("edit button was pressed.")
    }
    
    
    
    func updateConstraints() {
        // create constraints for the titleLabel
        NSLayoutConstraint.activate([
            titleLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 14),
            titleLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 58),
        ])
        // create constraints for titleTextField
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 8),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -34),
            titleTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
        // create tableView
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 23),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -34),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
                                        // trash button
        NSLayoutConstraint.activate([
            TrashView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            TrashView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            TrashView.widthAnchor.constraint(equalToConstant: 60),
            TrashView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            trashButton.topAnchor.constraint(equalTo: TrashView.topAnchor, constant: 60 * 0.29),
            trashButton.leadingAnchor.constraint(equalTo: TrashView.leadingAnchor, constant: (60 * 0.29)),
            trashButton.trailingAnchor.constraint(equalTo: TrashView.trailingAnchor, constant: -(60 * 0.29) - 0.5),
            trashButton.bottomAnchor.constraint(equalTo: TrashView.bottomAnchor, constant: -(60 * 0.29) - 0.5),
        ])
        
                                    // edit a brush button
        // setting up the view
        NSLayoutConstraint.activate([
            editView.centerXAnchor.constraint(equalTo: TrashView.centerXAnchor),
            editView.bottomAnchor.constraint(equalTo: TrashView.topAnchor, constant: -18),
            editView.widthAnchor.constraint(equalToConstant: 60),
            editView.heightAnchor.constraint(equalToConstant: 60)
            
        ])
        
        
        NSLayoutConstraint.activate([
            editButton.topAnchor.constraint(equalTo: editView.topAnchor, constant: 60 * 0.29),
            editButton.leadingAnchor.constraint(equalTo: editView.leadingAnchor, constant: (60 * 0.29)),
            editButton.trailingAnchor.constraint(equalTo: editView.trailingAnchor, constant: -(60 * 0.29) - 0.5),
            editButton.bottomAnchor.constraint(equalTo: editView.bottomAnchor, constant: -(60 * 0.29) - 0.5),
        ])
        
        
    }
    
 
    

    
    

}

extension ChooseABrushViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! BrushTableViewCell
        
        if selectedCell != nil {
            // deselect prev selected cell
            selectedCell?.deselect()
            // set selectedCell to the new cell
            selectedCell = cell
            // select the new
            cell.selectCell()
        } else { // first cell pressed
            selectedCell = cell
            cell.selectCell()
        }
    }
}


extension ChooseABrushViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // review here
         let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! BrushTableViewCell
        let canvaObject = canvasss[indexPath.row]
        cell.length = Float(canvaObject.lengthOfBrush)
        cell.configureCell(canva: canvaObject)
      
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return canvasss.count
    }
    
    
}

// extension for editing a brush
extension ChooseABrushViewController: EditProtocol {
 
    
    func edit(brush: Brush) {
        // get the brush that was selected
        if selectedCell != nil {
            print("hereeee")
            // you get index of the selected cell
            let index = tableView.indexPath(for: selectedCell!)
            // you make it equal to the new brush
            canvasss[index!.row] = brush
            
            // reload the tableview
            tableView.reloadData()
            // deselect current selected row
            selectedCell!.deselect()
            selectedCell = nil
        }
    }
    
    func save(brush: Brush) {
        canvasss.append(brush) // apends the
        
        // deselectCell
        if selectedCell != nil {
            selectedCell!.deselect() // deselects the selectedCell
            selectedCell = nil //

        }
        
        tableView.reloadData() // appends reloads the tableview
        selectedCell = nil //

    }
}


