//
//  WebViewXib.m
//  +
//
//  Created by shensu on 17/3/28.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "WebViewXib.h"
#import "Masonry.h"
#import "DN-swift.h"
@implementation WebViewXib
-(instancetype)initWithFrame:(CGRect)frame
{  self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.goback = [UIButton buttonWithType:UIButtonTypeCustom];
        
        self.home = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.home setImage:[UIImage imageNamed:@"home"] forState:UIControlStateNormal];
        self.home.tag = 4;
        
        [self.home setTitle:@"首页" forState:UIControlStateNormal];
        [self.home addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
          [self.home setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.home.showsTouchWhenHighlighted = NO;
        [self addSubview:self.home];
      
        
        

        [self.goback setImage:[UIImage imageNamed:@"goback"] forState:UIControlStateNormal];

        self.goback.showsTouchWhenHighlighted = NO;
        self.goback.tag = 1;
         [self.goback setTitle:@"后退" forState:UIControlStateNormal];
          [self.goback setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.goback addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.goback];
          self.goback.imageEdgeInsets = UIEdgeInsetsMake(5,13,21,self.goback.titleLabel.bounds.size.width);
         self.goback.titleEdgeInsets = UIEdgeInsetsMake(71, -self.goback.titleLabel.bounds.size.width-50, 0, 0);
       
        
        self.goforward = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.goforward setImage:[UIImage imageNamed:@"go"] forState:UIControlStateNormal];
        self.goforward.showsTouchWhenHighlighted = NO;
         self.goforward.tag = 3;
        [self.goforward setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
         [self.goforward setTitle:@"前进" forState:UIControlStateNormal];
        [self.goforward addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.goforward];
        self.goforward.imageEdgeInsets = UIEdgeInsetsMake(5,13,21,self.goforward.titleLabel.bounds.size.width);
          self.goforward.titleEdgeInsets = UIEdgeInsetsMake(71, - self.goforward.titleLabel.bounds.size.width-50, 0, 0);
        
        self.goreloadData = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.goreloadData setImage:[UIImage imageNamed:@"upload"] forState:UIControlStateNormal];
         [self.goreloadData setTitle:@"刷新" forState:UIControlStateNormal];
        self.goreloadData.tag = 2;
        [self.goreloadData setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.goreloadData addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        self.goreloadData.showsTouchWhenHighlighted = NO;
        [self addSubview:self.goreloadData];
        self.goreloadData.imageEdgeInsets = UIEdgeInsetsMake(5,13,21,self.goreloadData.titleLabel.bounds.size.width);
         self.goreloadData.titleEdgeInsets = UIEdgeInsetsMake(71, -self.goreloadData.titleLabel.bounds.size.width-50, 0, 0);
      
        CGFloat sapce = (self.frame.size.width - 150)/8 ;

        [self.home mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(sapce);
            make.top.mas_equalTo(self);
            make.bottom.mas_equalTo(self);
            make.width.mas_equalTo(_goreloadData);
            make.right.mas_equalTo(self.goback.mas_left).offset(-sapce);
            
        }];
        
        [self.goback mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.home.mas_right).offset(sapce);
            make.top.mas_equalTo(self);
            make.bottom.mas_equalTo(self);
            make.width.mas_equalTo(_goreloadData);
            make.right.mas_equalTo(_goreloadData.mas_left).offset(-sapce);
        
        }];
        
        [_goreloadData mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_goback.mas_right).offset(sapce);
            make.top.mas_equalTo(self);
            make.bottom.mas_equalTo(self);
            make.width.mas_equalTo(_goforward);
            make.right.mas_equalTo(_goforward.mas_left).offset(-sapce);
            
        }];
        
        [self.goforward mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_goreloadData.mas_right).offset(sapce);
            make.top.mas_equalTo(self);
            make.width.mas_equalTo(_goback);
            make.bottom.mas_equalTo(self);
            make.right.mas_equalTo(self).offset(-sapce);
            
        }];
    
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
  [self setUIButtonFrame:self.goreloadData];
  [self setUIButtonFrame:self.goforward];
  [self setUIButtonFrame:self.goback];
  [self setUIButtonFrame:self.home];
}
-(void)setUIButtonFrame:(UIButton * )btn{
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn imageButtonInsetsTypeWithType:ImageButtonTypeImageButtonTop imagewithTitleSpace:2];
    
}
-(void)buttonClick:(UIButton *)btn {
    __weak __typeof (UIButton *) weak = btn;
    if (self.WebViewBlock != nil){
        self.WebViewBlock(weak.tag);
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
