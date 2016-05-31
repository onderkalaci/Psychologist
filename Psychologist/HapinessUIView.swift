//
//  HapinessUIView.swift
//  Happiness
//
//  Created by Onder Kalaci on 21/05/16.
//  Copyright © 2016 Onder Kalaci. All rights reserved.
//

import UIKit

protocol FaceViewDataSource: class
{
    func smilenessForFaceView(sender: HapinessUIView) -> Double?
}

@IBDesignable
class HapinessUIView: UIView
{
    
    @IBInspectable var lineWidth: CGFloat = 3 {didSet { setNeedsDisplay() } }
    @IBInspectable var colur: UIColor = UIColor.blueColor(){didSet{ setNeedsDisplay() } }
    @IBInspectable var scale: CGFloat = 0.90 {didSet { setNeedsDisplay() } }
    
    /* add comment */
    var faceCenter: CGPoint
    {
        get
        {
            let superViewCenter = center
            return convertPoint(superViewCenter, fromView: superview)
        }
    }
    
    /* add comment */
    var faceRadius: CGFloat
    {
        get
        {
            return (min(bounds.size.width, bounds.size.height) / 2) * scale
        }
    }
    
    private enum Eye {case Left, Right}
    
    
    private struct Scaling
    {
        static let FaceRadiusToEyeRadiusRatio: CGFloat = 10
        static let FaceRadiusToEyeOffsetRatio: CGFloat = 3
        static let FaceRadiusToEyeSeperationRatio: CGFloat = 2.5
        static let FaceRadiusToMouthWidthRatio: CGFloat = 1
        static let FaceRadiusToMouthHeightRatio: CGFloat = 3
        static let FaceRadiusToMouthOffsetRatio: CGFloat = 3
    }
    
    weak var dataSource: FaceViewDataSource?
    
    
    func scale(gestrue: UIPinchGestureRecognizer)
    {
        if gestrue.state == .Changed
        {
            scale *= gestrue.scale
            gestrue.scale = 1
        }
    }
    
    /* add comment */
    private func bezierPathForEye(whichEye: Eye) -> UIBezierPath
    {
        let eyeRadius = faceRadius / Scaling.FaceRadiusToEyeRadiusRatio
        let eyeVerticalOffset = faceRadius / Scaling.FaceRadiusToEyeOffsetRatio
        let eyeHorizontalSeperation = faceRadius / Scaling.FaceRadiusToEyeSeperationRatio
        
        var eyeCenter = faceCenter
        eyeCenter.y -= eyeVerticalOffset
        
        switch whichEye
        {
            case .Left:
                eyeCenter.x -= eyeHorizontalSeperation
            case .Right:
                eyeCenter.x += eyeHorizontalSeperation
        }
        
        let eyePath = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius,
                                   startAngle: 0, endAngle: CGFloat(2 * M_PI), clockwise: true)
    
        eyePath.lineWidth = lineWidth
        
        return eyePath
    }
    
    /* add comment */
    private func bezierPathForSmile (fractionOfMaxSmile: Double) -> UIBezierPath
    {
        let mouthWidth = faceRadius / Scaling.FaceRadiusToMouthWidthRatio
        let mouthHeight = faceRadius / Scaling.FaceRadiusToMouthHeightRatio
        let mouthVerticalOffset = faceRadius / Scaling.FaceRadiusToEyeOffsetRatio
        
        let smileHeight = CGFloat(max(min(fractionOfMaxSmile, 1) , -1)) * mouthHeight
        
        let startPoint = CGPoint(x: faceCenter.x - mouthWidth / 2, y: faceCenter.y + mouthVerticalOffset)
        let endPoint = CGPoint(x: startPoint.x + mouthWidth, y: startPoint.y)
        let controlPoint1 = CGPoint(x: startPoint.x + mouthWidth / 3, y: startPoint.y + smileHeight)
        let controlPoint2 = CGPoint(x: startPoint.x + 2 * mouthWidth / 3, y: controlPoint1.y)
        
        let mouthPath = UIBezierPath()
        mouthPath.moveToPoint(startPoint)
        mouthPath.addCurveToPoint(endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        mouthPath.lineWidth = lineWidth
        
        return mouthPath
    }
    
    
    override func drawRect(rect: CGRect) {
    
        let facePath = UIBezierPath(arcCenter: faceCenter, radius: faceRadius,
                                    startAngle: 0, endAngle: CGFloat(2 * M_PI), clockwise: true)
        
        facePath.lineWidth = lineWidth
        colur.set()
        facePath.stroke()
        
        bezierPathForEye(.Left).stroke()
        bezierPathForEye(.Right).stroke()
    
        let smileness = dataSource?.smilenessForFaceView(self) ?? 0.0
        bezierPathForSmile(smileness).stroke()
    }

}
