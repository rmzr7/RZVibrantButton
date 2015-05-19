//
//  RZVibrantButton.swift
//  Holmusk
//
//  Created by Rameez Remsudeen  on 5/12/15.
//  Copyright (c) 2015 Holmusk. All rights reserved.
//

import UIKit

let kRZVibrantButtonDefaultAnimationDuration:CGFloat = 0.15
let kRZVibrantButtonDefaultAlpha:CGFloat = 1.0
let kRZVibrantButtonDefaultTranslucencyAlphaNormal:CGFloat = 1.0
let kRZVibrantButtonDefaultTranslucencyAlphaHighlighted:CGFloat = 0.5
let kRZVibrantButtonDefaultCornerRadius:CGFloat = 4.0
let kRZVibrantButtonDefaultRoundingCorners = UIRectCorner.AllCorners
let kRZVibrantButtonDefaultBorderWidth:CGFloat = 0.6
let kRZVibrantButtonDefaultFontSize:CGFloat = 14.0
let kRZVibrantButtonDefaultBackgroundColor = UIColor.whiteColor()
let kRZVibrantButtonDefaultStyle = RZVibrantButtonStyle.Invert



public enum RZVibrantButtonStyle {
    case Invert
    case Transclucent
    case Fill
}

public class RZVibrantButton:UIButton
{
    public var animated:Bool?
    public var animationDuration:CGFloat?
    public var translucencyAlphaNormal:CGFloat!
    public var translucencyAlphaHighlighted:CGFloat!
    public var cornerRadius:CGFloat{
        get{
            return self.cornerRadius
        }
        set{
            self.cornerRadius = newValue
            normalOverlay?.cornerRadius = newValue
            highlightedOverlay?.cornerRadius = newValue
        }
    }
    public var roundingCorners:UIRectCorner{
        get{
            return self.roundingCorners
        }
        set{
            self.roundingCorners = newValue
            normalOverlay?.roundingCorners = newValue
            highlightedOverlay?.roundingCorners = newValue
        }
    }
    public var borderWidth:CGFloat{
        get{
            return self.borderWidth
        }
        set{
            self.borderWidth = newValue
            normalOverlay?.borderWidth = newValue
            highlightedOverlay?.borderWidth = newValue
        }
        
    }
    public var text:String?
    public var style:RZVibrantButtonStyle{
        get{
            return self.style
        }
        set{
            if (self.style != newValue)
            {
                self.style = newValue
                createOverlays()
                
                //              set vibrancy effect here
                //                vibrancyEffect = newValue
                
                setNeedsDisplay()
            }
        }
    }
    
    // the vibrancy effect to be applied on the button
    public var vibrancyEffect:UIVibrancyEffect? {
        
        get{
            
            return self.vibrancyEffect
        }
        
        set{
            self.vibrancyEffect = newValue
            normalOverlay?.removeFromSuperview()
            highlightedOverlay?.removeFromSuperview()
            visualEffectView?.removeFromSuperview()
            
            if (visualEffectView != nil)
            {
                visualEffectView = UIVisualEffectView(effect: newValue!)
                visualEffectView?.userInteractionEnabled = false
                visualEffectView?.contentView.addSubview(normalOverlay!)
                visualEffectView?.contentView.addSubview(highlightedOverlay!)
                addSubview(visualEffectView!)
            }
            else{
                addSubview(normalOverlay!)
                addSubview(highlightedOverlay!)
            }
        }
    }
    
    public var icon:UIImage?{
        get{
            return self.icon
        }
        set{
            
            self.icon = newValue
            normalOverlay?.icon = newValue!
            highlightedOverlay?.icon = newValue!
        }
    }
    
    public var currentFont:UIFont?{
        get{
            return self.currentFont
        }
        set{
            
        }
    }
    
    
    // the background color when vibrancy effect is nil, or not supported.
    override public var backgroundColor:UIColor?{
        get{
            
            return self.backgroundColor == nil ?kRZVibrantButtonDefaultBackgroundColor : self.backgroundColor
        }
        
        set {
            self.backgroundColor = newValue
            normalOverlay?.backgroundColor = backgroundColor
            highlightedOverlay?.backgroundColor = backgroundColor
        }
    }
    
    override public var alpha:CGFloat {
        
        get{
            return self.alpha
        }
        
        set{
            self.alpha = newValue
            if ((self.activeTouch) != nil)
            {
                if (self.style == RZVibrantButtonStyle.Invert)
                {
                    self.normalOverlay?.alpha = 0.0
                    self.highlightedOverlay?.alpha = self.alpha
                }
                    
                else if (self.style == RZVibrantButtonStyle.Transclucent || self.style == RZVibrantButtonStyle.Fill)
                {
                    normalOverlay?.alpha = translucencyAlphaHighlighted * alpha
                }
            }
            else
            {
                if (self.style == RZVibrantButtonStyle.Invert)
                {
                    self.normalOverlay?.alpha = self.alpha
                    self.highlightedOverlay?.alpha = 0.0
                }
                    
                else if (self.style == RZVibrantButtonStyle.Transclucent || self.style == RZVibrantButtonStyle.Fill)
                {
                    normalOverlay?.alpha = translucencyAlphaNormal * alpha
                }
            }
        }
    }
    
    // Mark Private vars
    private var visualEffectView:UIVisualEffectView?
    
    
    private var normalOverlay:RZVibrantButtonOverlay?
    private var highlightedOverlay:RZVibrantButtonOverlay?
    private var activeTouch:Bool?
    private var hideRightBorder:Bool?{
        get{
            return self.hideRightBorder
        }
        set{
            
            self.hideRightBorder = newValue
            normalOverlay?.hideRightBorder = newValue!
            highlightedOverlay?.hideRightBorder = newValue!
        }
    }
    
    
    override convenience init(frame: CGRect)
    {
        self.init(frame:frame, style:kRZVibrantButtonDefaultStyle)
    }
    
    // this is the only method to initialize a vibrant button
    
    required public init(coder aDecoder:NSCoder)
    {
        super.init(coder:aDecoder)
        commonInit()
        self.currentFont = self.titleLabel!.font
        self.icon = self.imageForState(UIControlState.Normal)
        self.text = self.titleForState(UIControlState.Normal)
    }
    
    required public init(frame:CGRect, style:RZVibrantButtonStyle)
    {
        super.init(frame: frame)
        self.style = style
        commonInit()
    }
    
    private func commonInit(){
        opaque = false
        userInteractionEnabled = true
        
        // default vals
        animated = true
        animationDuration = kRZVibrantButtonDefaultAnimationDuration
        cornerRadius = kRZVibrantButtonDefaultCornerRadius
        roundingCorners = kRZVibrantButtonDefaultRoundingCorners
        borderWidth = kRZVibrantButtonDefaultBorderWidth
        translucencyAlphaNormal = kRZVibrantButtonDefaultTranslucencyAlphaNormal
        translucencyAlphaHighlighted = kRZVibrantButtonDefaultTranslucencyAlphaHighlighted
        alpha = kRZVibrantButtonDefaultAlpha
        activeTouch = false
        
        // create overlay views
        createOverlays()
        
        #if __IPHONE_8_0
            // add the default vibrancy effect
            vibrancyEffect = UIVibrancyEffect(forBlurEffect: UIBlurEffect(style: .Light))
            
        #endif
        
    }
    
    private func createOverlays()
    {
        normalOverlay?.removeFromSuperview()
        highlightedOverlay?.removeFromSuperview()
        normalOverlay = nil
        highlightedOverlay = nil
        
        if style == RZVibrantButtonStyle.Fill {
            normalOverlay = RZVibrantButtonOverlay(style:RZVibrantButtonOverlayStyle.Invert)
        } else{
            normalOverlay = RZVibrantButtonOverlay(style:RZVibrantButtonOverlayStyle.Normal)
        }
        
        if self.style == RZVibrantButtonStyle.Invert {
            highlightedOverlay = RZVibrantButtonOverlay(style:RZVibrantButtonOverlayStyle.Invert)
            highlightedOverlay?.alpha = 0.0
        } else{
            normalOverlay?.alpha = translucencyAlphaNormal * alpha
        }
        
        if normalOverlay != nil
        {
            addSubview(normalOverlay!)
            addSubview(highlightedOverlay!)
            
        }
        
        
    }
    
    //MARK:- Control Event Handlers
    
    func touchDown()
    {
        activeTouch = true
        
        var update:() -> () = { () -> () in
            
            if (self.style == RZVibrantButtonStyle.Invert)
            {
                self.normalOverlay?.alpha = 0.0
                self.highlightedOverlay?.alpha = self.alpha
            }
            else if (self.style == RZVibrantButtonStyle.Transclucent || self.style == RZVibrantButtonStyle.Fill)
            {
                self.normalOverlay?.alpha = self.translucencyAlphaHighlighted * self.alpha
            }
        }
        
        if ((animated) != nil)
        {
            UIView.animateWithDuration(NSTimeInterval(animationDuration!), animations: update)
        }
        else
        {
            update()
        }
        
        
    }
    
    func touchUp(){
        
        activeTouch = false
        
        var update:() -> () = { () -> () in
            
            if (self.style == RZVibrantButtonStyle.Invert)
            {
                self.normalOverlay?.alpha=self.alpha
                self.highlightedOverlay?.alpha = 0.0
            }
            else if(self.style == RZVibrantButtonStyle.Transclucent || self.style == RZVibrantButtonStyle.Fill)
            {
                self.normalOverlay?.alpha = self.translucencyAlphaNormal * self.alpha
            }
        }
        
        if ((animated) != nil)
        {
            UIView.animateWithDuration(NSTimeInterval(animationDuration!), animations: update)
        }
        else
        {
            update()
        }
    }
    
    //MARK: - Override Getters
    
    
    
}


/** RZVibrantButtonOverlRZ **/

enum RZVibrantButtonOverlayStyle {
    case Normal
    case Invert
}

class RZVibrantButtonOverlay:UIView
{
    // numeric configurations
    
    var cornerRadius:CGFloat{
        get{
            return self.cornerRadius
        }
        set{
            self.cornerRadius = newValue
            setNeedsDisplay()
        }
    }
    var roundingCorners:UIRectCorner{
        get{
            return self.roundingCorners
        }
        set{
            self.roundingCorners = newValue
            setNeedsDisplay()
        }
    }
    var borderWidth:CGFloat{
        get{
            return self.borderWidth
        }
        set{
            self.borderWidth = newValue
            setNeedsDisplay()
        }
    }
    
    
    // icon image
    var icon:UIImage?{
        get{
            return self.icon
        }
        set{
            self.icon = newValue
            text = nil
            setNeedsDisplay()
        }
    }
    
    // display text
    var text:String?{
        get{
            return self.text
        }
        set{
            self.text = newValue
            icon = nil
            setNeedsDisplay()
        }
    }
    
    var currentFont:UIFont? {
        get{
            
            var font = UIFont.systemFontOfSize(kRZVibrantButtonDefaultFontSize)
            return self.currentFont == nil ? font : self.currentFont
        }
        set{
            self.currentFont = newValue
            updateTextHeight()
            setNeedsDisplay()
        }
    }
    
    // background color
    override var backgroundColor:UIColor?
        {
        get{
            
            return self.backgroundColor == nil ? kRZVibrantButtonDefaultBackgroundColor : self.backgroundColor
        }
        set{
            self.backgroundColor = newValue
            setNeedsDisplay()
        }
    }
    
    
    // MARK: Private Vars
    
    private var style:RZVibrantButtonOverlayStyle?
    private var textHeight:CGFloat?
    private var hideRightBorder:Bool{
        get{
            return self.hideRightBorder
        }
        set{
            self.hideRightBorder = newValue
            setNeedsDisplay()
        }
    }
    
    init()
    {
        super.init(frame:CGRectZero)
        cornerRadius = kRZVibrantButtonDefaultCornerRadius
        roundingCorners = kRZVibrantButtonDefaultRoundingCorners;
        borderWidth = kRZVibrantButtonDefaultBorderWidth;
        opaque = false
        userInteractionEnabled = false
    }
    
    convenience init(style:RZVibrantButtonOverlayStyle)
    {
        self.init()
        self.style = style
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func drawRect(rect: CGRect) {
        
        super.drawRect(rect)
        
        var size:CGSize = bounds.size
        if (size.width == 0 || size.height == 0){
            return
        }
        
        var context = UIGraphicsGetCurrentContext()
        CGContextClearRect(context, bounds)
        backgroundColor?.setStroke()
        backgroundColor?.setFill()
        
        var boxRect = CGRectInset(bounds, borderWidth/2, borderWidth/2)
        
        if (hideRightBorder){
            boxRect.size.width += borderWidth * 2
        }
        
        // draw background and border
        var path = UIBezierPath(roundedRect: boxRect, byRoundingCorners: roundingCorners, cornerRadii: CGSizeMake(cornerRadius, cornerRadius))
        
        path.lineWidth = borderWidth
        path.stroke()
        
        if (style == RZVibrantButtonOverlayStyle.Invert)
        {
            path.fill()
        }
        
        CGContextClipToRect(context, boxRect)
        
        // draw icon
        
        if (icon != nil){
            let iconSize = icon?.size
            var iconRect = CGRectMake((size.width - iconSize!.width) / 2,
                (size.height - iconSize!.height) / 2,
                iconSize!.width,
                iconSize!.height)
            
            if (style == RZVibrantButtonOverlayStyle.Normal) {
                // ref: http://blog.alanyip.me/tint-transparent-images-on-ios/
                CGContextSetBlendMode(context, kCGBlendModeNormal);
                CGContextFillRect(context, iconRect);
                CGContextSetBlendMode(context, kCGBlendModeDestinationIn);
            } else if (style == RZVibrantButtonOverlayStyle.Invert) {
                // this will make the CGContextDrawImage below clear the image area
                CGContextSetBlendMode(context, kCGBlendModeDestinationOut);
            }
            
            CGContextTranslateCTM(context, 0, size.height);
            CGContextScaleCTM(context, 1.0, -1.0);
            
            // for some reason, drawInRect does not work here
            CGContextDrawImage(context, iconRect, self.icon?.CGImage);
            
        }
        
        if (self.text != nil) {
            
            let style:NSMutableParagraphStyle! = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
            style.lineBreakMode = NSLineBreakMode.ByTruncatingTail
            style.alignment = NSTextAlignment.Center
            
            if (self.style == RZVibrantButtonOverlayStyle.Invert) {
                // this will make the drawInRect below clear the text area
                CGContextSetBlendMode(context, kCGBlendModeClear);
            }
            //FIXME: might cause error
            
            let firstAttributes = [NSForegroundColorAttributeName: UIColor.blueColor(), NSBackgroundColorAttributeName: UIColor.yellowColor(), NSUnderlineStyleAttributeName: 1]
            
            let attrsx:[String:AnyObject] = [NSFontAttributeName: currentFont as! AnyObject, NSForegroundColorAttributeName: backgroundColor as! AnyObject, NSParagraphStyleAttributeName: style]
            
            text?.drawInRect(CGRectMake(0.0, (size.height - self.textHeight!) / 2, size.width, self.textHeight!), withAttributes:attrsx )
            
            
        }
    }
    
    private func updateTextHeight()
    {
        var bounds = (self.text! as String).boundingRectWithSize(CGSizeMake(CGFloat.max, CGFloat.max), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName:currentFont as! AnyObject], context: nil)
        textHeight = bounds.size.height
    }
}

class RZVibrantButtonGroup:UIView
{
    var animated:Bool{
        get{
            return self.animated
        }
        set{
            self.animated = newValue
            
            for button:RZVibrantButton in self.buttons as! Array<RZVibrantButton> {
                (button as RZVibrantButton).animated = newValue
            }
        }
    }
    var animationDuration:CGFloat{
        get{
            return self.animationDuration
        }
        set{
            self.animationDuration = newValue
            
            for button:RZVibrantButton in self.buttons as! Array<RZVibrantButton> {
                (button as RZVibrantButton).animationDuration = newValue
            }
        }
    }
    var translucencyAlphaNormal:CGFloat
        {
        get{
            return self.translucencyAlphaNormal
        }
        set{
            self.translucencyAlphaNormal = newValue
            
            for button:RZVibrantButton in self.buttons as! Array<RZVibrantButton> {
                (button as RZVibrantButton).translucencyAlphaNormal = newValue
            }
        }
    }
    
    var translucencyAlphaHighlighted:CGFloat
        {
        get{
            return self.translucencyAlphaHighlighted
        }
        set{
            self.translucencyAlphaHighlighted = newValue
            
            for button:RZVibrantButton in self.buttons as! Array<RZVibrantButton> {
                (button as RZVibrantButton).translucencyAlphaHighlighted = newValue
            }
        }
    }
    var cornerRadius:CGFloat
        {
        get{
            return self.cornerRadius
        }
        set{
            self.cornerRadius = newValue
            
            (buttons?.firstObject as! RZVibrantButton).cornerRadius = newValue
            (buttons?.lastObject as! RZVibrantButton).cornerRadius = newValue
        }
    }
    var borderWidth:CGFloat
        {
        get{
            return self.borderWidth
        }
        set{
            self.borderWidth = newValue
            
            for button:RZVibrantButton in self.buttons as! Array<RZVibrantButton> {
                (button as RZVibrantButton).borderWidth = newValue
            }
        }
    }
    var currentFont:UIFont
        {
        get{
            return self.currentFont
        }
        set{
            self.currentFont = newValue
            
            for button:RZVibrantButton in self.buttons as! Array<RZVibrantButton> {
                (button as RZVibrantButton).currentFont = newValue
            }
        }
    }
    
    
    var vibrancyEffect:UIVibrancyEffect?{
        get{
            return self.vibrancyEffect
        }
        set{
            self.vibrancyEffect = newValue
            
            for button:RZVibrantButton in self.buttons as! Array<RZVibrantButton> {
                (button as RZVibrantButton).vibrancyEffect = newValue
            }
        }
    }
    
    
    // the background color when vibrancy effect is nil, or not supported.
    override var backgroundColor:UIColor?{
        get{
            return self.backgroundColor
        }
        set{
            self.backgroundColor = newValue
            
            for button:RZVibrantButton in self.buttons as! Array<RZVibrantButton> {
                (button as RZVibrantButton).backgroundColor = newValue
            }
        }
    }
    
    // MARK: Private Vars
    
    private var buttons:NSArray?
    private var buttonCount:UInt!
    
    
    
    override init(frame: CGRect) {
        fatalError("RZVibrantButtonGroup must be initialized with initWithFrame:buttonTitles:style: or initWithFrame:buttonIcons:style:")
    }
    
    required init(frame:CGRect, buttonTitles:NSArray, style:RZVibrantButtonStyle)
    {
        super.init(frame:frame)
        initButtonGroup(buttonTitles, style: style, forText:true)
    }
    
    required init(frame:CGRect, buttonIcons:NSArray, style:RZVibrantButtonStyle)
    {
        super.init(frame:frame)
        initButtonGroup(buttonIcons, style: style, forText:false)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        if(buttonCount == 0){
            return
        }
        
        var size = self.bounds.size
        var buttonWidth:CGFloat = size.width / CGFloat(buttonCount)
        var buttonHeight:CGFloat = size.height
        
        buttons?.enumerateObjectsUsingBlock { (button, idx, stop) -> Void in
            
            var b:RZVibrantButton = button as! RZVibrantButton
            b.frame = CGRectMake(buttonWidth * CGFloat(idx), 0, buttonWidth, buttonHeight)
        }
        
        
    }
    
    func buttonAtIndex(index:UInt) -> RZVibrantButton!{
        return buttons?.objectAtIndex(Int(index)) as! RZVibrantButton
    }
    
    private func initButtonGroup(objects:NSArray, style:RZVibrantButtonStyle, forText:Bool){
        cornerRadius = kRZVibrantButtonDefaultCornerRadius
        borderWidth = kRZVibrantButtonDefaultBorderWidth
        
        opaque = false
        userInteractionEnabled = true
        
        var buttons = NSMutableArray()
        var count = UInt(objects.count)
        
        objects.enumerateObjectsUsingBlock { (obj, idx, stop) -> Void in
            
            var button = RZVibrantButton(frame: CGRectZero, style: style)
            
            //MARK: clang diagnostic push
            if (forText == true)
            {
                button.text = obj as? String
            }
            else
            {
                button.icon = obj as? UIImage
            }
            //MARK: clang diagnostic pop
            
            if (count == 1){
                button.roundingCorners = UIRectCorner.AllCorners
            } else if (idx == 0){
                button.roundingCorners = UIRectCorner.TopLeft | UIRectCorner.BottomLeft
            } else if (idx == Int(count) - 1){
                button.roundingCorners = UIRectCorner.TopRight | UIRectCorner.BottomRight
            } else{
                button.roundingCorners = UIRectCorner(0)
                button.cornerRadius = 0
                button.hideRightBorder = true
            }
            
            self.addSubview(button)
            buttons.addObject(button)
        }
        self.buttons = buttons
        self.buttonCount = count
    }
    
    
}