//
//  ViewController.swift
//  UserDefaultLab
//
//  Created by David Lin on 1/13/20.
//  Copyright © 2020 David Lin (Passion Proj). All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var horoscopes = [Horoscopes]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        loadData()
    }
    
    @IBAction func enterNameButtonPressed(_ sender: UIButton) {
    
    }
    
    func loadData() {
        HoroscopeAPIClient.getHoroscope { (result) in
            switch result {
            case .failure(let appError):
                print(appError)
            case .success(let data):
                self.horoscopes = data
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let horoscopeDVC = segue.destination as? DetailedViewController,
            let indexPath = tableView.indexPathForSelectedRow else {
                fatalError()
        }
        let horoscope = horoscopes[indexPath.row]
        horoscopeDVC.horoscopeDetails = horoscope
    }
    
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        horoscopes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "horoscopeCell", for: indexPath) as? HoroscopeCell else {
            fatalError()
        }
        let horoscope = horoscopes[indexPath.row]
        cell.configureCell(horoscope: horoscope)
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
}
