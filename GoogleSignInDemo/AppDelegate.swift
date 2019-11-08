//
//  AppDelegate.swift
//  GoogleSignInDemo
//
//  Created by Alan Luo on 11/6/19.
//  Copyright © 2019 iLtc. All rights reserved.
//

import UIKit
import GoogleSignIn

@UIApplicationMain

// Add GIDSignInDelegate
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
          if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
            print("The user has not signed in before or they have since signed out.")
          } else {
            print("\(error.localizedDescription)")
          }
          return
        }
        
        let defaults = UserDefaults.standard
        
        defaults.set(user.userID, forKey: "userId")
        defaults.set(user.profile.name, forKey: "userName")
        defaults.set(user.profile.email, forKey: "userEmail")
        defaults.set(user.profile.imageURL(withDimension: 320).absoluteString, forKey: "userImageURL")
        
        // Some other properties that you may need
        // let idToken = user.authentication.idToken
        // let givenName = user.profile.givenName
        // let familyName = user.profile.familyName
        
        print("Google Sign In Success!")
        
        if let vc = GIDSignIn.sharedInstance()?.presentingViewController {
            let signinVC = vc as! ViewController
            
            signinVC.performSegue(withIdentifier: "showDetails", sender: nil)
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Initialize Google Sign In
        GIDSignIn.sharedInstance().clientID = "619800289993-7ii7lvesbc1qt3g4113tbck55pol70te.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    // Response to URL Scheme
    // If you have multiple URL Schemes, i.e., multiple Sign In Schemes from different websites,
    // make sure you handle them properly here. Otherwise, URL Scheme for different providers may conflict with each other and crash your app.
    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
      return GIDSignIn.sharedInstance().handle(url)
    }


}

