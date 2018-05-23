//
//  Home.swift
//  Birdzi
//
//  Created by Dinesh Jagtap on 4/16/18.
//  Copyright © 2018 Birdzi. All rights reserved.
//

import UIKit
import SVProgressHUD
import TTGSnackbar
import Alamofire
//import Beacons
import CoreLocation
import JTMaterialTransition

class Home: UIViewController {
    @IBOutlet weak var upperView: UIView!

    
    @IBOutlet weak var listCount: UILabel!
    var grid1 :NSMutableArray = []
    var grid2 :NSMutableArray = []
    @IBOutlet weak var searchTxt: UITextField!
    var jsonResult:NSDictionary = [:]
 //   @IBOutlet weak var stackView: UIStackView!
    var imageNames :NSMutableArray = []
    @IBOutlet weak var bgBlure: UIImageView!
    @IBOutlet weak var logoImg: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var menuBtn: UIButton!
    var transition: JTMaterialTransition?
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.readLocalJsonFile()
        searchTxt.layer.masksToBounds = false
        searchTxt.layer.shadowColor = UIColor.lightGray.cgColor
        searchTxt.layer.shadowOpacity = 0.5
        searchTxt.layer.shadowRadius = 4.0
        searchTxt.layer.shadowOffset = CGSize(width:0.0,  height:1.0)
        bgBlure.blurImage(frame: self.logoImg.frame)
      //   self.VERAPICall()
      self.APICall()
        self.transition = JTMaterialTransition(animatedView: self.menuBtn)
        self.transition?.transitionDuration = 0.6
        
   //     self.menuBtn.addTarget(self, action: #selector(buttonWasTapped), for: .touchUpInside)
//        UIView.animate(withDuration: 12.8) {
//            self.upperView.isHidden = false
//        //    self.heightUpperView.constant  = 372
//            self.view.layoutIfNeeded()
//        }
     //   BirdziBeacon.sharedController(actionDelegate: <#T##BirdziBeaconDelegate#>, config: <#T##CFBConfig#>)
      //   BirdziBeacon.shared.hello()
        
     //   BirdziBeacon.sharedController(actionDelegate: self as! BirdziBeaconDelegate, config: nil)
       // Beacon.shared.open();proximityuuid
       // Beacon.shared
    //    Beacon.hello(self)
       // Beacon.shared.hello()
   //     Beacon.shared.beaconConnect(UUID: "7735534D-0C98-4F2E-8C9C-AFB090D0B6C0", cKey: "3604", appKey: "60M61fLIWw3tGcoDvldkIkMxQ4DTrpd6DQ6dlbwV1bMmmzxSpH4OIiKOWVK1CPy2XTznU5ejXJb47eZAXkfEENObhy4JjIPQ")

        // Do any additional setup after loading the view.
    }
    @objc func buttonWasTapped() {
        assertionFailure("This method should be implemented in subclasses")
    }
    override func viewWillAppear(_ animated: Bool) {
 
       super.viewWillAppear(animated)

    }
    @IBAction func menuBtn(_ sender: UIButton) {
         let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "Menu") as! Menu
//
        secondVC.modalPresentationStyle = .custom
        secondVC.transitioningDelegate = self.transition
//
        self.present(secondVC,animated: true, completion: nil)
     //   pushViewController(secondVC,animated: true, completion: nil)
//  self.navigationController?.pushViewController(secondVC, animated: false)
//
      // self.present(secondVC, animated: true, completion: nil)
//        UIView.animate(withDuration: 0.75, animations: { () -> Void in
//            UIView.setAnimationCurve(UIViewAnimationCurve.easeInOut)
//            self.navigationController!.pushViewController(secondVC, animated: false)
//            UIView.setAnimationTransition(UIViewAnimationTransition.flipFromLeft, for: self.navigationController!.view!, cache: false)
//        })
    }
    func VERAPICall() {
        SVProgressHUD.show()
        //DispatchQueue.global(qos: .userInitiated).async {
//        appkey:7yny97nmlLhppyxdC6gegeb3bzg2
//        companyid:6
//        deviceid:020000000000
//        advertisingidentifier:
//        version:2.9.2-1
//        osversion:11.3
//        blecapable:FALSE
//        customerid:1000111402
//        customerkey:B691A224-537E-46B0-A629-9F3D096F12DD@MDE2MjAwNzI0MzUxMjE5ODMyOTEwMDAwMjk4NTcyMDE4MjA0MjExMzEwNDQxNDI1MTM4NDA3KzAw
//        devicetypecode:iphone
//        devicetoken:1

        let headers: HTTPHeaders = [
            "appkey": GlobalVariables.globalAppKey,
            "companyid" : GlobalVariables.globalCompanyId,
            "deviceid": "020000000000",
      //      "deviceid" :  UserDefaults.standard.string(forKey: "customerdeviceid")!,
            "advertisingidentifier": "B691A224-537E-46B0-A629-9F3D096F12DD",
            "version" :"2.9.2-1",
             "osversion" : "11.3",
            "blecapable" : "FALSE",
            "customerid" : UserDefaults.standard.string(forKey: "customerid")!,
            "customerkey" :  UserDefaults.standard.string(forKey: "customersharedsecret")!,
            "devicetypecode" : "iphone",
            "devicetoken":  "1"
        ]
        print(headers)
        
        APIUtilities.sharedInstance.getReqURL(getVersionUrl, parameters: [:], headers: headers, completion:  {
            (req, res, data)  -> Void in
            SVProgressHUD.dismiss()
            if(data.isSuccess) {
                
                //        let dataArr = ((data.value as AnyObject).value(forKey: "BookMyShow") as! NSDictionary).value(forKey: "arrEvent") as! NSArray
                if let results = (data.value as AnyObject) as? NSDictionary {
                    print ("\(results) results found")
                    //    let list = results.allValues.first as! NSArray
                    if (results.value(forKey: "statusCode") as! Int != 0)
                    {
                        if (results.value(forKey: "status") as! Int != 0)
                        {
                            if(results.value(forKey: "status") as! Int == 22222)
                            {
                              //  self.jsonResult = results.value(forKey: "data") as! NSDictionary
                              //  self.readLocalJsonFile()
                                if let details = (results.value(forKey: "data")) as? NSDictionary {
                                  UserDefaults.standard.set(details.value(forKey: "proximityuuid") as! String, forKey:"UUID")
//                                    Beacons.shared.clManager = CLLocationManager()
//                                    Beacons.shared.clManager.requestAlwaysAuthorization()
//                                    Beacons.shared.searchBeacon(uuid: UserDefaults.standard.string(forKey: "UUID")!, appkey: GlobalVariables.globalAppKey, company_id: GlobalVariables.globalCompanyId, device_id: "020000000000", cust_key: UserDefaults.standard.string(forKey: "customersharedsecret")!, cust_id: UserDefaults.standard.string(forKey: "customerid")!, browser_store_id: "")
//
//                                    Beacons.shared.clManager.requestAlwaysAuthorization()
                                }
                            }
                                
                            else
                            {
                                let snackbar = TTGSnackbar(message: results.value(forKey: "message") as! String, duration: .long)
                                snackbar.messageTextColor = .red
                                
                                snackbar.show()
                                
                            }
                            
                        }
                        
                    }
                    //print (list)
                }
                
         
            }
            else if(data.isFailure) {
                let dataString = String(data: data.value as! Data, encoding: String.Encoding.utf8)
                let snackbar = TTGSnackbar(message: dataString!, duration: .short)
                snackbar.show()
            }
        })
    }
    
    func APICall() {
        SVProgressHUD.show()
        //DispatchQueue.global(qos: .userInitiated).async {
        
        
        APIUtilities.sharedInstance.getReqURL(getHomeUrl, parameters: [:], headers: [:], completion:  {
            (req, res, data)  -> Void in
            SVProgressHUD.dismiss()
            if(data.isSuccess) {
                
                //        let dataArr = ((data.value as AnyObject).value(forKey: "BookMyShow") as! NSDictionary).value(forKey: "arrEvent") as! NSArray
                if let results = (data.value as AnyObject) as? NSDictionary {
                    print ("\(results) results found")
                    //    let list = results.allValues.first as! NSArray
                    if (results.value(forKey: "statusCode") as! Int != 0)
                    {
                        if (results.value(forKey: "status") as! Int != 0)
                        {
                            if(results.value(forKey: "status") as! Int == 22222)
                            {
                                 self.jsonResult = results.value(forKey: "data") as! NSDictionary
                                self.readLocalJsonFile()
                            }
                                
                            else
                            {
                                let snackbar = TTGSnackbar(message: results.value(forKey: "message") as! String, duration: .long)
                                snackbar.messageTextColor = .red
                                
                                snackbar.show()
                                
                            }
                            
                        }
                        
                    }
                    //print (list)
                }
                
                //let dataString = String(data: data.value as! NSDictionary, encoding: String.Encoding.utf8)
                // let dataArr = ((data.value as AnyObject).value(forKey: "BookMyShow") as! NSDictionary).value(forKey: "arrEvent") as! NSArray
                //        let snackbar = TTGSnackbar(message: "Succsess Call", duration: .long)
                //        snackbar.show()
                
            }
            else if(data.isFailure) {
                let dataString = String(data: data.value as! Data, encoding: String.Encoding.utf8)
                let snackbar = TTGSnackbar(message: dataString!, duration: .short)
                snackbar.show()
            }
        })
    }
     private func readLocalJsonFile() {
        
     
             //   print(dataString)
               
                    let tem=jsonResult.value(forKey: "status") as! Int
                    if tem==1
                
                    {
                        var scroll_height : Float = 0
                        var cnt : Int = 0
                        var i : Int = 0

                        let dict=jsonResult.value(forKey: "data") as! NSArray
                        for objs  in dict
                        {
                            let dataDict = objs as! NSDictionary
                            let scale: CGFloat = UIScreen.main.scale
                            print(scale)
                            let Heights:Float = Float(truncating: dataDict["height"] as! NSNumber)
                            let scaleHeight = Heights  //* Float(scale) / Float(UIScreen.main.bounds.height)
                            let rounded :Float = Float(truncating: dataDict["rounded"] as! NSNumber )

                            let yPos : Float = Float(scroll_height) + 15
                            cnt = cnt + 1 ;
                            let DynamicView1 : UIView = UIView(frame:  CGRect(origin: CGPoint(x: 5,y :Int(yPos)), size: CGSize(width: CGFloat(self.view.frame.width - 10) , height:  CGFloat(scaleHeight) )))
                            scroll_height = scroll_height + Float(DynamicView1.frame.height);
                            DynamicView1.cornerRadius = CGFloat(rounded)
                            print(DynamicView1.frame)
                            DynamicView1.clipsToBounds = true
                            // self.view.addSubview(DynamicView2)
                            if(dataDict["type"] as! String == "banner")
                            {
                             //   print(objs)
                                GlobalVariablesArr.globalBannerArr = []
                                GlobalVariablesArr.globalActionArr = []

                                let dicts=dataDict.value(forKey: "sub_data") as! NSArray
                                for objss  in dicts
                                {
                                    let dataDicts = objss as! NSDictionary
                                    let url = URL(string:  dataDicts["url"] as! String)
                                    GlobalVariablesArr.globalBannerArr.add(url!)
                                     let url1 = URL(string:  dataDicts["action_url"] as! String)
                                     GlobalVariablesArr.globalActionArr.add(url1!)
                                }
                                
                               // GlobalVariablesArr.globalBannerArr = self.imageNames
                            //    let bannerView = loadViewFromNib()
                            
                                //DynamicView1.addSubview(bannerView)
                          //      let customView: bannerView  = bannerView()
                            //    let customViewDummy: bannerView = Bundle.main.loadNibNamed("bannerView", owner: self, options: nil)![0] as! bannerView
                                    DynamicView1.frame = CGRect(origin: CGPoint(x: 0,y :Int(yPos)), size: CGSize(width: CGFloat(self.view.frame.width) , height:  CGFloat(scaleHeight) ))
                                let item = bannerView(frame:DynamicView1.frame)
                                DynamicView1.addSubview(item)
                                item.clipsToBounds = true
                                item.cornerRadius = CGFloat(rounded)

                                self.scrollView.addSubview(item)
                                
                                  //  scrollView.addSubview(customViewDummy)
                                 i = i + 1

                            }
                            //StoreInfo
                            else if(dataDict["type"] as! String == "StoreInfo")
                            {
 
                                let dicts=dataDict.value(forKey: "sub_data") as! NSArray
                                for objss  in dicts
                                {
                                    let dataDicts = objss as! NSDictionary
                                     GlobalVariables.globalStoreImg =  dataDicts["url"] as! String
                                    GlobalVariables.globalStoreName =  dataDicts["title"] as! String
                                    GlobalVariables.globalStoreAddress =  dataDicts["description"] as! String
                                    GlobalVariables.globalTimes =  dataDicts["info"] as! String
                                    GlobalVariables.globalOprationHr =  dataDicts["Working_hours"] as! String
                                }
                                let item = storeInfo(frame:DynamicView1.frame)
                                DynamicView1.addSubview(item)
                                item.clipsToBounds = true
                                item.cornerRadius = CGFloat(rounded)
                                self.scrollView.addSubview(item)
                                
                                //  scrollView.addSubview(customViewDummy)
                            }
                            else if(dataDict["type"] as! String == "Billboard")
                            {
                                GlobalVariables.globalISScolling = dataDict.value(forKey: "auto_scroll") as! Bool
                                GlobalVariablesArr.globalBillboardArr = []
                                let dicts=dataDict.value(forKey: "sub_data") as! NSArray
                                for objss  in dicts
                                {
                                    let dataDicts = objss as! NSDictionary
                                    let url = URL(string:  dataDicts["url"] as! String)
                                    GlobalVariablesArr.globalBillboardArr.add(url!)
                                    
                                }
                                
                                // GlobalVariablesArr.globalBannerArr = self.imageNames
                                //    let bannerView = loadViewFromNib()
                                
                                //DynamicView1.addSubview(bannerView)
                                //      let customView: bannerView  = bannerView()
                                //    let customViewDummy: bannerView = Bundle.main.loadNibNamed("bannerView", owner: self, options: nil)![0] as! bannerView
                                let item = billboard(frame:DynamicView1.frame)
                                DynamicView1.addSubview(item)
                                item.clipsToBounds = true
                                item.cornerRadius = CGFloat(rounded)

                                self.scrollView.addSubview(item)
                                
                                //  scrollView.addSubview(customViewDummy)
                                i = i + 1
                                
                            }
                           else if(dataDict["type"] as! String == "recipe")
                            {
                               // print(objs)
                                GlobalVariablesArr.globalRecipeArr = []

                                let dicts=dataDict.value(forKey: "sub_data") as! NSArray
                                for objss  in dicts
                                {
                                    let dataDicts = objss as! NSDictionary
                                    let url = URL(string:  dataDicts["url"] as! String)
                                    GlobalVariablesArr.globalRecipeArr.add(url!)
                                    
                                }
                                
                                // GlobalVariablesArr.globalBannerArr = self.imageNames
                                //    let bannerView = loadViewFromNib()
                                
                                //DynamicView1.addSubview(bannerView)
                                //      let customView: bannerView  = bannerView()
                                //    let customViewDummy: bannerView = Bundle.main.loadNibNamed("bannerView", owner: self, options: nil)![0] as! bannerView
                                let item = recipeView(frame:DynamicView1.frame)
                                 DynamicView1.addSubview(item)
                                item.clipsToBounds = true

                                item.cornerRadius = CGFloat(rounded)

                                self.scrollView.addSubview(item)
                                
                                //  scrollView.addSubview(customViewDummy)
                                i = i + 1
                                
                            }
                           else if(dataDict["type"] as! String == "grid")
                            {
                                
                                GlobalVariables.globalString = dataDict.value(forKey: "title") as! String
                              // print(objs)
                                GlobalVariablesArr.globalProductArr = []
                                
                                let dicts=dataDict.value(forKey: "sub_data") as! NSArray
                                for objss  in dicts
                                {
                                     let dataDicts = objss as! NSDictionary
//                                    let url = URL(string:  dataDicts["url"] as! String)
                                    GlobalVariablesArr.globalProductArr.add(dataDicts)
                                    
                                }
                                
                                // GlobalVariablesArr.globalBannerArr = self.imageNames
                                //    let bannerView = loadViewFromNib()
                                
                                //DynamicView1.addSubview(bannerView)
                                //      let customView: bannerView  = bannerView()
                                //    let customViewDummy: bannerView = Bundle.main.loadNibNamed("bannerView", owner: self, options: nil)![0] as! bannerView
                             //   print(DynamicView1.frame)
                                DynamicView1.frame = CGRect(origin: CGPoint(x: 0,y :Int(yPos)), size: CGSize(width: CGFloat(self.view.frame.width) , height:  CGFloat(scaleHeight) ))
                                let item = poductGrid(frame: DynamicView1.frame)
                             //  self.scrollView.addSubview(item)
                                DynamicView1.addSubview(item)
                                item.clipsToBounds = true
                                item.cornerRadius = CGFloat(rounded)

                                self.scrollView.addSubview(item)
                                //  scrollView.addSubview(customViewDummy)
                                
                                 i = i + 1
                            }
                           else if(dataDict["type"] as! String == "video")
                            {
                             //   print(objs)
                                let dicts=dataDict.value(forKey: "sub_data") as! NSArray
                                for objss  in dicts
                                {
                                    let dataDicts = objss as! NSDictionary
                                    let url = URL(string:  dataDicts["url"] as! String)
                                    let myWebView:UIWebView = UIWebView(frame: DynamicView1.frame)
                                     print(DynamicView1.frame)
                                    myWebView.cornerRadius = 8

                                    print(myWebView.frame)
                                    
                                    let myURLRequest:URLRequest = URLRequest(url: url!)
                                    myWebView.loadRequest(myURLRequest)
                                    DynamicView1.addSubview(myWebView)
                                    self.scrollView.addSubview(myWebView)
                                    i = i + 1
                                 //   self.imageNames.add(url!)
                                    
                                    
                                }
                                
                            }
                            let DynamicView0 : UIView = UIView(frame:  CGRect(origin: CGPoint(x: 5,y :Int(yPos)), size: CGSize(width: CGFloat(self.view.frame.width - 10) , height:  10 )))
                            DynamicView0.backgroundColor = .clear
                            self.scrollView.addSubview(DynamicView0)
                        }
                        print(scrollView.frame.height)
                        print(scroll_height)
                        
                        self.scrollView.contentSize = CGSize(width: scrollView.frame.width, height: CGFloat(scroll_height+25))
                        print(scrollView.contentSize.height)
                        
                }
           
    }
    func getCurrentViewController() -> UIViewController? {
        
        if let rootController = UIApplication.shared.keyWindow?.rootViewController {
            var currentController: UIViewController! = rootController
            while( currentController.presentedViewController != nil ) {
                currentController = currentController.presentedViewController
            }
            return currentController
        }
        return nil
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
      //  scrollView.contentSize = CGSize(width: stackView.frame.width, height: stackView.frame.height)
    }
 

}
import UIKit
@IBDesignable
class DesignableView: UIView {
}

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}
