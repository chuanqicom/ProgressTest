//
//  ViewController.m
//  test
//
//  Created by liang wang on 2017/7/8.
//  Copyright © 2017年 liang wang. All rights reserved.
//

#import "ViewController.h"
#import "ProgressView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    ProgressView *progress = [ProgressView progressViewForNib];
    progress.frame = CGRectMake(40, 100, 200, 200);
    [self.view addSubview:progress];
    // Dispose of any resources that can be recreated.
}


@end
