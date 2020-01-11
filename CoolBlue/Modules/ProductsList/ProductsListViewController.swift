//
//  ViewController.swift
//  CoolBlue
//
//  Created by Amr Hossam on 1/11/20.
//  Copyright © 2020 Amr Hossam. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import MBProgressHUD
import DZNEmptyDataSet

class ProductsListViewController: UIViewController, UICollectionViewDelegateFlowLayout, ProductsListViewControllerProtocol {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UITextField!
    var bag = DisposeBag()
    internal var viewModel: ProductsListViewModelProtocol!

    func initialize(viewModel: ProductsListViewModelProtocol) {
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureBinding()
    }
    
    private func configureBinding() {
        collectionView.register(UINib(nibName: ProductCellName, bundle: nil), forCellWithReuseIdentifier: ProductCellID)
        
        viewModel.ProductsSubject
            .bind(to: collectionView.rx.items(cellIdentifier: "CellID", cellType: ProductCell.self)) { idx, product, cell in
                cell.configure(with: product)
        }.disposed(by: bag)

        collectionView.rx.didScroll
            .observeOn(MainScheduler.instance)
            .bind {
                if round(self.collectionView.contentSize.height - self.collectionView.contentOffset.y)
                    < self.collectionView.frame.height + 50 {
                    self.viewModel.getData()
                }
            }
            .disposed(by: bag)

        searchBar.rx.controlEvent(.editingDidEndOnExit)
            .bind {
                self.searchBar.resignFirstResponder()
                guard let text = self.searchBar.text else { return }
                self.viewModel.searchTerm.accept(text)
                self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
                self.collectionView.reloadEmptyDataSet()
                guard !text.isEmpty else { return }
                MBProgressHUD.showAdded(to: self.view, animated: true)
        }.disposed(by: bag)
        
        viewModel.ProductsSubject
            .do(onNext: { (_) in
                MBProgressHUD.hide(for: self.view, animated: true)
            }).subscribe().disposed(by: bag)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width / 2) - 21, height: 324)
    }
}

extension ProductsListViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "Type in your search keyword")
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "search")
    }
    
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        searchBar.becomeFirstResponder()
    }
    
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return (searchBar.text ?? "").isEmpty
    }
}
