//
//  TwoViewController.m
//  ToolClass
//
//  Created by lx on 16/12/22.
//  Copyright © 2016年 lx. All rights reserved.
//

#import "TwoViewController.h"
#import "ThreeViewController.h"

@interface TwoViewController ()

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blueColor];
    self.navigationItem.title = @"第二页";
    UIButton *pushBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    pushBtn.frame = CGRectMake(150, 200, 100, 100);
    [pushBtn addTarget:self action:@selector(pushBtn:) forControlEvents:UIControlEventTouchUpInside];
    [pushBtn setTitle:@"push第三张" forState:UIControlStateNormal];
    [pushBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [pushBtn setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:pushBtn];
}


- (void)pushBtn:(id)sender{
    [self.navigationController pushViewController:[[ThreeViewController alloc] init] animated:YES];
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
