//
//  AppDelegate.swift
//  fir-mac
//
//  Created by isaced on 16/6/22.
//
//

import Cocoa

let UserDefaultsFIRAPITokenKey = "FIR_api_token"

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        if let cached = UserDefaults.standard.string(forKey: UserDefaultsFIRAPITokenKey) {
            HTTPManager.shared.APIToken = cached
        }else{
            alertForAPIToken()
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func alertForAPIToken() {
        let msg = NSAlert()
        msg.addButton(withTitle: "确定")  // 1st button
        msg.addButton(withTitle: "取消")  // 2nd button
        msg.messageText = "登陆"
        msg.informativeText = "请输入你的 fir 账号的 api_token"
        
        
        let txt = NSTextField(frame: NSRect(x: 0, y: 0, width: 200, height: 24))
        msg.accessoryView = txt
        
        let response: NSModalResponse = msg.runModal()
        
        if (response == NSAlertFirstButtonReturn) {
            let token = txt.stringValue
            
            guard token.characters.count > 0 else {
                let alert = NSAlert()
                alert.messageText = "错误"
                alert.informativeText = "api_token 不能为空！"
                alert.runModal()
                alertForAPIToken()
                return
            }
            
            UserDefaults.standard.set(token, forKey: UserDefaultsFIRAPITokenKey)
            HTTPManager.shared.APIToken = token
        } else {
            exit(0)
        }
    }
    
    @IBAction func loginMenuAction(_ sender: NSMenuItem) {
        alertForAPIToken()
    }
    
    @IBAction func logoutMenuAction(_ sender: NSMenuItem) {
        UserDefaults.standard.removeObject(forKey: UserDefaultsFIRAPITokenKey)
        HTTPManager.shared.APIToken = nil
        
        let alert = NSAlert()
        alert.informativeText = "退出登录成功！"
        alert.runModal()
        alertForAPIToken()
    }
    
    @IBAction func helpMenuAction(_ sender: NSMenuItem) {
        NSWorkspace.shared().open(URL(string: "https://github.com/isaced/fir-mac")!)
    }
    
}

