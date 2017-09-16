//
//  CommentModel.h
//  BarrageDemo
//
//  Created by Ding on 2017/9/16.
//  Copyright © 2017年 XU. All rights reserved.
//  弹幕内容模型

#import <UIKit/UIKit.h>

@interface CommentModel : NSObject
/** 弹幕上的评论 */
@property (nonatomic, copy) NSString *comment;

+ (instancetype)commentModelWithComment:(NSString *)comment;
- (instancetype)initWithComment:(NSString *)comment;
@end
