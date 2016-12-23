//
//  OneViewController.m
//  ToolClass
//
//  Created by lx on 16/12/22.
//  Copyright © 2016年 lx. All rights reserved.
//

#import "OneViewController.h"
#import "TwoViewController.h"
#import "UIImage+GIF.h"

@interface OneViewController ()

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.navigationController.navigationBarHidden = YES;
    self.navigationItem.title = @"首页";
    self.view.backgroundColor = [UIColor redColor];
    UIButton *pushBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    pushBtn.frame = CGRectMake(150, 200, 100, 100);
    [pushBtn addTarget:self action:@selector(pushBtn:) forControlEvents:UIControlEventTouchUpInside];
    [pushBtn setTitle:@"push第二张" forState:UIControlStateNormal];
    [pushBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [pushBtn setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:pushBtn];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(CGRectGetMinX(pushBtn.frame)- 25, CGRectGetMaxY(pushBtn.frame)+50, 150, 150);
    [self.view addSubview:imageView];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"gif"];
    
    NSData *imageData = [NSData dataWithContentsOfFile:path];
    
    imageView.image = [UIImage sd_animatedGIFWithData:imageData];
}



- (void)pushBtn:(id)sender{
    [self.navigationController pushViewController:[[TwoViewController alloc] init] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
