//
//  YLMenuView.swift
//  YLNote
//
//  Created by tangh on 2021/1/22.
//  Copyright © 2021 tangh. All rights reserved.
//

import UIKit

class YLMenuView: UIView {
    
    
    var maxPopupHeight : CGFloat = 0{
        didSet{
            
            
            itemTableView.frame = CGRect(x: 0, y: self.bounds.height - maxPopupHeight, width: self.bounds.width, height: maxPopupHeight)
            let frame = CGRect(x: controlButtonPadding.x, y: self.bounds.height - maxPopupHeight - controlButtonPadding.y - buttonSize.height, width: 32, height: 32)
            
            controlButton.frame = frame//CGRect(x: 30, y: 100, width: 32, height: 32)
            //CGRect(x: controlButtonPadding.x, y: self.bounds.height - controlButtonPadding.y - buttonSize.height, width: buttonSize.width, height: buttonSize.height)
            
            if !itemTableView.transform.isIdentity{
                itemTableView.transform = CGAffineTransform(translationX: 0, y: maxPopupHeight)
            }
            
        }
    }
    
    let reuseId = "YLMenuView.cell.reuseid"
    
    
    var buttonSize = CGSize(width: 32, height: 32)
    let controlButtonPadding = CGPoint(x: 11, y: 11)
    
    var items = ["abc","def","hij","aaaa","bbbb", "dddd","????"]
    
    let singleDuration : TimeInterval = 0.5
    let durationBetween : TimeInterval = 0.08
    let tableUpDuration : TimeInterval = 0.46
    let tableDownDuration : TimeInterval = 0.8
    
    var animationTimer : Timer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        maxPopupHeight = 300
        initSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    func initSubviews(){
        itemTableView.contentInset = UIEdgeInsets(top: buttonSize.height / 2, left: 0, bottom: 0, right: 0)
        itemTableView.contentOffset = CGPoint(x:0,y:-(buttonSize.height / 2))
        self.controlButton.layer.addSublayer(arrowLayer)
    }
    
    
    func arrowPath() -> UIBezierPath{
        let arrowLen = buttonSize.width * 0.42
        let arrowHeight = buttonSize.height * 0.18
        
        let path = UIBezierPath()
        
        let start = CGPoint(x: (buttonSize.width - arrowLen)/2, y: buttonSize.height/2 + arrowHeight/3)
        
        path.move(to: start)
        path.addLine(to: CGPoint(x: start.x + arrowLen/2, y: start.y - arrowHeight))
        path.addLine(to: CGPoint(x: start.x + arrowLen, y: start.y))
        
        return path
        
    }
    
    
    //MARK: - Actions
    
    @objc func controlButtonTapped(){
        let goingToOpen = !self.itemTableView.transform.isIdentity
        if goingToOpen {
            animateTableShow()
        }else{
            animateTableClose()
        }
    }
    
    //MARK: - lazy
    lazy var itemTableView: UITableView = {
        let itemTableView = UITableView()
        
        itemTableView.dataSource = self
        itemTableView.delegate = self
        itemTableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseId)
        
        itemTableView.backgroundColor = UIColor.white.withAlphaComponent(0.85)
        itemTableView.separatorColor = UIColor.black.withAlphaComponent(0.22)
        itemTableView.frame = CGRect(x: 0, y: self.bounds.height - maxPopupHeight, width: self.bounds.width, height: maxPopupHeight)
        itemTableView.transform = CGAffineTransform(translationX: 0, y: maxPopupHeight)
        itemTableView.tableFooterView = UIView()
        self.addSubview(itemTableView)
        return itemTableView
    }()
    
    lazy var controlButton: UIButton = {
        let controlButton = UIButton()
        controlButton.addTarget(self, action: #selector(self.controlButtonTapped), for: .touchUpInside)
        let frame = CGRect(x: controlButtonPadding.x, y: self.bounds.height - maxPopupHeight - 200, width: 32, height: 32)
        controlButton.frame = frame
        controlButton.backgroundColor = UIColor.white
        controlButton.layer.cornerRadius = buttonSize.width / 2
        controlButton.layer.shadowColor = UIColor.black.cgColor
        controlButton.layer.shadowOpacity = 0.3
        controlButton.layer.shadowOffset = CGSize(width: 0, height: 1.5)
        controlButton.layer.shadowRadius = 1
        self.addSubview(controlButton)
        return controlButton
    }()
    
    lazy var arrowLayer: CAShapeLayer = {
        let arrowLayer = CAShapeLayer.cleanLayer()
        arrowLayer.frame = controlButton.layer.bounds
        arrowLayer.strokeColor = UIColor.darkGray.cgColor
        arrowLayer.lineWidth = 2
        arrowLayer.path = arrowPath().cgPath
        return arrowLayer
    }()
}


extension YLMenuView : UITableViewDataSource ,UITableViewDelegate{
    
    
    
    //MARK: - Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        NSLog("Select Table : \(indexPath.row) with content : \(items[indexPath.row])")
    }
    
    //MARK: - DataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: reuseId)
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: reuseId)
        }
        
        
        cell.backgroundColor = .clear
        
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.light)
        
        cell.textLabel?.text = items[indexPath.row]
        
        return cell
    }
    
    
}


//MARK : - Animation
extension YLMenuView {
    
    fileprivate func animateTableShow(){
        for cell in self.itemTableView.visibleCells{
            cell.alpha = 0
            cell.transform = CGAffineTransform(translationX: 0, y: self.itemTableView.bounds.height)
        }
        
        
        
        let buttonAnimDuration = self.tableUpDuration/1.05
        
        let buttonAnimator = UIViewPropertyAnimator(duration: buttonAnimDuration, controlPoint1: CGPoint(x:0.14,y:0.6), controlPoint2:  CGPoint(x:0.47,y:1.05), animations: {
            
            self.controlButton.transform = CGAffineTransform(translationX: 0, y: -(self.controlButton.frame.midY - (self.bounds.height - self.maxPopupHeight)) )
        })
        
        buttonAnimator.startAnimation()
        
        let arrowAnim = YLAnimationHelper.animation(keyPath: "transform.rotation", from: 0, to: CGFloat.pi, duration: buttonAnimDuration)
        
        self.arrowLayer.transform = CATransform3DMakeRotation(-CGFloat.pi, 0, 0, 1)
        
        self.arrowLayer.add(arrowAnim, forKey: nil)
        
        
        let tableAnimator = UIViewPropertyAnimator(duration: self.tableUpDuration, controlPoint1: CGPoint(x:0.14,y:0.6), controlPoint2:  CGPoint(x:0.47,y:1.05), animations: {
            
            self.itemTableView.transform = .identity
        })
        
        
        let cellAnimationDelay = tableUpDuration * 0.15
        
        tableAnimator.startAnimation(afterDelay: 0.15)
        
        
        for (idx ,cell) in self.itemTableView.visibleCells.enumerated(){
            
            let positionAnimator = UIViewPropertyAnimator(duration: self.singleDuration, controlPoint1: CGPoint(x:0.14,y:0.6), controlPoint2:  CGPoint(x:0.47,y:1.05), animations: {
                
                cell.transform = .identity
            })
            
            positionAnimator.startAnimation(afterDelay: cellAnimationDelay + Double(idx) * self.durationBetween)
            
            let alphaAnimator = UIViewPropertyAnimator(duration: self.singleDuration, controlPoint1: CGPoint(x:0.6,y:0.3), controlPoint2:  CGPoint(x:0.95,y:0.8), animations: {
                
                cell.alpha = 1
            })
            
            alphaAnimator.startAnimation(afterDelay: cellAnimationDelay +  Double(idx + 1) * self.durationBetween)
            
        }
        
    }
    
    
    fileprivate func animateTableClose(){
        let buttonAnimDuration = self.tableDownDuration / 1.3
        
        let buttonAnimator = UIViewPropertyAnimator(duration: buttonAnimDuration,  controlPoint1: CGPoint(x:0.1,y:0.7), controlPoint2:  CGPoint(x:0.22,y:1), animations: {
            
            self.controlButton.transform = .identity
        })
        
        buttonAnimator.startAnimation()
        
        let arrowAnim = YLAnimationHelper.animation(keyPath: "transform.rotation", from:  CGFloat.pi, to: 0, duration: buttonAnimDuration)
        
        self.arrowLayer.transform = CATransform3DIdentity
        
        self.arrowLayer.add(arrowAnim, forKey: nil)
        
        
        let tableAnimator = UIViewPropertyAnimator(duration: self.tableDownDuration, controlPoint1: CGPoint(x:0.1,y:0.7), controlPoint2:  CGPoint(x:0.22,y:1), animations: {
            
            
            self.itemTableView.transform = CGAffineTransform(translationX: 0, y:self.maxPopupHeight)
        })
        
        
        
        tableAnimator.startAnimation()
        
        
        for cell in self.itemTableView.visibleCells{
            
            
            let alphaAnimator = UIViewPropertyAnimator(duration: self.singleDuration, controlPoint1: CGPoint(x:0.6,y:0.3), controlPoint2:  CGPoint(x:0.95,y:0.8), animations: {
                
                cell.alpha = 0
            })
            
            alphaAnimator.startAnimation()
            
        }
        
    }
}



//MARK: - Hit Test
extension YLMenuView {
    func shouldReceiveGesture(touch:UITouch) -> Bool{
        let point = touch.location(in: self)
        
        if self.controlButton.frame.contains(point) {
            return false
        }
        if self.itemTableView.transform.isIdentity && self.itemTableView.frame.contains(point) {
            return false
        }
        
        return true
    }
}
