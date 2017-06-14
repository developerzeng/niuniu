//
//  LQKGeneralWebViewController.h
//  Basketball
//
//  Created by 牛胖胖 on 2017/3/14.
//  Copyright © 2017年 lanqiuke. All rights reserved.
//

#import "TOWebViewController.h"

@interface LQKGeneralWebViewController : TOWebViewController
//支持不熄屏
@property(nonatomic,assign)BOOL idleTimerDisabled;

/**
 *  H5的url
 */
@property (strong, nonatomic) NSURL *webUrl;

/**
 *  分享的URL
 */
@property (strong, nonatomic) NSString *webShareUrl;

/**
 *  标题
 */
@property (strong, nonatomic) NSString *webTittle;

/**
 *  分享内容
 */
@property (strong, nonatomic) NSString *webShareContext;

/**
 *  分享的默认图
 */
@property (strong, nonatomic) NSString *webShareImageURL;
@end
