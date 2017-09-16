//
//  BarrageView.h
//  BarrageDemo
//
//  Created by Ding on 2017/9/16.
//  Copyright © 2017年 XU. All rights reserved.
//  用来展示的单条弹幕视图

#import <UIKit/UIKit.h>

@class CommentModel;
@class BarrageView;


@protocol BarrageViewDelegate <NSObject>

/**
 弹幕完全进入屏幕

 @param barrageView 弹幕
 */
- (void)barrageViewFullyIntoTheScreen:(BarrageView *)barrageView;


/**
 弹幕完全移动出屏幕

 @param barrageView 弹幕
 */
- (void)barrageViewFullyOutOffTheScreen:(BarrageView *)barrageView;

@end


@interface BarrageView : UIView

/** 弹幕轨道(弹道) */
@property (nonatomic, assign) NSInteger trajectory;

@property (nonatomic, weak) id<BarrageViewDelegate> delegate;


/**
 发送一条弹幕

 @param commentModel 弹幕内容模型
 */
- (void)sendBarrageWithCommentModel:(CommentModel *)commentModel;

@end
