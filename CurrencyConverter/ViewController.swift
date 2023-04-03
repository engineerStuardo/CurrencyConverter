//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Italo Stuardo on 3/4/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        activityIndicator.isHidden = true
    }


    @IBAction func getRates(_ sender: Any) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        let url = URL(string: "https://api.apilayer.com/fixer/latest?base=EUR&symbols=USD,CAD,CHF,GBP,JPY,TRY")
        let session = URLSession.shared
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("04xizw8n5xxQ73pHuqYwnR3t4DErtPz6", forHTTPHeaderField: "apiKey")


        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let okButton = UIAlertAction(title: "Ok", style: .default)
                alert.addAction(okButton)
                self.present(alert, animated: true)
            } else {
                if data != nil {
                    do{
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! Dictionary<String, Any>
                        DispatchQueue.main.async {
                            if let rates = jsonResponse["rates"] as? [String: Any] {
                                print(rates)
                                if let usd = rates["USD"] as? Double {
                                    self.usdLabel.text = "USD: \(String(usd))"
                                }

                                if let cad = rates["CAD"] as? Double {
                                    self.cadLabel.text = "CAD: \(String(cad))"
                                }

                                if let chf = rates["CHF"] as? Double {
                                    self.chfLabel.text = "CHF: \(String(chf))"
                                }

                                if let gbp = rates["GBP"] as? Double {
                                    self.gbpLabel.text = "GBP: \(String(gbp))"
                                }

                                if let jpy = rates["JPY"] as? Double {
                                    self.jpyLabel.text = "JPY: \(String(jpy))"
                                }

                                if let tryValue = rates["TRY"] as? Double {
                                    self.tryLabel.text = "TRY: \(String(tryValue))"
                                }

                                self.activityIndicator.stopAnimating()
                                self.activityIndicator.isHidden = true
                            }
                        }
                    } catch {
                        print("Error")
                    }
                }
            }
        }

        task.resume()
    }
}

