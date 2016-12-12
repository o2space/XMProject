//
//  XMRefreshBase.swift
//  XMPullToRefreshDemo
//
//  Created by 梁亦明 on 15/10/3.
//  Copyright © 2015年 xiaoming. All rights reserved.
//

import UIKit
// 控件的方向
enum XMRefreashDirection {
    case XMRefreshDirectionHorizontal       // 水平
    case XMRefreshDirectionVertical         // 竖直
}
//控件的刷新状态
enum XMRefreshState {
    case  RefreshStateNormal                // 普通状态
    case  RefreshStatePulling               // 松开就可以进行刷新的状态
    case  RefreshStateRefreshing            // 正在刷新中的状态
    case  WillRefreshing
}

//控件的类型
enum XMRefreshViewType {
    case  RefreshViewTypeHeader             // 头部控件
    case  RefreshViewTypeFooter             // 尾部控件
}
class XMRefreshBase: UIView {
    
    // MARK: =========================定义属性=============================
    
    
    /// 刷新回调的Block
    typealias beginRefreshingBlock = () -> Void
    // 父控件
    var scrollView:UIScrollView!
    var scrollViewOriginalInset:UIEdgeInsets!
    
    // 箭头图片
    var arrowImage:UIImageView!
    // 文字描述
    var refreshText:UILabel!
    // 刷新后回调
    var beginRefreshingCallback:beginRefreshingBlock?
    
    // 交给子类去实现和调用
    var oldState:XMRefreshState?
    
    // 默认水平方向
    var viewDirection : XMRefreashDirection! = .XMRefreshDirectionHorizontal {
        willSet {
            self.viewDirection = newValue
        }
    }
    // 当状态改变时设置状态(State)就会调用这个方法
    var State : XMRefreshState = XMRefreshState.RefreshStateNormal {
        willSet {
            self.State = newValue
        }
        
        didSet {
            guard self.State != self.oldState else {
                return
            }
            switch self.State {
                // 普通状态时 隐藏那个菊花
                case .RefreshStateNormal:
                    self.arrowImage.stopAnimating();
                // 释放刷新状态
                case .RefreshStatePulling:
                    break;
                // 正在刷新状态 1隐藏箭头 2显示菊花 3回调
                case .RefreshStateRefreshing:
                    self.arrowImage.startAnimating()

                    if let _ = self.beginRefreshingCallback {
                        beginRefreshingCallback!()
                    }
                
            default :
                break;
            }
        }
    }
    
    // MARK: =========================定义方法===========================
    
    /**
    初始化控件
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        // 初始化箭头
        self.arrowImage = UIImageView(frame: CGRectMake(0, 0, 14, 14))
        self.arrowImage.autoresizingMask = [.FlexibleLeftMargin, .FlexibleRightMargin]
        self.arrowImage.image = UIImage(named: "refresh_1")
        self.arrowImage.tag = 500

        var imgArray : Array<UIImage> = Array()
        // 添加图片
        for i in 0..<8 {
            let image : UIImage = UIImage(named: "refresh_\(i+1)")!
            imgArray.append(image)
        }
        self.arrowImage.animationImages = imgArray
        self.arrowImage.animationDuration = 0.5
        self.arrowImage.animationRepeatCount = 999
        self.addSubview(arrowImage)
        
        // 文字信息
        self.refreshText=UILabel(frame: CGRectMake(0,0,0,0))
        self.refreshText.font=UIFont(name: "PingFangSC-Medium", size: 11.0)
        self.refreshText.textColor=UIColor(red: 113/255.0, green: 118/255.0, blue: 122/255.0, alpha: 1)
        self.refreshText.numberOfLines = 0
        
        
        self.addSubview(refreshText)
        
        if self.viewDirection == XMRefreashDirection.XMRefreshDirectionHorizontal {
            self.refreshText.text="松\n开\n发\n现\n更\n多\n内\n容"
            self.refreshText.textWHAlign(30, height: self.height, font: self.refreshText.font)
            if self.refreshText.height+14+20>self.height{
                self.refreshText.text=""
                self.refreshText.height=0
            }
            
            self.autoresizingMask = .FlexibleHeight
            
        } else {
            self.autoresizingMask = .FlexibleWidth
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 设置箭头和菊花居中
        if self.viewDirection == XMRefreashDirection.XMRefreshDirectionHorizontal {
            
            self.refreshText.center=CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2)
            if self.refreshText.height==0{
                self.arrowImage.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2)
            }else{
                self.arrowImage.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2 - self.refreshText.height / 2 - 16)
            }
            
            
        } else {
            self.arrowImage.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2)
            self.refreshText.center=CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2)
        }
    }
    
    //显示到屏幕上
    override func drawRect(rect: CGRect) {
        superview?.drawRect(rect);
        if self.State == XMRefreshState.WillRefreshing {
            self.State = XMRefreshState.RefreshStateRefreshing
        }
    }
    
    // MARK: ==============================让子类去重写=======================
    override func willMoveToSuperview(newSuperview: UIView!) {
        super.willMoveToSuperview(newSuperview)
        // 移走旧的父控件
        if (self.superview != nil) {
            self.superview?.removeObserver(self, forKeyPath: XMRefreshContentOffset as String, context: nil)
            
        }
        // 新的父控件 添加监听器
        if (newSuperview != nil) {
            newSuperview.addObserver(self, forKeyPath: XMRefreshContentOffset as String, options: NSKeyValueObservingOptions.New, context: nil)
            var rect:CGRect = self.frame
            // 设置宽度 位置
            if self.viewDirection == .XMRefreshDirectionHorizontal {
                rect.size.height = newSuperview.frame.size.height
                rect.origin.y = 0
                self.frame = frame;
            } else {
                rect.size.width = newSuperview.frame.size.width
                rect.origin.x = 0
                self.frame = frame;
            }
            
            //UIScrollView
            scrollView = newSuperview as! UIScrollView
            scrollViewOriginalInset = scrollView.contentInset;
        }
    }
    
    // 判断是否正在刷新
    func isRefreshing()->Bool{
        return XMRefreshState.RefreshStateRefreshing == self.State;
    }
    
    // 开始刷新
    func beginRefreshing(){
        // self.State = RefreshState.Refreshing;
        if (self.window != nil) {
            self.State = XMRefreshState.RefreshStateRefreshing;
        } else {
            //不能调用set方法
            State = XMRefreshState.WillRefreshing;
            super.setNeedsDisplay()
        }
    }
    
    //结束刷新
    func endRefreshing(){
        if self.State == .RefreshStateNormal {
            return
        }
        
        let delayInSeconds:Double = 0.3
        let popTime:dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds));
        
        dispatch_after(popTime, dispatch_get_main_queue(), {
            self.State = XMRefreshState.RefreshStateNormal;
        })
    }

}
