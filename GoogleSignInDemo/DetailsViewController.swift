//
//  DetailsViewController.swift
//  GoogleSignInDemo
//
//  Created by Alan Luo on 11/8/19.
//  Copyright © 2019 iLtc. All rights reserved.
//

import UIKit
import GoogleSignIn

class DetailsViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let defaults = UserDefaults.standard
        
        nameLabel.text = defaults.string(forKey: "userName")
        emailLabel.text = defaults.string(forKey: "userEmail")
        imageView.downloaded(from: defaults.string(forKey: "userImageURL")!)
        
        imageView.layer.cornerRadius = 150
        imageView.clipsToBounds = true
    }
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
        
        let defaults = UserDefaults.standard
        
        defaults.removeObject(forKey: "userId")
        defaults.removeObject(forKey: "userName")
        defaults.removeObject(forKey: "userEmail")
        defaults.removeObject(forKey: "userImageURL")
        
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
