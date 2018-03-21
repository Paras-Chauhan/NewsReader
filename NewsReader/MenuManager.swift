

import UIKit

class MenuManager: NSObject {
    
    let menuTableView = UITableView()
let blackView = UIView()
    let arrayOfSources = ["Settings","Email-Address","Share on Facebook","Send Feedback","Rate on App Store","About Us","Help"]
  
   
    
    public func openMenu(){
        
        if let window = UIApplication.shared.keyWindow{
            
            blackView.frame = window.frame
            blackView.backgroundColor = UIColor(white: 0 ,alpha : 0.7)
            
              let height : CGFloat = 300
             let y = window.frame.height - height
            menuTableView.frame = CGRect(x:0,y:window.frame.height,width : window.frame.width,height:height)
          
            
           
            blackView.addGestureRecognizer(UITapGestureRecognizer(target:self,action: #selector(self.dismisMenu)))
            window.addSubview(blackView)
            window.addSubview(menuTableView)
            UIView.animate(withDuration: 0.5, animations: {
                self.blackView.alpha = 1
                self.menuTableView.frame.origin.y = y
            })
        }
    }
    @objc public func dismisMenu(){
        UIView.animate(withDuration:0.5) {
            self.blackView.alpha = 0
           // self.menuTableView.frame.origin.y = UIWindow
            if let window = UIApplication.shared.keyWindow{
                self.menuTableView.frame.origin.y = window.frame.height
            }
        }
    }
    override init() {
        super.init()
        menuTableView.delegate = self
        menuTableView.dataSource = self
        menuTableView.isScrollEnabled = true
        menuTableView.bounces = true
        
        menuTableView.register(BaseViewCell.classForCoder(), forCellReuseIdentifier: "CellID")
    }
}
extension MenuManager:UITableViewDataSource,UITableViewDelegate{
    
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return arrayOfSources.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = menuTableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath) as! UITableViewCell
    cell.textLabel?.text = arrayOfSources[indexPath.row]
    return cell
}
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}


