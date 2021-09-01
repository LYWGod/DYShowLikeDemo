# DYShowLikeDemo
![likeDemo](https://user-images.githubusercontent.com/19968354/131624851-1a5ba0ea-70c3-4356-ade4-f19861894124.gif)


## 使用方法
![B06D9142F84D0EAA26857C28320D463F](https://user-images.githubusercontent.com/19968354/131625849-0c73d7e4-85b7-4e33-b094-a4e790fcc5ea.jpg)

### 第一种方案
- 1.将LikeView.h 和LikeView.m文件加入到项目里面

- 2.导入头文件#import "LikeView.h"

- 3.绘制UI的页面拥有一个属性：
@property (nonatomic, strong) LikeView            *likeView;

- 4.懒加载
- (LikeView *)likeView {
    if (!_likeView) {
        _likeView = [[LikeView alloc] init];
    }
    return _likeView;
}

- 5.将控件设置frame、并设置状态为NO，然后添加到父控件
self.likeView.frame = CGRectMake(100, 200, 50, 45);
[self.likeView setupLikeState:NO];
[self.view addSubview:self.likeView];

- 6.如果需要有点赞数量，那么就需要添加一个label在likeView下面记录数量即可

### 第二种方案
- 1.把FavoriteView.h 和 FavoriteView.m文件加入到项目里面

- 2.导入头文件#import "FavoriteView.h"

- 3.绘制UI的页面拥有一个属性：
@property (nonatomic, strong) FavoriteView     *favorite;

- 4.懒加载
- (FavoriteView *)favorite{
    if (!_favorite) {
        _favorite = [[FavoriteView alloc] init];
    }
    return _favorite;
}

- 5.将控件设置frame、然后添加到父控件
 self.favorite.frame = CGRectMake(100, 300, 50, 45);
 [self.view addSubview:self.favorite];

- 6.如果需要有点赞数量，那么就需要添加一个label在favorite下面记录数量即可
