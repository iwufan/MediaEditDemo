//
//  KiImageClipperViewController.swift
//  KiClipperImageDemo
//
//  Created by mbApple on 2017/11/15.
//  Copyright © 2017年 panda誌. All rights reserved.
//

import UIKit
// iPhone X
let iphoneX = (UIScreen.main.bounds.size.width == 375.0 && UIScreen.main.bounds.size.height == 812.0 ? true : false) as Bool

typealias cancelClippedHandlerBlock = ()->Void
typealias successClippedHandlerBlock = (_ clippedImage:UIImage)->Void
class KiImageClipperViewController: UIViewController {
    //MARK Public
    public var cancelClippedHandler:cancelClippedHandlerBlock?
    public var successClippedHandler:successClippedHandlerBlock?
    public func setBaseImg(_ baseImg:UIImage,resultImgSize:CGSize,type:ClipperType) {
        clipperView = KiClipperView(frame: CGRect(x: 0, y: (iphoneX ? 88:64), width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - (iphoneX ? 88:64)))
        clipperView?.resultImgSize = resultImgSize
        clipperView?.baseImg = baseImg
        clipperView?.type = type
        self.view.addSubview(clipperView!)
        
        self.baseImg = baseImg
        self.type = type
    }

    //MARK Private
    private var clipperView:KiClipperView?
    private let TITLE_BAR_HEIGHT:Int = 44
    private var rightBtn:UIButton?
    private var leftBtn:UIButton?
    
    private var baseImg: UIImage!
    private var type: ClipperType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "选择图片"
        view.backgroundColor = .black
        
        self.hidesBottomBarWhenPushed = true
        if #available(iOS 11.0, *) {
        }else{
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        self.creatLeftBtnWithTitle(title: "取消")
        self.creaRightBtnWithTitle(title: "确认")
        // Do any additional setup after loading the view.
        
        addRatioButton()
    }
    
    @objc private func leftBtnTUI(btn: UIButton) {
        if cancelClippedHandler != nil {
            cancelClippedHandler!()
        }
    }
    
    @objc private func rightBtnTUI(btn: UIButton) {
        let clippedImg = self.clipperView?.clipImg()
        UIImageWriteToSavedPhotosAlbum(clippedImg!, nil, nil, nil)
        if successClippedHandler != nil {
            successClippedHandler!(UIImage())
        }
    }
    
    //MARK
    private func creatLeftBtnWithTitle(title:String) {
        if leftBtn == nil {
            leftBtn = UIButton(type: .custom)
            leftBtn?.frame = CGRect(x: 20, y: 20, width: TITLE_BAR_HEIGHT, height: TITLE_BAR_HEIGHT)
            leftBtn?.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            leftBtn?.contentHorizontalAlignment = .left
            leftBtn?.setTitle(title, for: .normal)
            leftBtn?.setTitleColor(UIColor.init(red: 0.118, green: 0.133, blue: 0.153, alpha: 1.0), for: .normal)
            leftBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            leftBtn?.addTarget(self, action: #selector(leftBtnTUI(btn:)), for: .touchUpInside)
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn!)
        }
    }
    
    private func creaRightBtnWithTitle(title:String) {
        if rightBtn == nil {
            rightBtn = UIButton(type: .custom)
            rightBtn?.setTitleColor(UIColor.init(red: 0.118, green: 0.133, blue: 0.153, alpha: 1.0), for: .normal)
            rightBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            rightBtn?.addTarget(self, action: #selector(rightBtnTUI(btn:)), for: .touchUpInside)
            rightBtn?.layer.cornerRadius = 8
        }
        rightBtn?.sizeToFit()
        rightBtn?.setTitle(title, for: .normal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn!)
    }
    
    private func addRatioButton() {
        let ratioButton = UISegmentedControl(items: ["1:1", "3:4"])
        ratioButton.selectedSegmentIndex = 0
        ratioButton.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        ratioButton.frame = CGRect(x: 260, y: 120, width: 80, height: 30)
        ratioButton.clipsToBounds = true
        ratioButton.addTarget(self, action: #selector(segmentDidChange(segment:)), for: .valueChanged)
        
        UIApplication.shared.keyWindow?.insertSubview(ratioButton, at: 1000)
        
    }

    @objc private func segmentDidChange(segment: UISegmentedControl) {
        print(segment.selectedSegmentIndex)
        
        clipperView?.removeFromSuperview()
        
        var cropSize = CGSize(width: 300, height: 300)
        if segment.selectedSegmentIndex == 1 {
            cropSize = CGSize(width: 300, height: 400)
        }
        
        setBaseImg(baseImg, resultImgSize: cropSize, type: type)
    }
}
