//
//  LoadingSpinner.swift
//  airtickets
//
//  Created by Paulo Rodrigues on 29/12/17.
//  Copyright © 2017 MaxMilhas. All rights reserved.
//

import UIKit

public class LoadingSpinner: UIView {
    // MARK: - Singleton
    
    //
    // Access the singleton instance
    //
    public class var sharedInstance: LoadingSpinner {
        struct Singleton {
            static let instance = LoadingSpinner(frame: CGRect.zero)
        }
        return Singleton.instance
    }
    
    // MARK: - Init
    
    //
    // Custom init to build the spinner UI
    //
    
    public override init(frame: CGRect) {
        
        currentTitleFont = defaultTitleFont // By default we initialize to the same.
        
        super.init(frame: frame)
        
        blurEffect = UIBlurEffect(style: blurEffectStyle)
        blurView = UIVisualEffectView()
        addSubview(blurView)
        
        vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
        addSubview(vibrancyView)
        
        let titleScale: CGFloat = 0.85
        titleLabel.frame.size = CGSize(width: frameSize.width * titleScale, height: frameSize.height * titleScale)
        titleLabel.font = currentTitleFont
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.textColor = UIColor.darkGray
        
        
        blurView.contentView.addSubview(titleLabel)
        blurView.contentView.addSubview(vibrancyView)
        
        outerCircleView.frame.size = frameSize
        
        outerCircle.path = UIBezierPath(ovalIn: CGRect(x: 0.0, y: 0.0, width: frameSize.width, height: frameSize.height)).cgPath
        outerCircle.lineWidth = 8.0
        outerCircle.strokeStart = 0.0
        outerCircle.strokeEnd = 0.45
        outerCircle.lineCap = kCALineCapRound
        outerCircle.fillColor = UIColor.clear.cgColor
        outerCircle.strokeColor = outerCircleDefaultColor
        outerCircleView.layer.addSublayer(outerCircle)
        
        outerCircle.strokeStart = 0.0
        outerCircle.strokeEnd = 1.0
        
        blurView.contentView.addSubview(outerCircleView)
        
        innerCircleView.frame.size = frameSize
        
        let innerCirclePadding: CGFloat = 12
        innerCircle.path = UIBezierPath(ovalIn: CGRect(x: innerCirclePadding, y: innerCirclePadding, width: frameSize.width - 2*innerCirclePadding, height: frameSize.height - 2*innerCirclePadding)).cgPath
        innerCircle.lineWidth = 4.0
        innerCircle.strokeStart = 0.5
        innerCircle.strokeEnd = 0.9
        innerCircle.lineCap = kCALineCapRound
        innerCircle.fillColor = UIColor.clear.cgColor
        innerCircle.strokeColor = innerCircleDefaultColor
        innerCircleView.layer.addSublayer(innerCircle)
        
        innerCircle.strokeStart = 0.0
        innerCircle.strokeEnd = 1.0
        
        blurView.contentView.addSubview(innerCircleView)
        
        isUserInteractionEnabled = true
    }
    
    public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return self
    }
    
    // MARK: - Public interface
    
    public lazy var titleLabel = UILabel()
    public var subtitleLabel: UILabel?
    
    private let outerCircleDefaultColor = UIColor(red: 255/255.0, green: 95/255.0, blue: 17/255.0, alpha: 1.0).cgColor
    fileprivate var _outerColor: UIColor?
    public var outerColor: UIColor? {
        get { return _outerColor }
        set(newColor) {
            _outerColor = newColor
            outerCircle.strokeColor = newColor?.cgColor ?? outerCircleDefaultColor
        }
    }
    
    private let innerCircleDefaultColor = UIColor(red: 255/255.0, green: 95/255.0, blue: 17/255.0, alpha: 0.7).cgColor
    fileprivate var _innerColor: UIColor?
    public var innerColor: UIColor? {
        get { return _innerColor }
        set(newColor) {
            _innerColor = newColor
            innerCircle.strokeColor = newColor?.cgColor ?? innerCircleDefaultColor
        }
    }
    
    //
    // Custom superview for the spinner
    //
    private static weak var customSuperview: UIView? = nil
    private static func containerView() -> UIView? {
        return customSuperview ?? UIApplication.shared.keyWindow
    }
    public class func useContainerView(_ sv: UIView?) {
        customSuperview = sv
    }
    
    //
    // Show the spinner activity on screen, if visible only update the title
    //
    @discardableResult
    public class func show(_ title: String, animated: Bool = true) -> LoadingSpinner {
        
        let spinner = LoadingSpinner.sharedInstance
        
        spinner.clearTapHandler()
        
        spinner.updateFrame()
        
        if spinner.superview == nil {
            //show the spinner
            spinner.blurView.contentView.alpha = 0
            
            guard let containerView = containerView() else {
                fatalError("\n`UIApplication.keyWindow` is `nil`. If you're trying to show a spinner from your view controller's `viewDidLoad` method, do that from `viewWillAppear` instead. Alternatively use `useContainerView` to set a view where the spinner should show")
            }
            
            containerView.addSubview(spinner)
            
            UIView.animate(withDuration: 0.33, delay: 0.0, options: .curveEaseOut, animations: {
                
                spinner.blurView.contentView.alpha = 1
                spinner.blurView.effect = spinner.blurEffect
                
            }, completion: nil)
            
            #if os(iOS)
                // Orientation change observer
                NotificationCenter.default.addObserver(
                    spinner,
                    selector: #selector(LoadingSpinner.updateFrame),
                    name: NSNotification.Name.UIApplicationDidChangeStatusBarOrientation,
                    object: nil)
            #endif
        }
        
        spinner.title = title
        spinner.animating = animated
        
        return spinner
    }
    
    //
    // Show the spinner activity on screen with duration, if visible only update the title
    //
    @discardableResult
    public class func show(duration: Double, title: String, animated: Bool = true) -> LoadingSpinner {
        let spinner = LoadingSpinner.show(title, animated: animated)
        spinner.delay(duration) {
            LoadingSpinner.hide()
        }
        return spinner
    }
    
    private static var delayedTokens = [String]()
    //
    // Show the spinner activity on screen, after delay. If new call to show,
    // showWithDelay or hide is maked before execution this call is discarded
    //
    public class func show(delay: Double, title: String, animated: Bool = true) {
        let token = UUID().uuidString
        delayedTokens.append(token)
        LoadingSpinner.sharedInstance.delay(delay, completion: {
            if let index = delayedTokens.index(of: token) {
                delayedTokens.remove(at: index)
                _ = LoadingSpinner.show(title, animated: animated)
            }
        })
    }
    
    ///
    /// Show the spinner with the outer circle representing progress (0 to 1)
    ///
    @discardableResult
    public class func show(progress: Double, title: String) -> LoadingSpinner {
        let spinner = LoadingSpinner.show(title, animated: false)
        spinner.outerCircle.strokeEnd = CGFloat(progress)
        return spinner
    }
    
    //
    // Hide the spinner
    //
    public static var hideCancelsScheduledSpinners = true
    public class func hide(_ completion: (() -> Void)? = nil) {
        
        let spinner = LoadingSpinner.sharedInstance
        
        NotificationCenter.default.removeObserver(spinner)
        if hideCancelsScheduledSpinners {
            delayedTokens.removeAll()
        }
        
        DispatchQueue.main.async(execute: {
            spinner.clearTapHandler()
            
            if spinner.superview == nil {
                return
            }
            
            UIView.animate(withDuration: 0.33, delay: 0.0, options: .curveEaseOut, animations: {
                
                spinner.blurView.contentView.alpha = 0
                spinner.blurView.effect = nil
                
            }, completion: {_ in
                spinner.blurView.contentView.alpha = 1
                spinner.removeFromSuperview()
                spinner.titleLabel.text = nil
                
                completion?()
            })
            
            spinner.animating = false
        })
    }
    
    //
    // Set the default title font
    //
    public class func setTitleFont(_ font: UIFont?) {
        let spinner = LoadingSpinner.sharedInstance
        
        if let font = font {
            spinner.currentTitleFont = font
            spinner.titleLabel.font = font
        } else {
            spinner.currentTitleFont = spinner.defaultTitleFont
            spinner.titleLabel.font = spinner.defaultTitleFont
        }
    }
    
    //
    // The spinner title
    //
    public var title: String = "" {
        didSet {
            let spinner = LoadingSpinner.sharedInstance
            
            guard spinner.animating else {
                spinner.titleLabel.transform = CGAffineTransform.identity
                spinner.titleLabel.alpha = 1.0
                spinner.titleLabel.text = self.title
                return
            }
            
            UIView.animate(withDuration: 0.15, delay: 0.0, options: .curveEaseOut, animations: {
                spinner.titleLabel.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
                spinner.titleLabel.alpha = 0.2
            }, completion: {_ in
                spinner.titleLabel.text = self.title
                UIView.animate(withDuration: 0.35, delay: 0.0, usingSpringWithDamping: 0.35, initialSpringVelocity: 0.0, options: [], animations: {
                    spinner.titleLabel.transform = CGAffineTransform.identity
                    spinner.titleLabel.alpha = 1.0
                }, completion: nil)
            })
        }
    }
    
    //
    // observe the view frame and update the subviews layout
    //
    public override var frame: CGRect {
        didSet {
            if frame == CGRect.zero {
                return
            }
            blurView.frame = bounds
            vibrancyView.frame = blurView.bounds
            titleLabel.center = vibrancyView.center
            outerCircleView.center = vibrancyView.center
            innerCircleView.center = vibrancyView.center
            if let subtitle = subtitleLabel {
                subtitle.bounds.size = subtitle.sizeThatFits(bounds.insetBy(dx: 20.0, dy: 0.0).size)
                subtitle.center = CGPoint(x: bounds.midX, y: bounds.maxY - subtitle.bounds.midY - subtitle.font.pointSize)
            }
        }
    }
    
    //
    // Start the spinning animation
    //
    
    public var animating: Bool = false {
        
        willSet (shouldAnimate) {
            if shouldAnimate && !animating {
                spinInner()
                spinOuter()
            }
        }
        
        didSet {
            // update UI
            if animating {
                self.outerCircle.strokeStart = 0.0
                self.outerCircle.strokeEnd = 0.45
                self.innerCircle.strokeStart = 0.5
                self.innerCircle.strokeEnd = 0.9
            } else {
                self.outerCircle.strokeStart = 0.0
                self.outerCircle.strokeEnd = 1.0
                self.innerCircle.strokeStart = 0.0
                self.innerCircle.strokeEnd = 1.0
            }
        }
    }
    
    //
    // Tap handler
    //
    public func addTapHandler(_ tap: @escaping (()->()), subtitle subtitleText: String? = nil) {
        clearTapHandler()
        
        //vibrancyView.contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("didTapSpinner")))
        tapHandler = tap
        
        if subtitleText != nil {
            subtitleLabel = UILabel()
            if let subtitle = subtitleLabel {
                subtitle.text = subtitleText
                subtitle.font = UIFont(name: self.currentTitleFont.familyName, size: currentTitleFont.pointSize * 0.8)
                subtitle.textColor = UIColor.white
                subtitle.numberOfLines = 0
                subtitle.textAlignment = .center
                subtitle.lineBreakMode = .byWordWrapping
                subtitle.bounds.size = subtitle.sizeThatFits(bounds.insetBy(dx: 20.0, dy: 0.0).size)
                subtitle.center = CGPoint(x: bounds.midX, y: bounds.maxY - subtitle.bounds.midY - subtitle.font.pointSize)
                vibrancyView.contentView.addSubview(subtitle)
            }
        }
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        if tapHandler != nil {
            tapHandler?()
            tapHandler = nil
        }
    }
    
    public func clearTapHandler() {
        isUserInteractionEnabled = false
        subtitleLabel?.removeFromSuperview()
        tapHandler = nil
    }
    
    // MARK: - Private interface
    
    //
    // layout elements
    //
    
    private var blurEffectStyle: UIBlurEffectStyle = .light
    private var blurEffect: UIBlurEffect!
    private var blurView: UIVisualEffectView!
    private var vibrancyView: UIVisualEffectView!
    
    private let defaultTitleFont = UIFont(name: "TrebuchetMS", size: 22.0)!
    private var currentTitleFont : UIFont
    
    let frameSize = CGSize(width: 200.0, height: 200.0)
    
    private lazy var outerCircleView = UIView()
    private lazy var innerCircleView = UIView()
    
    private let outerCircle = CAShapeLayer()
    private let innerCircle = CAShapeLayer()
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("Not coder compliant")
    }
    
    private var currentOuterRotation: CGFloat = 0.0
    private var currentInnerRotation: CGFloat = 0.1
    
    private func spinOuter() {
        
        if superview == nil {
            return
        }
        
        let duration = Double(Float(arc4random()) /  Float(UInt32.max)) * 2.0 + 1.5
        let randomRotation = Double(Float(arc4random()) /  Float(UInt32.max)) * Double.pi + Double.pi
        
        //outer circle
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.0, options: [], animations: {
            self.currentOuterRotation -= CGFloat(randomRotation)
            self.outerCircleView.transform = CGAffineTransform(rotationAngle: self.currentOuterRotation)
        }, completion: {_ in
            let waitDuration = Double(Float(arc4random()) /  Float(UInt32.max)) * 1.0 + 1.0
            self.delay(waitDuration, completion: {
                if self.animating {
                    self.spinOuter()
                }
            })
        })
    }
    
    private func spinInner() {
        if superview == nil {
            return
        }
        
        //inner circle
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [], animations: {
            self.currentInnerRotation += CGFloat(Double.pi)
            self.innerCircleView.transform = CGAffineTransform(rotationAngle: self.currentInnerRotation)
        }, completion: {_ in
            self.delay(0.5, completion: {
                if self.animating {
                    self.spinInner()
                }
            })
        })
    }
    
    @objc public func updateFrame() {
        if let containerView = LoadingSpinner.containerView() {
            LoadingSpinner.sharedInstance.frame = containerView.bounds
        }
    }
    
    // MARK: - Util methods
    
    func delay(_ seconds: Double, completion:@escaping ()->()) {
        let popTime = DispatchTime.now() + Double(Int64( Double(NSEC_PER_SEC) * seconds )) / Double(NSEC_PER_SEC)
        
        DispatchQueue.main.asyncAfter(deadline: popTime) {
            completion()
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        updateFrame()
    }
    
    // MARK: - Tap handler
    private var tapHandler: (()->())?
    func didTapSpinner() {
        tapHandler?()
    }

}