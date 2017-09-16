//
//  BarrageManager.h
//  BarrageDemo
//
//  Created by Ding on 2017/9/16.
//  Copyright © 2017年 XU. All rights reserved.
//  弹幕视图管理者

#import <UIKit/UIKit.h>
#import "CommentModel.h"


@interface BarrageManager : NSObject


/**
 初始化方法

 @param barrageContentView 弹幕视图的父视图
 @return BarrageManager
 */
- (instancetype)initWithBarrageContentView:(UIView *)barrageContentView;

/**
 发送一条弹幕
 
 @param commentModel 弹幕内容模型
 */
- (void)sendBarrageWithCommentModel:(CommentModel *)commentModel;
@end
