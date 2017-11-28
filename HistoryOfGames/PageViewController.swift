//
//  PageViewController.swift
//  HistoryOfGames
//
//  Created by Pedro Velmovitsky on 23/11/17.
//  Copyright © 2017 adabestgroup. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource  {

    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.newViewController(id: "1"),
                self.newViewController(id: "2"),
                self.newViewController(id: "3")]
    }()
    
    private func newViewController(id: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewController(withIdentifier: "pageView\(id)")
    }
    
    private var nextPageSwipe: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        dataSource = self
        
         self.scrollView?.panGestureRecognizer.addTarget(self, action:#selector(self.handlePan(sender:)))
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }
    
    func handlePan(sender:UIPanGestureRecognizer) {
        print("nextPageSwipe: ", nextPageSwipe)
        switch sender.state {
        case .ended:
            self.nextPageSwipe = self.nextPageSwipe + 1
            print("User Swiped ")
            print(self.nextPageSwipe)
        default:
            break
        }
        
        if (nextPageSwipe == 3) {
            UserProfile.sharedInstance.userDefaults.set(false, forKey: "firstLogin")
            UserProfile.sharedInstance.firstLogin = false
            self.dismiss(animated: false, completion: nil)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let  nextIndex = viewControllerIndex + 1
        
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return orderedViewControllers.count
    }
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first, let firstViewControllerIndex = orderedViewControllers.index(of: firstViewController) else {
                return 0
        }
        
        return firstViewControllerIndex
    }

}

extension UIPageViewController {
    
    public var scrollView: UIScrollView? {
        for view in self.view.subviews {
            if let scrollView = view as? UIScrollView {
                return scrollView
            }
        }
        return nil
    }
    
}
