//
//  WebViewXib.h
//  +
//
//  Created by shensu on 17/3/28.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ WebViewXibBlock)(NSInteger tag);
@interface WebViewXib : UIView
@property(strong,nonatomic) UIButton * goback;
@property(strong,nonatomic) UIButton * goforward;
@property(strong,nonatomic) UIButton * goreloadData;
@property(strong,nonatomic) UIButton * home;

@property(copy,nonatomic)   WebViewXibBlock WebViewBlock;
@end
