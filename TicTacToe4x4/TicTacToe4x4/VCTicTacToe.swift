//
//  VCTicTacToe.swift
//  TicTacToe4x4
//
//  Created by DCS on 08/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class VCTicTacToe: UIViewController {

    public  let myLabel:UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 45)
        label.textColor = UIColor(red: 0.53, green: 0.81, blue: 0.98, alpha: 1.00)
        label.text = "Tic Tac Toe"
        label.textAlignment = .center
        return label
    }()
    private var state = [2,2,2,2,
                         2,2,2,2,
                         2,2,2,2,
                         2,2,2,2]
    
    private let winningCombination = [[0,1,2,3],[4,5,6,7],[8,9,10,11],[12,13,14,15],[0,4,8,12],[1,5,9,13],[2,6,10,14],[3,7,11,15],[0,5,10,15],[3,6,9,12]]
    
    private var zeroFlag = false
    
    private let myCollectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 170,left:20, bottom: 20, right:20)
        layout.itemSize = CGSize(width:70, height:70)
        let collectionView = UICollectionView(frame: .zero,collectionViewLayout: layout)
        
        collectionView.backgroundColor = UIColor(patternImage:  UIImage(named: "gamebg")!)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(myCollectionView)
        setupCollectionView()
        view.addSubview(myLabel)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
       
         myCollectionView.frame = CGRect(x: 0, y: 0, width: view.width , height: view.height)
         myLabel.frame = CGRect(x: 5, y: 55, width: view.width, height: 100)
    }
    
}
extension VCTicTacToe:UICollectionViewDataSource, UICollectionViewDelegate{
    
    private func setupCollectionView() {
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        
        myCollectionView.register(T3Cell.self, forCellWithReuseIdentifier: "T3Cell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "T3Cell", for: indexPath) as! T3Cell
        cell.setupCell(with: state[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if state[indexPath.row] != 0 && state[indexPath.row] != 1 {
            
            state.remove(at: indexPath.row)
            if(zeroFlag) {
                state.insert(0, at: indexPath.row)
            }
            else {
                state.insert(1, at: indexPath.row)
            }
            
            zeroFlag = !zeroFlag
            collectionView.reloadSections(IndexSet(integer: 0))
            checkWinner()
            
        }
    }
    private func checkWinner() {
        if !state.contains(2)
        {
            resetState()
            let title = "Game Over"
            let alert = UIAlertController(title: title, message: "Draw", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            DispatchQueue.main.async {
                self.present(alert,animated: true)
            }
        }
        else {
            for i in winningCombination {
                if state[ i[0] ] == state[ i[1] ] && state[ i[1] ] == state[ i[2] ] && state[ i[2] ] == state[ i[3] ] &&  state [ i[0] ]  != 2{
                    
                    let title = "Game Over"
                    let alert = UIAlertController(title: title, message: "Congratulation Player \(state[ i[0] ]) Won", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                    DispatchQueue.main.async {
                        self.present(alert,animated: true)
                    }
                    resetState()
                    break
                }
            }
        }
    }
    private func resetState() {
        state = [2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2]
        zeroFlag = false
        myCollectionView.reloadSections(IndexSet(integer: 0))
    }

}
