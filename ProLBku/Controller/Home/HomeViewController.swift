//
//  HomeViewController.swift
//  ProLBku
//
//  Created by mac on 29/04/18.
//  Copyright © 2018 irwan. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var imageScroller: ImageScroller!
    var titleArray = [String]()
    @IBOutlet weak var EventCollection: UICollectionView!
    @IBOutlet weak var NewsCollection: UICollectionView!
   @IBOutlet weak var pageControl: UIPageControl!
    
   var sampleImages = ["image1.jpg","image1.jpg","image1.jpg","image1.jpg","image1.jpg"]
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavBarImage()
      
        imageScroller.delegate = self
        imageScroller.isAutoScrollEnabled = true
        imageScroller.scrollTimeInterval = 2.0 //time interval
        imageScroller.scrollView.bounces = false
        imageScroller.setupScrollerWithImages(images: sampleImages)
        imageScroller.isAutoScrollEnabled = true
        self.pageChanged(index: 0)
        
        

    }

   
    

    
   
    
  
    
    func addNavBarImage() {
        
        let navController = navigationController!
        
        let image = UIImage(named: "logo") 
        let imageView = UIImageView(image: image)
        
        let bannerWidth = navController.navigationBar.frame.size.width
        let bannerHeight = navController.navigationBar.frame.size.height
        
        let bannerX = bannerWidth / 2 - (image?.size.width)! / 2
        let bannerY = bannerHeight / 2 - (image?.size.height)! / 2
        
        imageView.frame = CGRect(x: bannerX, y: bannerY, width: 150, height: bannerHeight)
        imageView.contentMode = .scaleAspectFit
        
        navigationItem.titleView = imageView
        
        
        let logo = UIBarButtonItem(image: UIImage (named: "notificationsActiveMaterial")?.withRenderingMode(.alwaysOriginal), style: UIBarButtonItemStyle.plain, target: self, action: nil)
        
        self.navigationItem.rightBarButtonItem = logo
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        var count = 0
        if (collectionView == self.EventCollection) {
            count = 5
        }
        else {
            count = 5
        }
        
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        
        if (collectionView == self.EventCollection) {
            let cell:HomeCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventCell", for: indexPath) as! HomeCollectionViewCell
            return cell
        } else {
            let cell2:NewsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsCell", for: indexPath) as! NewsCollectionViewCell
            return cell2
        }

        
    }



}

extension HomeViewController : ImageScrollerDelegate{
    
    func pageChanged(index: Int) {
//        self.pageIndicatorLabel.text = String(format: "%d/%d", index+1,self.sampleImages.count)
        print(index+1)
        self.pageControl.currentPage = index
    }
}
