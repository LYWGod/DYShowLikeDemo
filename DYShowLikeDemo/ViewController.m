//
//  ViewController.m
//  DYShowLikeDemo
//
//  Created by stcn on 2021/9/1.
//  Copyright © 2021 LYW. All rights reserved.
//

#import "ViewController.h"
#import "LikeView.h"
#import "FavoriteView.h"
@interface ViewController ()

@property (nonatomic, strong) LikeView            *likeView;

@property (nonatomic, strong) FavoriteView     *favorite;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
    
    //方案一
    [self testOne];
    
    //方案二
    [self textTwo];

}

//====================方案一====================
- (void)testOne{
    
    self.likeView.frame = CGRectMake(100, 200, 50, 45);
    [self.likeView setupLikeState:NO];
    [self.view addSubview:self.likeView];
}


- (LikeView *)likeView {
    if (!_likeView) {
        _likeView = [[LikeView alloc] init];
    }
    return _likeView;
}


//====================方案二====================
- (void)textTwo
{
    self.favorite.frame = CGRectMake(100, 300, 50, 45);
    [self.view addSubview:self.favorite];
}

- (FavoriteView *)favorite{
    if (!_favorite) {
        _favorite = [[FavoriteView alloc] init];
    }
    return _favorite;
}

@end
