//
//  WebViewController.swift
//  RestTV
//
//  Created by Анастасия on 11.10.16.
//  Copyright © 2016 Anastasia. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    @IBOutlet var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let URL = NSURL(string: "https://ginza.ru/spb") {
            let request = NSURLRequest(url: URL as URL)
            webView.loadRequest(request as URLRequest)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
