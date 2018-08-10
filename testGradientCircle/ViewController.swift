//
//  ViewController.swift
//  testGradientCircle
//
//  Created by Mike on 2018/6/14.
//  Copyright © 2018年 Mike. All rights reserved.
//

import UIKit
import CoreGraphics

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        /*
        let sharpCicleLayer = CAShapeLayer();
        sharpCicleLayer.fillColor = nil
        sharpCicleLayer.strokeColor = UIColor.red.cgColor
        sharpCicleLayer.frame = CGRect.init(x: (UIScreen.main.bounds.size.width-100)/2.0, y: (UIScreen.main.bounds.size.height-100)/2.0, width: 100, height: 100)
        sharpCicleLayer.lineCap = kCALineCapRound
        sharpCicleLayer.lineWidth = 10.0
        
        let path = CGMutablePath.init()
        path.addArc(center: CGPoint.init(x: 50, y: 50), radius: 50, startAngle: .pi*135/180, endAngle: .pi * 1.5 + .pi*135/180, clockwise: false)
        sharpCicleLayer.path = path
        self.view.layer.addSublayer(sharpCicleLayer)*/
        
        //测试2
        let path = UIBezierPath.init(arcCenter: CGPoint.init(x: self.view.bounds.size.width/2.0, y: 110), radius: 100, startAngle: .pi*135/180, endAngle: .pi * 1.5 + .pi*135/180, clockwise: true)
        let shapeLayer = CAShapeLayer.init()
        shapeLayer.frame = CGRect.init(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height/2.0)
        shapeLayer.fillColor = nil
        shapeLayer.strokeColor = UIColor.ColorHex("#3023AE").cgColor
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.lineJoin = kCALineJoinRound
        shapeLayer.lineWidth = 12
        shapeLayer.path = path.cgPath
        self.view.layer.addSublayer(shapeLayer)
        
        //动画
        let pathAnimation = CABasicAnimation.init(keyPath: "strokeEnd")
        pathAnimation.duration = 1.5;
        pathAnimation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionLinear)
        pathAnimation.fromValue = 0.0
        pathAnimation.toValue = 1.0
        pathAnimation.autoreverses = false //动画结束之后不开始了
        pathAnimation.repeatCount = 1;
        pathAnimation.isRemovedOnCompletion = false
        pathAnimation.fillMode = kCAFillModeForwards
        
        shapeLayer.add(pathAnimation, forKey: "strokeEndAnimation")
        
        //两个渐变层拼接
        let layerG = CALayer.init()
        layerG.frame = self.view.bounds;
        let gradientLayer1 = CAGradientLayer.init()
        gradientLayer1.frame = CGRect.init(x: 0, y: 0, width: self.view.bounds.size.width/2.0, height: self.view.bounds.size.height/2.0)
        gradientLayer1.colors = [UIColor.ColorHex("#B4EC51").cgColor, UIColor.ColorHex("#53A0FD").cgColor]
        gradientLayer1.locations = [NSNumber.init(value: 0.5),NSNumber.init(value: 1)]
        gradientLayer1.startPoint = CGPoint.init(x: 0, y: 0)
        gradientLayer1.endPoint = CGPoint.init(x: 1, y: 0)
        layerG.addSublayer(gradientLayer1)
        
        let gradientLayer2 = CAGradientLayer.init()
        gradientLayer2.frame = CGRect.init(x: self.view.frame.size.width/2.0, y: 0, width: self.view.frame.size.width/2.0, height: self.view.bounds.size.height/2.0)
        gradientLayer2.colors = [UIColor.ColorHex("#53A0FD").cgColor, UIColor.ColorHex("#3023AE").cgColor]
        gradientLayer2.locations = [NSNumber.init(value: 0.3),NSNumber.init(value: 0.8)]
        gradientLayer2.startPoint = CGPoint.init(x: 0, y: 0)
        gradientLayer2.endPoint = CGPoint.init(x: 1, y: 0)
        layerG.addSublayer(gradientLayer2)
        self.view.layer.insertSublayer(layerG, at: 0)
        layerG.mask = shapeLayer
        
        
        //下半部分绘制 进度条
        
        let path2 = CGMutablePath()
        path2.move(to: CGPoint.init(x: 20, y: 100))
        path2.addLine(to: CGPoint.init(x: self.view.bounds.width-20, y: 100))
        
        let lineLayer = CAShapeLayer.init()
        lineLayer.frame = CGRect.init(x: 0, y: self.view.bounds.height/2.0, width: self.view.bounds.width, height: self.view.bounds.height/2.0)
        lineLayer.fillColor = nil
        lineLayer.strokeColor = UIColor.gray.cgColor
        lineLayer.lineJoin = kCALineJoinRound
        lineLayer.lineCap = kCALineCapRound
        lineLayer.lineWidth = 12.0
        lineLayer.path = path2
        self.view.layer.addSublayer(lineLayer)
        
        let litterLine = CAShapeLayer.init()
        litterLine.frame = CGRect.init(x: 20, y:94, width: self.view.bounds.width-40, height: 14.0)
        litterLine.fillColor = UIColor.yellow.cgColor
        litterLine.strokeColor = UIColor.red.cgColor
        litterLine.lineJoin = kCALineJoinRound
        litterLine.lineCap = kCALineCapButt
        litterLine.lineWidth = 2.0
        let path3 = CGMutablePath()
        path3.move(to: CGPoint.init(x:litterLine.frame.size.width/2.0 , y: 0))
        path3.addLine(to: CGPoint.init(x: litterLine.frame.size.width/2.0, y: 12.0))
        path3.move(to: CGPoint.init(x: litterLine.frame.size.width/2.0+80.0, y: 0))
        path3.addLine(to: CGPoint.init(x: litterLine.frame.size.width/2.0+80.0, y: 12.0))
        path3.move(to: CGPoint.init(x: litterLine.frame.size.width/2.0-120, y: 0))
        path3.addLine(to: CGPoint.init(x: litterLine.frame.size.width/2.0-120.0, y: 12.0))
        litterLine.path = path3
        lineLayer.addSublayer(litterLine)
        
        let lineLayer2 = CAShapeLayer.init()
        lineLayer2.frame = CGRect.init(x: 0, y: self.view.bounds.height/2.0, width: self.view.bounds.width, height: self.view.bounds.height/2.0)
        lineLayer2.fillColor = nil
        lineLayer2.strokeColor = UIColor.yellow.cgColor
        lineLayer2.lineJoin = kCALineJoinRound
        lineLayer2.lineCap = kCALineCapRound
        lineLayer2.lineWidth = 12.0
        
        let path4 = CGMutablePath()
        path4.move(to: CGPoint.init(x: 20, y: 100))
        path4.addLine(to: CGPoint.init(x: 100, y: 100))
        lineLayer2.path = path4
       self.view.layer .addSublayer(lineLayer2)
        
        let animationLine = CABasicAnimation.init(keyPath: "strokeEnd")
        animationLine.duration = 1.5
        animationLine.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionLinear)
        animationLine.fromValue = 0.0
        animationLine.toValue = 1.0
        animationLine.autoreverses = false
        animationLine.repeatCount = 1
        animationLine.isRemovedOnCompletion = false
        animationLine.fillMode = kCAFillModeForwards
        
        lineLayer2 .add(animationLine, forKey: "strokeEndAnimation")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}





















