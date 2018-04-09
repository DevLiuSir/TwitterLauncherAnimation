//
//  AppDelegate.swift
//  TwitterLauncherAnimation
//
//  Created by Liu Chuan on 2017/2/20.
//  Copyright © 2017 LC. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        /// 根视图
        let view = window!.rootViewController!.view!
        
        /// Logo界面
        let logoLayer = CALayer()
        logoLayer.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        logoLayer.position = view.center
        logoLayer.contents = UIImage(named: "TwitterLogoWhite")?.cgImage
        view.layer.mask = logoLayer
        
        /* 由于开始这个logo并不是透明的,所以先在其上加一层白色的view,并改一下背景颜色吧. */
        /// 遮罩视图
        let shelterView = UIView(frame: view.frame)
        shelterView.backgroundColor = .white
        view.addSubview(shelterView)
        
        // 设置视图背景颜色
        window?.backgroundColor = UIColor(red: 29 / 255.0, green: 161 / 255.0, blue: 242 / 255.0, alpha: 1)
        
        /********************* 缩放动画 *********************/
        
        // 1.Logo的缩小\放大动画
        let logoAnimation = CAKeyframeAnimation(keyPath: "bounds")
       
        // 设置动画开始时间
        logoAnimation.beginTime = CACurrentMediaTime() + 1
        
        // 指定动画的基本持续时间（以秒为单位）。
        logoAnimation.duration = 1
        
        // 关键帧段的时间
        logoAnimation.keyTimes = [0, 0.4, 1]
        
        // 一组对象，用于指定要用于动画的关键帧值。
        logoAnimation.values = [NSValue(cgRect: CGRect(x: 0, y: 0, width: 100, height: 100)),
                                NSValue(cgRect: CGRect(x: 0, y: 0, width: 85, height: 85)),
                                NSValue(cgRect: CGRect(x: 0, y: 0, width: 4500, height: 4500))]
        
        // 设置定时功能
        logoAnimation.timingFunctions = [CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut), CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)]
        
        // 确定完成后是否从目标图层的动画中删除动画
        logoAnimation.isRemovedOnCompletion = false

        // 设置动画的填充模式: 当动画完成时,接收器在其最终状态下保持可见. (确定接收方的演示文稿在其活动持续时间完成后是冻结还是删除)
        logoAnimation.fillMode = .forwards
        
        // 添加指定的动画
        logoLayer.add(logoAnimation, forKey: "zoomAnimation")
        
        // 2.初始界面颠抖动画 (放大一点)
        let mainViewAnimation = CAKeyframeAnimation(keyPath: "transform")
        mainViewAnimation.beginTime = CACurrentMediaTime() + 1.1
        mainViewAnimation.duration = 0.6
        mainViewAnimation.keyTimes = [0, 0.5, 1]
        mainViewAnimation.values = [NSValue(caTransform3D: CATransform3DIdentity),
                                    NSValue(caTransform3D: CATransform3DScale(CATransform3DIdentity, 1.1, 1.1, 1)),
                                    NSValue(caTransform3D: CATransform3DIdentity)]
        view.layer.add(mainViewAnimation, forKey: "transformAnimation")
        view.layer.transform = CATransform3DIdentity
        // 渐变效果
        UIView.animate(withDuration: 0.3, delay: 1.4, options: .curveLinear, animations: {
            shelterView.alpha = 0
        }) { (complection) in
            shelterView.removeFromSuperview()
            view.layer.mask = nil
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

