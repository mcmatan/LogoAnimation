//
//  ViewController.m
//  LogoAnimation
//
//  Created by Matan Cohen on 11/11/15.
//  Copyright © 2015 Matan Cohen. All rights reserved.
//

#import "ViewController.h"
#import "LogoAnimView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void) viewDidAppear:(BOOL)animated {
    LogoAnimView *animView = [[LogoAnimView alloc] initWithFrame:CGRectMake(0, 0, 150, 100)];
    animView.center = CGPointMake([UIScreen mainScreen].bounds.size.width /2 , 300);
    [self.view addSubview:animView];
    [animView draw];
    [animView animateWithDuration:3];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
