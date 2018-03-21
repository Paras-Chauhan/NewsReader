

import UIKit

class TapBarController: UITabBarController {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //tabBar.barTintColor = UIColor(green : 50 ,red : 50 ,blue : 50,alpha : 1)
        tabBar.barTintColor = UIColor(red: 38/255,green: 196/255, blue: 133/255,alpha : 1)
        setUpTapBar()
        
        view.addSubview(tabBar)
    }
    
        func setUpTapBar(){
            
            let favourite = UINavigationController(rootViewController : FirstVC())
            favourite.tabBarItem.image = UIImage(named : "icon11")
            
            favourite.tabBarItem.selectedImage = UIImage(named: "icon11")
            
            let latest = UINavigationController(rootViewController : SecondVC())
            latest.tabBarItem.image = UIImage(named : "icon12")
            latest.tabBarItem.selectedImage = UIImage(named: "icon12")
            
            let share = UINavigationController(rootViewController : ThirdVC())
            share.tabBarItem.image = UIImage(named : "icon13")
            
            share.tabBarItem.selectedImage = UIImage(named: "icon13")
            
            let more = UINavigationController(rootViewController : FourthVC())
            more.tabBarItem.image = UIImage(named : "icon14")
            
            more.tabBarItem.selectedImage = UIImage(named: "icon14")
            
            viewControllers = [favourite, latest ,share, more]
        }
    }

