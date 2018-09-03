//
//  ViewController.swift
//  tracTest
//
//  Created by Lina Pischenko on 8/31/18.
//  Copyright © 2018 PischenkoLina. All rights reserved.
//

import UIKit

private let indentifier = "AnimatableCollectionViewCell"
private let collectionInset : CGFloat = 10.0

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private var collectionCells: Array<AnimatableCollectionViewCell> = Array()
    private var animateCollectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top:collectionInset, left: collectionInset, bottom: collectionInset, right: collectionInset)
        layout.itemSize = CGSize(width: view.frame.width / 5, height: view.frame.width / 5)
        animateCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout:layout)
        if let collection = animateCollectionView {
            collection.register(UINib(nibName: "AnimatableCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:indentifier)
            collection.delegate = self
            collection.dataSource = self
            collection.backgroundColor = .white
            view.addSubview(collection)
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ViewAnimation.count.rawValue
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = animateCollectionView?.dequeueReusableCell(withReuseIdentifier: indentifier, for: indexPath) as! AnimatableCollectionViewCell
        return cell
    }
    
    //MARK:UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let collection = animateCollectionView {
            let cell = collection.cellForItem(at: indexPath) as! AnimatableCollectionViewCell
            
            if let view = cell.animatedView {
               let animator = Animator.init()
                animator.applyAnimation(view: view, animatioIndex: ViewAnimation(rawValue: Int(indexPath.row))!)
            }
        }
    }
    
}

