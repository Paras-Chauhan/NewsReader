

import UIKit

class ViewController2: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    var url:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.loadRequest(URLRequest(url : URL(string : url!)!))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
