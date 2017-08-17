//
//  ViewController.m
//  AnimationLoading
//
//  Created by Harute on 2017/8/17.
//  Copyright © 2017年 Harute. All rights reserved.
//

#import "ViewController.h"
#import "LightningView.h"
#define Screen_Width  self.view.frame.size.width
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LightningView *LV = [[LightningView alloc]initWithFrame:CGRectMake(0, self.view.center.y, self.view.frame.size.width, self.view.frame.size.height/2)];
    
    [self.view addSubview:LV];
    
    
    //[self drowLine];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
