//
//  ViewController.swift
//  SatyaSecondLib
//
//  Created by Satya Prakash dash on 03/30/2016.
//  Copyright (c) 2016 Satya Prakash dash. All rights reserved.
//

import UIKit

class ViewController: UIViewController,FBSDKLoginButtonDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
        // var loginM:FBSDKLoginManager = FBSDKLoginManager()
        //  loginM.logOut()
        //FBSDKLoginManager().logOut()
        
        //        FBSDKAccessToken.setCurrentAccessToken(nil)
        
    }
    @IBAction  func loginFb(sender:AnyObject)
    {
        
        
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        var systemVersion = UIDevice.currentDevice().systemVersion;
        let Device = UIDevice.currentDevice()
        let iosVersion = NSString(string: Device.systemVersion).doubleValue
        let iOS9 = iosVersion >= 9
        
        if(iOS9)
        {
            
        }
        else{
        }
        
        var permissions = ["public_profile"]
        
        let deletepermission = FBSDKGraphRequest(graphPath: "me/permissions/", parameters: nil, HTTPMethod: "DELETE")
        deletepermission.startWithCompletionHandler({(connection,result,error)-> Void in
            
        })
        fbLoginManager .logInWithReadPermissions(["email"], handler: { (result, error) -> Void in
            if (error == nil){
                if (error == nil){
                    let fbloginresult : FBSDKLoginManagerLoginResult = result
                    if fbloginresult.grantedPermissions != nil { //Here we have to check that the set contains value or not
                        if(fbloginresult.grantedPermissions.contains("email"))
                        {
                            self.getFBUserData()
                            //fbLoginManager.logOut()
                        }
                        if(fbloginresult.isCancelled)
                        {
                            //JLToast.makeText("You have cancelled the login.").show()
                        }
                        
                    }
                    else
                    {
                       // JLToast.makeText("You have cancelled the login.").show()
                    }
                }
                else
                {
                   // JLToast.makeText("Facebook error happened. Please try again later.").show()
                    
                }
                
                
            }})
        
    }
    func getFBUserData(){
        NSLog("Called")
        if((FBSDKAccessToken.currentAccessToken()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).startWithCompletionHandler({ (connection, result, error) -> Void in
                if (error == nil){
                   // self.dict = result as! NSDictionary
                    //print(self.dict, terminator: "")
                    
                    print(FBSDKAccessToken.currentAccessToken().tokenString)
                    //NSLog(self.dict.objectForKey("picture")?.objectForKey("data")?.objectForKey("url") as! String)
                }
            })
        }
        else
        {
            //JLToast.makeText("Current Access Token is Nil").show()
        }
    }
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        NSLog("didCompleteWithResult")
        if error != nil
        {
            //JLToast.makeText("Error").show()
            
        }
        if let b = result
        {
            if ((error) != nil)
            {
                FBSDKLoginManager().logOut()
                //JLToast.makeText("Facebook login error").show()
            }
            else if result.isCancelled {
                
               // self.fbloginButton.enabled = false
                FBSDKLoginManager().logOut()
                FBSDKAccessToken.setCurrentAccessToken(nil)
               /// JLToast.makeText("You have cancelled facebook login").show()
                self.dismissViewControllerAnimated(true, completion: nil)
            }
            else {
                // If you ask for multiple permissions at once, you
                // should check if specific permissions missing
                if(result != nil)
                {
                    if result.grantedPermissions.contains("email")
                    {
                       // self.fbloginButton.enabled = false
                        self.getFBUserData()
                        //self.getFBUserDataWithoutEmail()
                    }
                    else
                    {
                        //self.fbloginButton.enabled = false
                       // JLToast.makeText("Your email address has not been recovered from facebook account. Please provide it.")
                        //self.getFBUserDataWithoutEmail()
                    }
                }
                else
                {
                    //JLToast.makeText("No Data.")
                }
            }
        }
        else
        {
           // self.facebookFirstName = ""
            //self.facebookUserid = ""
           // self.facebookName = ""
          
        }
        //JLToast.makeText("Returned.").show()
    }
}

