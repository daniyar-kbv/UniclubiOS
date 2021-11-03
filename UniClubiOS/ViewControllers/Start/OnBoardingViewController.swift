//
//  OnBoardingViewController.swift
//  GOALSTER
//
//  Created by Daniyar on 8/10/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit
import Lottie

class OnBoardingViewController: UIViewController {
    lazy var boardingView = OnBoardingView()
    var currentIndex = 0
    var cells: [UICollectionViewCell] = []
    
    override func loadView() {
        super.loadView()
        
        view = boardingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        boardingView.collectionView.delegate = self
        boardingView.collectionView.dataSource = self
        
        configActions()
        
        loadCells()
    }
    
    func configActions() {
        boardingView.nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
    }
    
    @objc func nextTapped() {
        currentIndex += 1
        if currentIndex < 3{
            if currentIndex == 4 {
                boardingView.nextButton.setTitle("Далее", for: .normal)
            }
            boardingView.indicatorView.setCurrent(index: currentIndex)
            boardingView.collectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .right, animated: true)
        } else {
            let vc = FiltersMainViewController()
            vc.filtersView.navigationBar.leftButton.isHidden = false
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func loadCells() {
        cells.removeAll()
        for i in 0..<3 {
            let cell = boardingView.collectionView.dequeueReusableCell(withReuseIdentifier: OnBoardingCell.reuseIdentifier, for: IndexPath(item: i, section: 0)) as! OnBoardingCell
            cell.animationView = AnimationView(name: "onboarding\(i + 1)")
            cell.animationView?.loopMode = .loop
            
            cell.backView.addSubview(cell.animationView!)
            
            cell.animationView?.snp.makeConstraints({
                $0.top.equalToSuperview().offset(StaticSize.size(30))
                $0.centerX.equalToSuperview()
                $0.size.equalTo(StaticSize.size(350))
            })
            switch i {
            case 0:
                cell.topText.text = "Единая платформа"
                cell.bottomText.text = "Теперь все секции и занятия\nВаших детей собраны в одном месте"
                cell.animationView?.play()
            case 1:
                cell.topText.text = "Реальные отзывы"
                cell.bottomText.text = "Самые интересные образовтельные, спортивные, творческие кружки и онлайн занятия с реальными отзывами родителей и чатом для обсуждения"
            case 2:
                cell.topText.text = "Экономьте время"
                cell.bottomText.text = "Составьте персональное расписание занятий Ваших детей, а мы сделаем все остальное!"
            default:
                break
            }

            cells.append(cell)
        }
        boardingView.collectionView.reloadData()
    }
}

extension OnBoardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cells[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ScreenSize.SCREEN_WIDTH, height: StaticSize.size(610))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        for i in 0..<collectionView.numberOfItems(inSection: 0) {
            let cell = cells[i] as! OnBoardingCell
            indexPath.item == i ?
                cell.animationView?.play() :
                cell.animationView?.stop()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = boardingView.collectionView.frame.size.width
        let currentPage = (boardingView.collectionView.contentOffset.x / pageWidth)
        currentIndex = Int(currentPage)
        boardingView.nextButton.setTitle(currentIndex == 4 ? "Понятно" : "Далее", for: .normal)
        boardingView.indicatorView.setCurrent(index: currentIndex)
    }
}
