//
//  ViewController.m
//  DYShowLikeDemo
//
//  Created by stcn on 2021/9/1.
//  Copyright © 2021 LYW. All rights reserved.
//

#import "ViewController.h"
#import "LikeView.h"
@interface ViewController ()

@property (nonatomic, strong) LikeView            *likeView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
    
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


@end
