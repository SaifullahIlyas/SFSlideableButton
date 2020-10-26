//
//  SF+SlideAbleButton.swift
//  TestStripe
//
//  Created by Saifullah on 25/10/2020.
//  Copyright © 2020 CodeRecipe. All rights reserved.
//

import UIKit

final class SFSlideableButton : UIButton {
    
    @IBInspectable  public var slideTitle : String = "Slide To Action"
    public var slideTitleColor : UIColor = .white
    public var slideImage : UIImage? = UIImage(named: "swipe", in: Bundle.init(for: SFSlideableButton
        .self), compatibleWith: nil)
    public var slideButtonFont : UIFont?
    public var roundCornerRadius : CGFloat = 5
    public weak var delegate : SFSlideableButtonDelegate?
    
    public var didButtonSlides :(()->Void)?
    //FILES Properties
   private var leftSlideAbleIconConstraint :NSLayoutConstraint?
    private lazy var slideAbleIcon : UIImageView = {
   let imageView = UIImageView()
        imageView.image = self.slideImage
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(slideIconAction(sender:))))
        //imageView.center = imageView.superview!.center
        return imageView
    }()
    
    private lazy var slideAbleTitleLable : UILabel = {
        let lable = UILabel()
        lable.text = self.slideTitle
        lable.textColor = self.slideTitleColor
        lable.adjustsFontSizeToFitWidth = true
        lable.font = self.slideButtonFont
        self.setTitle("", for: .normal)
        return lable
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
         setupSideable()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
      
    }
   
    override func layoutSubviews() {
        super.layoutSubviews()
         
    }
   private func setupSideable() {

    self.addSubview(slideAbleIcon)
    self.addSubview(slideAbleTitleLable)
    slideAbleIcon.translatesAutoresizingMaskIntoConstraints = false
    slideAbleTitleLable.translatesAutoresizingMaskIntoConstraints = false
    
    //slideAbleTitleLable.addConstraint(leftSlideAbleIconConstraint!)
  leftSlideAbleIconConstraint =  slideAbleIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
    leftSlideAbleIconConstraint?.isActive = true
    slideAbleIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
    slideAbleIcon.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier:  0.5).isActive = true
    slideAbleIcon.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier:  0.5).isActive = true
    slideAbleTitleLable.leadingAnchor.constraint(equalTo: slideAbleIcon.trailingAnchor, constant: 20).isActive = true
    slideAbleTitleLable.centerYAnchor.constraint(equalTo: slideAbleIcon.centerYAnchor, constant: 0).isActive = true
    slideAbleTitleLable.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
  layoutIfNeeded()
    self.layer.masksToBounds = false
    self.layer.cornerRadius = roundCornerRadius
    //slideAbleIcon.layer.masksToBounds = false
    //slideAbleIcon.layer.cornerRadius = slideAbleIcon.frame.width/2
    
    //MARK:- Riple distance
   /* let leftSlideAbleIconOffset = slideAbleIcon.frame.minX
    let topSlideAbleIconOffset = slideAbleIcon.frame.minY
    let ripple = (leftSlideAbleIconOffset + topSlideAbleIconOffset)/2*/
    slideAbleIcon.addRippleAnimation(color: .white, duration: 1.5, repeatCount:100000, rippleCount: 1, rippleDistance: slideAbleIcon.frame.minY)
    
    
    
    }
    
    @objc func slideIconAction(sender : UIPanGestureRecognizer) {
         

            //guard  sender.velocity(in: self).x < 500 else {return}
        

            switch sender.state {
                   case .began:
                    slideAbleIcon.removeRippleAnimation()
                break
                       //self.initialSlidePoint = senderView.center
                   case .ended:
                      // senderView.center.x = self.initialSlidePoint.x
                    self.leftSlideAbleIconConstraint?.constant = 20
                    UIView.animate(withDuration: 0.5, delay: 0,options:[.curveEaseIn] , animations: {
                        self.layoutIfNeeded()
                    }, completion: {_ in
                        self.slideAbleIcon.addRippleAnimation(color: .white, duration: 1.5, repeatCount:100000, rippleCount: 1, rippleDistance: self.slideAbleIcon.frame.minY)
                    })
                       
            case .changed:
                let translation = sender.translation(in: self)
                //ender.view?.center.x =  translation.x
            
                guard translation.x >= slideAbleIcon.bounds.width + 20 else {
                    return
                }
                guard translation.x <= self.bounds.maxX - slideAbleIcon.bounds.width - 20 else {
                    sender.state = .ended
                    self.didButtonSlides?()
                    delegate?.didButtonSlides(sender: self)
                    return}
               
                self.leftSlideAbleIconConstraint?.constant = translation.x + 20
               /* let rightHandCondition = (self.orderInfoBtn?.frame.minX ?? 0.0) + (self.orderInfoBtn?.frame.width ?? 0.0)
                
                if self.actionButtonTitle?.frame.minX ?? 0.0 < rightHandCondition {
                self.slideleftConstraint?.constant = translation.x < 20 ? 20 : translation.x
                }
                else {
                    self.changeOrderStatusThroughSocket()
                    sender.state = .ended
                    
                }*/
                
                   default:
                       break
                   }
            
            
    }
}

protocol SFSlideableButtonDelegate : class  {
    func didButtonSlides(sender:UIView)
}
extension UIView {
    open func addRippleAnimation(color: UIColor, rippleWidth: CGFloat = 2, duration: Double = 1.5, repeatCount: Int = 1, rippleCount: Int = 3, rippleDistance: CGFloat? = nil, expandMaxRatio ratio: CGFloat = 1, startReset: Bool = true, handler:((CAAnimation)->Void)? = nil) {
        if startReset {
            removeRippleAnimation()
        } else {
            if isRippleAnimating {
                return
            }
        }
        let rippleAnimationAvatarSize = self.frame.size
        let rippleAnimationLineWidth: CGFloat = rippleWidth
        let rippleAnimationDuration: Double = duration
        var rippleAnimationExpandSizeValue: CGFloat = 0
        
        if let distance = rippleDistance {
            rippleAnimationExpandSizeValue = distance
        } else {
            rippleAnimationExpandSizeValue = rippleAnimationAvatarSize.width / 3.0
        }
        
        let initPath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: rippleAnimationAvatarSize.width, height: rippleAnimationAvatarSize.height).insetBy(dx: rippleAnimationLineWidth, dy: rippleAnimationLineWidth))
        
        let finalPath = UIBezierPath(ovalIn: CGRect(x: -rippleAnimationExpandSizeValue * ratio, y: -rippleAnimationExpandSizeValue * ratio, width: rippleAnimationAvatarSize.width + rippleAnimationExpandSizeValue * 2 * ratio, height: rippleAnimationAvatarSize.height + rippleAnimationExpandSizeValue * 2 * ratio).insetBy(dx: rippleAnimationLineWidth, dy: rippleAnimationLineWidth))
        clipsToBounds = false
        
        
        
        let replicator = CAReplicatorLayer()
        replicator.instanceCount = rippleCount
        replicator.instanceDelay = rippleAnimationDuration / Double(rippleCount)
        replicator.backgroundColor = UIColor.clear.cgColor
        replicator.name = "ReplicatorForRipple"
        self.layer.addSublayer(replicator)

        let shape = animationLayer(path: initPath, color: color, lineWidth: rippleWidth)
        shape.name = "ShapeForRipple"
        shape.frame = CGRect(x: 0, y: 0, width: rippleAnimationAvatarSize.width, height: rippleAnimationAvatarSize.height)
        replicator.addSublayer(shape)

        let pathAnimation = CABasicAnimation(keyPath: "path")
        pathAnimation.isRemovedOnCompletion = true
        pathAnimation.fromValue = initPath.cgPath
        pathAnimation.toValue = finalPath.cgPath

        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = NSNumber(value: 1)
        opacityAnimation.toValue = NSNumber(value: 0)

        let groupAnimation = CAAnimationGroup()
        handler?(groupAnimation)
        groupAnimation.animations = [pathAnimation, opacityAnimation]
        groupAnimation.duration = rippleAnimationDuration
        groupAnimation.repeatCount = Float(repeatCount)
        groupAnimation.isRemovedOnCompletion = true
        groupAnimation.fillMode = .forwards
        shape.add(groupAnimation, forKey: "RippleGroupAnimation")
        
    }
    
    open func removeRippleAnimation() {
        var layers: [CALayer] = []
        layer.sublayers?.forEach({ (layer) in
            if let replicator = layer as? CAReplicatorLayer, replicator.name == "ReplicatorForRipple" {
                replicator.sublayers?.forEach({ (ly) in
                    if ly.name == "ShapeForRipple" {
                        ly.isHidden = true
                        layers.append(ly)
                    }
                })
                replicator.isHidden = true
                layers.append(replicator)
            }
        })
        
        for i in 0..<layers.count {
            layers[i].removeFromSuperlayer()
        }
        layers.removeAll()
    }

    private func animationLayer(path: UIBezierPath, color: UIColor, lineWidth: CGFloat) -> CAShapeLayer {
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.strokeColor = color.cgColor
        shape.fillColor = UIColor.clear.cgColor
        shape.lineWidth = lineWidth
        shape.strokeColor = color.cgColor
        shape.lineCap = .round
        return shape
    }
    
    open var isRippleAnimating: Bool {
        var animating = false
        layer.sublayers?.forEach({ (layer) in
            if let replicator = layer as? CAReplicatorLayer, replicator.name == "ReplicatorForRipple" {
                animating = true
            }
        })
        return animating
    }
}
