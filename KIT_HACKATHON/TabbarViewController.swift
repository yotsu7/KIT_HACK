//
//  TabbarViewController.swift
//  
//
//  Created by Tsubasa Takayama on 2015/09/20.
//
//

import UIKit

class TabbarViewController: UIViewController {
    
    var myTabBarController: UITabBarController!
    var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        // Tabに設定するViewControllerのインスタンスを生成.
        let myFirstTab: UIViewController = FirstViewController()
        let myTalkTab: UIViewController = TalkViewController()
        let myProfileTab: UIViewController = MyProfileViewController()
        let configurationTab: UIViewController = ConfigurationViewController()
        myFirstTab.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.Search, tag: 1)
        myTalkTab.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.TopRated, tag: 2)
        myProfileTab.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.Contacts, tag: 3)
        configurationTab.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.More, tag: 4)
        
        
        
        // タブを要素に持つArrayの.を作成する.
        let myTabs = NSArray(objects: myFirstTab, myTalkTab,myProfileTab, configurationTab)
        
        // UITabControllerの作成する.
        myTabBarController = UITabBarController()
        
        // ViewControllerを設定する.
        myTabBarController?.setViewControllers(myTabs as [AnyObject], animated: false)
        
        // RootViewControllerに設定する.
        appDelegate.window!.rootViewController = myTabBarController
        
        appDelegate.window!.makeKeyAndVisible()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
