//
//  BarrageManager.m
//  BarrageDemo
//
//  Created by Ding on 2017/9/16.
//  Copyright © 2017年 XU. All rights reserved.
//

#import "BarrageManager.h"
#import "BarrageView.h"


@interface BarrageManager ()<BarrageViewDelegate>
/** 未使用的弹幕View */
@property (nonatomic, strong) NSMutableArray<BarrageView *> *unUsedBarrageViews;
/** 弹幕数据来源 */
@property (nonatomic, strong) NSMutableArray<CommentModel *> *dataSource;
/** 弹道数组 */
@property (nonatomic, strong) NSMutableArray<NSNumber *> *trajectorys;
/** 弹幕视图的父视图 */
@property (nonatomic, weak) UIView *barrageContentView;

@end


@implementation BarrageManager

#pragma mark - lifecycle
/**
 初始化方法
 
 @param barrageContentView 弹幕视图的父视图
 @return BarrageManager
 */
- (instancetype)initWithBarrageContentView:(UIView *)barrageContentView{
    self = [super init];
    if (self) {
        _barrageContentView = barrageContentView;
        
        [self startAnimation];
    }
    return self;
}

#pragma mark - 懒加载
- (NSMutableArray<BarrageView *> *)unUsedBarrageViews{
    if (!_unUsedBarrageViews) {
        _unUsedBarrageViews = [NSMutableArray array];
    }
    return _unUsedBarrageViews;
}

- (NSMutableArray<CommentModel *> *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSMutableArray<NSNumber *> *)trajectorys{
    if (!_trajectorys) {
        _trajectorys = [NSMutableArray arrayWithArray:@[@0, @1, @2, @3, @4]];
    }
    return _trajectorys;
}

#pragma mark - publicMethod
/**
 发送一条弹幕
 
 @param commentModel 弹幕内容模型
 */
- (void)sendBarrageWithCommentModel:(CommentModel *)commentModel{
    [self.dataSource insertObject:commentModel atIndex:0];
}

#pragma mark - privateMethod
- (void)startAnimation{
    
    if (self.dataSource.count) {
        
        NSInteger count = self.trajectorys.count;
        
        for (NSInteger i = 0; i < count; i ++) {
            
            if (!self.dataSource.count) {
                break;
            }
            
            // 通过随机数获取弹幕的轨道(弹道)
            // 随机数
            NSInteger index = arc4random() % count;
            // 弹道
            NSInteger trajectory = [[self.trajectorys objectAtIndex:index] integerValue];
            
            [self sendBarrageAtTrajectory:trajectory];
        }
        
    }
    
    [self performSelector:@selector(startAnimation) withObject:nil afterDelay:0.5f];
    
}


- (void)sendBarrageAtTrajectory:(NSInteger)trajectory{
    
    
    // 取弹幕
    CommentModel *comment = self.dataSource.lastObject;
    [self.dataSource removeLastObject];
    // 取弹幕展示视图
    if (self.unUsedBarrageViews.count) {
        
        BarrageView *barrageView = self.unUsedBarrageViews.lastObject;
        barrageView.frame = CGRectMake(0.f, 200.f + trajectory * 40.f, 0, 0);
        barrageView.trajectory = trajectory;
        [_barrageContentView addSubview:barrageView];
        
        [self.unUsedBarrageViews removeLastObject];
        [barrageView sendBarrageWithCommentModel:comment];
        
    } else {
        
        BarrageView *barrageView = [[BarrageView alloc] initWithFrame:CGRectMake(0.f, 200.f + trajectory * 40.f, 0, 0)];
        barrageView.trajectory = trajectory;
        barrageView.delegate = self;
        [_barrageContentView addSubview:barrageView];
        
        [barrageView sendBarrageWithCommentModel:comment];
    }
}



#pragma mark - BarrageViewDelegate
- (void)barrageViewFullyOutOffTheScreen:(BarrageView *)barrageView{
    [self.unUsedBarrageViews addObject:barrageView];
}


- (void)barrageViewFullyIntoTheScreen:(BarrageView *)barrageView{
    
    // 完全进入后自动追加弹幕(还是当前弹道)
    if (!self.dataSource.count) {
        return;
    }
    
    [self sendBarrageAtTrajectory:barrageView.trajectory];
    
}

@end
