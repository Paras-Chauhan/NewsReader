import UIKit

class ViewController: UIViewController{

    @IBAction func button(_ sender: UIButton) {
        mainTableView.reloadData()
    }
    @IBOutlet weak var mainTableView: UITableView!
    
    var articles : [Article]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.delegate = self
        mainTableView.dataSource = self
       
        fetchArticles()
        
        //Calling the Methods of TabBarController Class
        
        let viewObj = TapBarController()

        viewObj.setUpTapBar()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func fetchArticles() {
        
        let urlRequest = URLRequest(url:URL(string :"https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=6b8d0cecf5d34d4f8857948bb65bf9dd")!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data,response,error) in
            if error != nil{
                
                print(error!)
            }
            self.articles = [Article]()
            
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String:Any]
                print(json)
                
                if let articlesFromJson = json["articles"] as? [[String:Any]]{
                    
                    for articlee in articlesFromJson{
                        
                        let article = Article()
                        
                        if let title = articlee ["title"] as? String {
                            article.title = title
                        }
                        
                        if let desc = articlee ["description"] as? String
                        {
                            article.desc = desc
                        }
                        if let author = articlee ["author"] as? String{
                            article.author = author
                        }
                        if let url = articlee ["url"] as? String {
                             article.url = url
                        }
                        if let imgUrl = articlee ["urlToImage"] as? String{
                          
                            article.imgUrl = imgUrl
                        }
                        self.articles?.append(article)
                    }
                    DispatchQueue.main.async {
                       self.mainTableView.reloadData()
                    }
                   
                }
            }
            catch let error {
                print (error)
            }
        }
        task.resume()
    }
    
  let menumanager = MenuManager()
    
    @IBAction func menubutton(_ sender: UIButton) {
    
    menumanager.openMenu()
    }
}
extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (articles?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = mainTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableCell
        if (articles?.count != 0){
        cell.titleLabel.text = self.articles?[indexPath.row].title
        cell.descriptionLabel.text = self.articles?[indexPath.row].desc
        cell.authorLabel.text = self.articles?[indexPath.row].author
            cell.newsImage.downoadImages(from:(self.articles?[indexPath.row].imgUrl)! )
           
            //Mark:- For Shadows on Cells.
            
            cell.layer.cornerRadius = 10
            let shadowPath2 = UIBezierPath(rect: cell.bounds)
            cell.layer.masksToBounds = false
            cell.layer.shadowColor = UIColor.black.cgColor
            cell.layer.shadowOffset = CGSize(width: CGFloat(1.0), height: CGFloat(3.0))
            cell.layer.shadowOpacity = 0.5
            cell.layer.shadowPath = shadowPath2.cgPath
            
            //MARK:- for animations on cells
            
            cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
            UIView.animate(withDuration: 0.9, animations: {
                cell.layer.transform = CATransform3DMakeScale(1.05,1.05,1)
            },completion: { finished in
                UIView.animate(withDuration: 0.9, animations: {
                    cell.layer.transform = CATransform3DMakeScale(1,1,1)
                })
            })
        }
        else{
            print()
        }
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController2") as! ViewController2
        
        secondViewController.url = (self.articles![indexPath.item].url as! String)
        
 self.navigationController?.pushViewController(secondViewController, animated: true)

    }
}
extension UIImageView{
    func  downoadImages(from url : String) {
        
        let urlRequest = URLRequest(url: URL(string:url)!)
        let task = URLSession.shared.dataTask(with: urlRequest) { (data,response,error) in
            if error != nil{
               print(error!)
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
    }
        task.resume()
}
}


