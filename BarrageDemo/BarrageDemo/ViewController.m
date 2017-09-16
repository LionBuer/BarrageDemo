//
//  ViewController.m
//  BarrageDemo
//
//  Created by Ding on 2017/9/16.
//  Copyright © 2017年 XU. All rights reserved.
//

#import "ViewController.h"
#import "BarrageManager.h"
@interface ViewController ()
@property (nonatomic, strong) BarrageManager *manager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _manager = [[BarrageManager alloc] initWithBarrageContentView:self.view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSLog(@"%s",__func__);
    
    [_manager sendBarrageWithCommentModel:[CommentModel commentModelWithComment:[NSString stringWithFormat:@"弹幕---%zd",arc4random() * 1000000]]];
}

@end
