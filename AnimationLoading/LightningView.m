//
//  LightningView.m
//  AnimationLoading
//
//  Created by Harute on 2017/8/17.
//  Copyright © 2017年 Harute. All rights reserved.
//

#import "LightningView.h"

@interface LightningView()

@property (nonatomic,strong) UILabel *LoadingLable;
//@property (nonatomic,strong)CAShapeLayer *CASlayer;
@end

@implementation LightningView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)drawRect:(CGRect)rect {
    
    _LoadingLable = [[UILabel alloc]initWithFrame:CGRectMake(20.0, -40.0, rect.size.width-40.0, 40)];
    [_LoadingLable setText:@"Loading..."];
    [_LoadingLable setTextColor:[UIColor colorWithRed:2.0/255.0 green:225.0/255.0 blue:214.0/255.0 alpha:1.0]];
    [self addSubview:_LoadingLable];
    //绘制路径
    _strokepath = [UIBezierPath bezierPath];
    [_strokepath moveToPoint:CGPointMake(0, 0)];
    
    //CAShapeLayer *layer2 = [CAShapeLayer layer];
    //layer2.frame = CGRectMake(20, 500,18*19, Screen_Width-20);
    NSInteger y1point = 0;
    NSInteger x1point =rect.size.width/5*2;
    
    NSInteger x2point =(rect.size.width/5)/4 + x1point;
    NSInteger x3point =(rect.size.width/5)/4*2 +x1point;
    NSInteger x4point =(rect.size.width/5)/4*3 +x1point;
    
    for (int i = 0; i < rect.size.width ; i ++) {
        
        if (i<=(rect.size.width/5*2)) {//第一条横线
            
            [_strokepath addLineToPoint:CGPointMake(i, 0)];
            
        }
        
        else if(i <(rect.size.width/5*3))//中间折线
        {
            if(i <x2point){
                [_strokepath addLineToPoint:CGPointMake(i, y1point-=6)];
            }
            else if(i <x3point){
                [_strokepath addLineToPoint:CGPointMake(i, y1point+=6)];
            }
            else if(i <x4point){
                [_strokepath addLineToPoint:CGPointMake(i, y1point+=6)];
            }
            else {
                [_strokepath addLineToPoint:CGPointMake(i, y1point-=6)];
            }
            
        }else{//最后横线
            [_strokepath addLineToPoint:CGPointMake(i, y1point)];
        }
        
    }
    [self CreateAnimation];
    
}

-(void)CreateAnimation{
    _CASlayer = [CAShapeLayer layer];
    // strokeStart
    CGFloat strokeStartFrom = -1.f;
    CGFloat strokeStartTo = 1.f;
    
    // strokeEnd
    CGFloat strokeEndFrom = 0.f;
    CGFloat strokeEndTo = 1.f;
    
    // end status
    _CASlayer.strokeStart = strokeStartTo;
    _CASlayer.strokeEnd = strokeEndTo;
    
    _CASlayer.path = _strokepath.CGPath;
    _CASlayer.strokeColor = [UIColor colorWithRed:2.0/255.0 green:225.0/255.0 blue:214.0/255.0 alpha:1.0].CGColor;
    _CASlayer.lineWidth = 3.0f;
    _CASlayer.fillColor = nil;
    _CASlayer.lineJoin = kCALineCapRound;
    
    _CASlayer.shadowOffset =  CGSizeMake(3, 3);
    _CASlayer.shadowOpacity = 0.8f;
    _CASlayer.shadowColor =  [UIColor colorWithRed:2.0/255.0 green:225.0/255.0 blue:214.0/255.0 alpha:1.0].CGColor;
    [self.layer addSublayer:_CASlayer];
    
    // animation
    CABasicAnimation *startAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    startAnimation.fromValue = @(strokeStartFrom);
    startAnimation.toValue = @(strokeStartTo);
    startAnimation.duration = 3.f;
    
    CABasicAnimation *endAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    endAnimation.fromValue = @(strokeEndFrom);
    endAnimation.toValue = @(strokeEndTo);
    endAnimation.duration = 2.f;
    
    CAAnimationGroup *anima = [CAAnimationGroup animation];
    anima.animations = @[startAnimation, endAnimation];
    anima.duration = 3.2f;
    anima.repeatCount = HUGE_VALF;
    [_CASlayer addAnimation:anima forKey:nil];
    
    _LoadingLable.layer.shadowColor =[UIColor colorWithRed:2.0/255.0 green:225.0/255.0 blue:214.0/255.0 alpha:1.0].CGColor;
    _LoadingLable.layer.shadowOpacity = 0.8f;
    
    [_LoadingLable.layer addAnimation:[self opacityForever_Animation: 3.2f] forKey:@"LableAnimation"];

    
}

-(CABasicAnimation *)opacityForever_Animation:(float)time
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];    animation.fromValue = [NSNumber numberWithFloat:1.0f];
    animation.toValue = [NSNumber numberWithFloat:0.0f];
    animation.autoreverses = YES;
    animation.duration = time;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];///没有的话是均匀的动画。
    return animation;
}



@end
