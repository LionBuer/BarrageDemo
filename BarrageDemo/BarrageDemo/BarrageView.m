//
//  BarrageView.m
//  BarrageDemo
//
//  Created by Ding on 2017/9/16.
//  Copyright © 2017年 XU. All rights reserved.
//

#import "BarrageView.h"
#import "CommentModel.h"

/** 弹幕的字号 */
static CGFloat const kCommentLabelFontSize = 14.f;
/** 弹幕的左右间距 */
static CGFloat const kCommentLabelPadding = 10.f;
/** 弹幕的高度 */
static CGFloat const kBarrageViewHeight = 30.f;
/** 弹幕动画时间,所有弹幕的动画时间是一样的,不一样的只是速度 */
static NSTimeInterval const kAnimationDuration = 5.f;


@interface BarrageView ()
/** 用来展示弹幕内容的文字 */
@property (nonatomic, strong) UILabel *commentLabel;
@end


@implementation BarrageView

#pragma mark - lifecycle
/** 初始化方法 */
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blueColor];
        
    }
    return self;
}


#pragma mark - 懒加载
- (UILabel *)commentLabel{
    if (!_commentLabel) {
        _commentLabel = [[UILabel alloc] init];
        _commentLabel.font = [UIFont systemFontOfSize:kCommentLabelFontSize];
        _commentLabel.textColor = [UIColor greenColor];
        _commentLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_commentLabel];
    }
    return _commentLabel;
}

#pragma mark - publicMethod
/**
 发送一条弹幕
 
 @param commentModel 弹幕内容模型
 */
- (void)sendBarrageWithCommentModel:(CommentModel *)commentModel{
    
    // 设置弹幕文字相关信息
    NSString *comment = commentModel.comment;
    CGFloat commentLabelW = [comment sizeWithAttributes:@{NSFontAttributeName: self.commentLabel.font}].width;
    self.commentLabel.frame = CGRectMake(kCommentLabelPadding, 0, commentLabelW, kBarrageViewHeight);
    self.commentLabel.text = comment;
    
    
    // 设置自身尺寸大小
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat yPos = self.frame.origin.y;
    self.frame = CGRectMake(screenW, yPos, commentLabelW + 2 * kCommentLabelPadding, kBarrageViewHeight);
    
    
    // 计算弹幕完全进入屏幕范围的时机,通知代理,自动追加新的弹幕
    CGFloat wholeW = screenW + CGRectGetWidth(self.bounds);
    CGFloat speed = wholeW / kAnimationDuration;
    // 这里用performSelector:withObject:afterDelay:这个延迟调用的方法而不用GCD的,是因为我们后面有可能要需要取消这个方法的调用
    [self performSelector:@selector(barrageViewFullyIntoTheScreen) withObject:nil afterDelay:(wholeW / speed)];
    
    
    // 开始动画
    [self startAnimation];
}

- (void)stopAnimation{
    [self.layer removeAllAnimations];
}


#pragma mark - privateMethod
- (void)barrageViewFullyIntoTheScreen{
    if ([self.delegate respondsToSelector:@selector(barrageViewFullyIntoTheScreen:)]) {
        [self.delegate barrageViewFullyIntoTheScreen:self];
    }
}

- (void)startAnimation{
    
    __block CGRect frame = self.frame;
    CGFloat width = CGRectGetWidth(frame);
    
        
    [UIView animateWithDuration:kAnimationDuration delay:0.f options:UIViewAnimationOptionCurveLinear animations:^{
        
        frame.origin.x = -width;
        self.frame = frame;
        
    } completion:^(BOOL finished) {
        
        if ([self.delegate respondsToSelector:@selector(barrageViewFullyOutOffTheScreen:)]) {
            [self.delegate barrageViewFullyOutOffTheScreen:self];
        }
        
    }];
    
}




@end
