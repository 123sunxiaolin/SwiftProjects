//
//  ViewController.swift
//  SwiftProject
//
//  Created by LTHJ on 2017/1/11.
//  Copyright © 2017年 LTHJ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var playBtn : UIButton = {
        var playBtn = UIButton.init(type: UIButtonType.custom)
        playBtn.setTitle("开始", for: UIControlState.normal)
        playBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        playBtn.setTitleColor(UIColor.blue, for: .normal)
        playBtn.backgroundColor = UIColor.red
        playBtn.addTarget(self, action: #selector(onClickPlayBtn(_:)), for: .touchUpInside)
        return playBtn
    }()
    lazy var pauseBtn:UIButton! = {
        var pauseBtn = UIButton.init(type: UIButtonType.custom)
        pauseBtn.setTitle("暂停", for: UIControlState.normal)
        pauseBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        pauseBtn.setTitleColor(UIColor.blue, for: .normal)
        pauseBtn.backgroundColor = UIColor.red
        pauseBtn.addTarget(self, action: #selector(onClickPauseBtn(_:)), for: .touchUpInside)
        return pauseBtn
    }()
    
    lazy var resetBtn:UIButton! = {
        var resetBtn = UIButton.init(type: UIButtonType.custom)
        resetBtn.setTitle("重置", for: UIControlState.normal)
        resetBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        resetBtn.setTitleColor(UIColor.blue, for: .normal)
        resetBtn.backgroundColor = UIColor.clear
        resetBtn.addTarget(self, action: #selector(onClickResetBtn(_:)), for: .touchUpInside)
        return resetBtn
    }()
    
    lazy var timeLabel:UILabel! = {
        var timeLabel = UILabel()
        timeLabel.font = UIFont.systemFont(ofSize: 20)
        timeLabel.textAlignment = NSTextAlignment.center
        timeLabel.backgroundColor = UIColor.clear
        timeLabel.textColor = UIColor.black
        timeLabel.text = "0"
        return timeLabel
    }()
    
    var counter = 0.0
    var timer = Timer()
    var isPlaying = false

    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "定时器"
        self.view.addSubview(self.timeLabel)
        self.timeLabel.snp.makeConstraints { (make)->Void in
            make.top.equalTo(self.view.snp.top).offset(20 + 44)
            make.centerX.equalTo(self.view.snp.centerX)
            make.size.equalTo(CGSize.init(width: self.view.frame.size.width - 20, height: 40))
        }
        
        self.view.addSubview(self.playBtn)
        self.playBtn.snp.makeConstraints { (make)->Void in
            make.left.equalTo(self.view).offset(10)
            make.bottom.equalTo(self.view.snp.bottom).offset(-100)
            make.size.equalTo(CGSize.init(width: 100, height: 100))
        }
        
        self.view.addSubview(self.pauseBtn)
        self.pauseBtn.snp.makeConstraints { (make)->Void in
            make.right.equalTo(self.view.snp.right).offset(-10)
            make.top.equalTo(self.playBtn)
            make.size.equalTo(CGSize.init(width: 100, height: 100))
        }
        
        self.view.addSubview(self.resetBtn)
        self.resetBtn.snp.makeConstraints { (make)->Void in
            make.top.equalTo(self.pauseBtn.snp.bottom).offset(10)
            make.centerX.equalTo(self.view.snp.centerX)
            make.size.equalTo(CGSize.init(width: 100, height: 100))
        }
        
        timeLabel.text = String(counter)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onClickPlayBtn(_ button:UIButton) {
        if isPlaying {
            return
        }
        
        playBtn.isEnabled = false
        pauseBtn.isEnabled = true
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        isPlaying = true
    }
    
    func onClickPauseBtn(_ button:UIButton) {
        playBtn.isEnabled = true
        pauseBtn.isEnabled = false
        timer.invalidate()
        isPlaying = false
    }
    
    func onClickResetBtn(_ button:UIButton) {
        timer.invalidate()
        counter = 0.0
        timeLabel.text = String(counter)
        isPlaying = false
        playBtn.isEnabled = true
        pauseBtn.isEnabled = true
    }
    
    func updateTimer()  {
        counter += 0.1
        timeLabel.text = String(format:"%.1f", counter)
    }

}

