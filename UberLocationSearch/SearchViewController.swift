//
//  SearchViewController.swift
//  UberLocationSearch
//
//  Created by Nazar Kopeika on 15.05.2023.
//

import UIKit
import CoreLocation /* 95 */

protocol SearchViewControllerDelegate: AnyObject { /* 96 */
    func searchViewController(_ vc: SearchViewController,
                              didSelectLocationWith coordinates: CLLocationCoordinate2D?) /* 97 */
}

class SearchViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource { /* 43 add 1 protocol */ /* 56 add 2 protocols */
    
    weak var delegate: SearchViewControllerDelegate? /* 98 */
    
    private let label: UILabel = { /* 19 */
        let label = UILabel() /* 20 */
        label.text = "Whete To?" /* 21 */
        label.font = .systemFont(ofSize: 24, weight: .semibold) /* 22 */
        return label /* 23 */
    }()
    
    private let field: UITextField = { /* 32 */
       let field = UITextField() /* 33 */
        field.placeholder = "Enter destination" /* 34 */
        field.layer.cornerRadius = 9 /* 35 */
        field.backgroundColor = .tertiarySystemBackground /* 36 */
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50)) /* 37 */
        field.leftViewMode = .always /* 38 */
        return field /* 39 */
    }()
    
    private let tableView: UITableView = { /* 49 */
       let table = UITableView() /* 50 */
        table.register(UITableViewCell.self,
                       forCellReuseIdentifier: "cell") /* 51 */
        return table /* 52 */
    }()
    
    var locations = [Location]() /* 63 */

    override func viewDidLoad() { /* 24 */
        super.viewDidLoad() /* 25 */
        view.backgroundColor = .secondarySystemBackground /* 26 */
        view.addSubview(label) /* 27 */
        view.addSubview(field) /* 40 */
        view.addSubview(tableView) /* 53 */
        tableView.delegate = self /* 54 */
        tableView.dataSource = self /* 55 */
        tableView.backgroundColor = .secondarySystemBackground /* 92 */
        
        field.delegate = self /* 41 */
    }
    
    override func viewDidLayoutSubviews() { /* 28 */
        super.viewDidLayoutSubviews() /* 29 */
        label.sizeToFit() /* 30 */
        label.frame = CGRect(x: 10, y: 10, width: label.frame.size.width, height: label.frame.size.height) /* 31 */
        field.frame = CGRect(x: 10, y: 20+label.frame.size.height, width: view.frame.size.width-20, height: 50) /* 42 */
        
        let tableY: CGFloat = field.frame.origin.y + field.frame.size.height+5 /* 71 */
        tableView.frame = CGRect(x: 0,
                                 y: tableY,
                                 width: view.frame.size.width,
                                 height: view.frame.size.height-tableY) /* 72 */
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool { /* 44 */
        field.resignFirstResponder() /* 45 */
        if let text = field.text, !text.isEmpty { /* 46 */
            LocationManager.shared.findLocations(with: text) { [weak self] locations in /* 47 */
                DispatchQueue.main.async { /* 70 */
                    self?.locations = locations /* 68 */
                    self?.tableView.reloadData() /* 69 */
                }
            }
        }
        return true /* 48 */
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { /* 57 */
        return locations.count /* 64 */
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { /* 58 */
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) /* 59 */
        cell.textLabel?.text = locations[indexPath.row].title /* 65 */
        cell.textLabel?.numberOfLines = 0 /* 66 */
        cell.contentView.backgroundColor = .secondarySystemBackground /* 93 */
        cell.backgroundColor = .systemBackground /* 94 */
        return cell /* 60 */
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { /* 61 */
        tableView.deselectRow(at: indexPath, animated: true) /* 62 */
        //Notify map controller to show pin at selected place
        let coordinate = locations[indexPath.row].coordinates /* 67 */
        
        delegate?.searchViewController(self,
                                       didSelectLocationWith: coordinate) /* 99 */
    }
}
