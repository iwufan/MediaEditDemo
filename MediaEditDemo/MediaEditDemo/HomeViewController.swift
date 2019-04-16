//
//  HomeViewController.swift
//  MediaEditDemo
//
//  Created by david on 2019/4/16.
//  Copyright © 2019 david. All rights reserved.
//

import UIKit
import DJExtension

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setDefaults()
        addViews()
    }
    
    private func setDefaults() {
        
        navigationItem.title = "音视频处理"
        view.backgroundColor = UIColor.white
    }
}

extension HomeViewController {
    
    private func addViews() {
        // 编辑图片
        let editImageButton = UIButton(title: "编辑图片", titleFont: dj_font(14), titleColor: djWhite, normalImage: dj_image("icon_edit"), titleOffset: UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0), imageOffset: UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 0), target: self, action: #selector(clickEditImageButton), superView: view) { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(view.snp.top).offset(300)
            make.width.equalTo(90)
            make.height.equalTo(30)
        }
        editImageButton.backgroundColor = dj_hexColor("999999")
        editImageButton.dj_setCornerRadius(radius: 4)
        // 裁剪视频
        let cutVideoButton = UIButton(title: "裁剪视频", titleFont: dj_font(14), titleColor: djWhite, normalImage: dj_image("icon_cut"), titleOffset: UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0), imageOffset: UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 0), target: self, action: #selector(clickCutVideoButton), superView: view) { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(editImageButton.snp.bottom).offset(40)
            make.width.equalTo(90)
            make.height.equalTo(30)
        }
        cutVideoButton.backgroundColor = dj_hexColor("999999")
        cutVideoButton.dj_setCornerRadius(radius: 4)
    }
}

extension HomeViewController {
    
    @objc private func clickEditImageButton() {
        KiClipperHelper.sharedInstance.nav = navigationController
        KiClipperHelper.sharedInstance.clipperType = .Move
        KiClipperHelper.sharedInstance.systemEditing = false
        KiClipperHelper.sharedInstance.isSystemType = false
        KiClipperHelper.sharedInstance.photoWithSourceType(type: .savedPhotosAlbum)
    }
    
    @objc private func clickCutVideoButton() {
        print("裁剪视频")
    }
}
