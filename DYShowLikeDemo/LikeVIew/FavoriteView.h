//
//  FavoriteView.m
//  DYShowLikeDemo
//
//  Created by stcn on 2021/9/1.
//  Copyright © 2021 LYW. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface FavoriteView : UIView

@property (nonatomic, strong) UIImageView      *favoriteBefore;
@property (nonatomic, strong) UIImageView      *favoriteAfter;

- (void)resetView;

@end
