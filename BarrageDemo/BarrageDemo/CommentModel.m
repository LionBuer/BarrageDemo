//
//  CommentModel.m
//  BarrageDemo
//
//  Created by Ding on 2017/9/16.
//  Copyright © 2017年 XU. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel


+ (instancetype)commentModelWithComment:(NSString *)comment{
    return [[self alloc] initWithComment:comment];
}


- (instancetype)initWithComment:(NSString *)comment{
    self = [super init];
    if (self) {
        _comment = comment;
    }
    return self;
}


@end
