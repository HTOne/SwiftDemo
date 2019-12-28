//
//  HomeViewController.swift
//  Shopping
//
//  Created by apple on 2019/11/11.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import LLCycleScrollView


enum HTError: Error {
    case test
}

class HomeViewController: BaseViewController {
    
    private var bannerList = [BannerModel]()
    private var homeData: HomeData?

    lazy var cv: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        flowLayout.itemSize = CGSize(width: (screenWidth - 30) / 2.0, height: (screenWidth - 30) / 2.0 + 60)
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.contentInset = UIEdgeInsets(top: screenWidth * 0.467, left: 0, bottom: 0, right: 0)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.mj_header  = MJRefreshNormalHeader{
            [weak self] in self?.loadData()
        }
        collectionView.mj_header.ignoredScrollViewContentInsetTop = screenWidth * 0.467
        return collectionView
    }()
    
    lazy var banner: LLCycleScrollView = {
        let bw = LLCycleScrollView()
        bw.backgroundColor = UIColor.background
        bw.autoScrollTimeInterval = 6
        bw.placeHolderImage = UIImage(named: "normal_placeholder")
        bw.coverImage = UIImage()
        bw.pageControlPosition = .center
        bw.pageControlBottom = 20
        bw.titleBackgroundColor = UIColor.clear
        return bw
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
        
    }
    func loadData() {
        mallProvider.request(.homeBanner, model: Banners.self) { (result) in
            self.bannerList = result?.adv_list ?? []
//            self.banner.imagePaths = self.bannerList.filter { $0.adv_image != nil }.map {
//                $0.adv_image!}
            
            self.banner.imagePaths = self.bannerList.filter { (item) -> Bool in
                return item.adv_image != nil
            }.map { (item) -> String in
                return item.adv_image!.absoluteStr
            }

            print(self.banner.imagePaths)
        }
        
        mallProvider.request(.home, model: HomeData.self) { (result) in
            self.homeData = result ?? nil
            self.cv.head.endRefreshing()
            self.cv.reloadData()
        }
    }
    
    override func configUI() {
        view.addSubview(cv)
        cv.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view.snp.edges)
        }
        cv.addSubview(banner)
        banner.snp.makeConstraints {
            $0.left.equalToSuperview().offset(10)
            $0.width.equalTo(screenWidth - 20)
            $0.top.equalToSuperview().offset(-screenWidth * 0.467 + 10)
            $0.height.equalTo(cv.contentInset.top - 20)
        }
        
        self.cv.register(cellType: GoodCollectionViewCell.self)
        

    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return self.homeData?.free?.count ?? 0
        } else if section == 1 {
            return self.homeData?.discount?.count ?? 0
        }
        return self.homeData?.recommend?.count ?? 0
     }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: GoodCollectionViewCell.self)
        if indexPath.section == 0 {
            cell.model = self.homeData?.free?[indexPath.row]
        } else if indexPath.section == 1 {
            cell.model = self.homeData?.discount?[indexPath.row]
        } else if indexPath.section == 2 {
            cell.model = self.homeData?.recommend?[indexPath.row]
        }
        return cell;
    }
    
    
}
