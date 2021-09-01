//
//  LikeView.h
//  DYShowLikeDemo
//
//  Created by stcn on 2021/9/1.
//  Copyright © 2021 LYW. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LikeView : UIView

@property (nonatomic, assign) BOOL      isLike;

- (void)startAnimationWithIsLike:(BOOL)isLike;

- (void)setupLikeState:(BOOL)isLike;

- (void)setupLikeCount:(NSString *)count;

@end

NS_ASSUME_NONNULL_END
