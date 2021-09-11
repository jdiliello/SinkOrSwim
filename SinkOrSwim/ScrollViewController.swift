//
//  ScrollViewController.swift
//  SinkOrSwim
//
//  Created by Joseph DiLiello on 9/6/21.
//

import UIKit

class ScrollViewController: UIViewController, UIScrollViewDelegate {

    lazy var movieModel = {
        return MovieModel.sharedInstance()
    }()
    
    lazy private var imageView: UIImageView? = {
        // display image name comes from the handoff between the table view controller
        // and the scroll view controller
        let titleDict = self.movieModel.movieDict[displayImageName] as! NSMutableDictionary
        return UIImageView.init(image: titleDict["poster"] as? UIImage)
    }()
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var displayImageName = "Thor Ragnarok"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("scroll view did load")

        if let size = self.imageView?.image?.size{
            self.scrollView.addSubview(self.imageView!)
            self.scrollView.contentSize = size
            self.scrollView.minimumZoomScale = 0.1
            self.scrollView.delegate = self
        }
        
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    


}

