//
//  ViewController.m
//  brightnessGradientDemo
//
//  Created by 张小兵 on 2018/3/3.
//  Copyright © 2018年 leon. All rights reserved.
//

#import "ViewController.h"
#import "QRCodeVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addBtn];
}

-(void)addBtn{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    btn.frame =CGRectMake(0, 0, 120, 40);
    btn.center = self.view.center;
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 20;
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"二维码" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)btnClick{
    QRCodeVC *vc = [[QRCodeVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
