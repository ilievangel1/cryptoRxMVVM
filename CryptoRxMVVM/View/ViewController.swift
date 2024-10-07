//
//  ViewController.swift
//  CryptoRxMVVM
//
//  Created by Angel Iliev on 4.10.24.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    let cryptoVM = CryptoViewModel()
    let disposeBag = DisposeBag()
    
    var crypto = Crypto()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.delegate = self
//        tableView.dataSource = self
        
        view.backgroundColor = .black
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        setupBindings()
        cryptoVM.requestData()
    }
    
    private func setupBindings() {
        cryptoVM.loading.bind(to: self.indicatorView.rx.isAnimating).disposed(by: disposeBag)
        
        cryptoVM.error.observe(on: MainScheduler.asyncInstance).subscribe { errorString in
            print(errorString)
        }.disposed(by: disposeBag)
        
        /*
         cryptoVM.crypto.observe(on: MainScheduler.asyncInstance).subscribe { crypto in
         self.crypto = crypto
         self.tableView.reloadData()
         }.disposed(by: disposeBag)
         */
        
        cryptoVM.crypto.observe(on: MainScheduler.asyncInstance).bind(to: tableView.rx.items(cellIdentifier: "CryptoCell", cellType: CryptoTableViewCell.self)) {row, item, cell in
            cell.item = item
        }.disposed(by: disposeBag)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    /*
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return crypto.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = crypto[indexPath.row].currency
        content.secondaryText = crypto[indexPath.row].price
        cell.contentConfiguration = content
        return cell
    }
     */
}

