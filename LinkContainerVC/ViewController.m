//
//  ViewController.m
//  LinkContainerVC
//
//  Created by YeYiFeng on 2018/3/21.
//  Copyright © 2018年 叶子. All rights reserved.
//

#import "ViewController.h"
#import "segmentView.h"
#import "Masonry.h"
#import "linkHeader.h"
#import "containerVC.h"
@interface ViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong) segmentView * segmentView;
@property(nonatomic,strong) UIScrollView * containerScrollView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"联系标题";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.segmentView];
    [self.view addSubview:self.containerScrollView];
    [self addChildVC];
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //只有这个方法中拿到了ctrlContanier的frame后才能去设置当前的控制器
    [self scrollViewDidEndScrollingAnimation:self.containerScrollView];//滚动完毕就会调用（如果不是人为拖拽scrollView导致滚动完毕，才会调用这个方法）
}
#pragma mark - 添加子视图
-(void)addChildVC{
    for (int i = 0; i<3; i++) {
        containerVC * vc = [[containerVC alloc]initWithChildView];
        [self addChildViewController:vc];
    }
  [self makeConstaints];
}
#pragma mark - 设置约束信息
-(void)makeConstaints
{
    [self.segmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(ZXLNavigationBarAdapterContentInsetTop);
        make.size.mas_equalTo(CGSizeMake(APPCONFIG_UI_SCREEN_FWIDTH, 40));
    }];
    [self.containerScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.segmentView.mas_bottom);
    }];
    self.containerScrollView.contentSize = CGSizeMake(3*APPCONFIG_UI_SCREEN_FWIDTH, 0);
}
#pragma mark - UIScrollViewDelegate 重要
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    CGFloat width = scrollView.frame.size.width;
    CGFloat height = scrollView.frame.size.height;
    CGFloat offsetX = scrollView.contentOffset.x;
    // 当前位置需要显示的控制器的索引
    NSInteger index = offsetX / width;
    //设置optionalNewsSegment滚动到控制器对应的位置
    [self.segmentView moveToCurrentSelectSegment:index];
    //容错处理
    if (index<0) return;
    // 取出需要显示的控制器
    containerVC *willShowVC = self.childViewControllers[index];
    // 如果当前位置已经显示过了，就直接返回
    if ([willShowVC isViewLoaded]) return;
    // 添加控制器的view到scrollView中;
    willShowVC.view.frame = CGRectMake(offsetX, 0, width, height);
    [scrollView addSubview:willShowVC.view];
}
#pragma mark - 滚动完毕就会调用（如果是人为拖拽scrollView导致滚动完毕，才会调用这个方法）
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}
-(segmentView *)segmentView
{
    if (!_segmentView) {
        _segmentView = [[segmentView alloc]initWithSegmentWithTitleArray:@[@"数组1",@"数组2",@"数组3"]];
//        __weak typeof (self) weakSelf = self;
        _segmentView.segmentButton = ^(NSInteger index) {
            
            NSLog(@"拿到点击索引 -   %ld",index);
            // 这里进行其他的操作
        };
    }
    return _segmentView;
}
- (UIScrollView *)containerScrollView
{
    if (!_containerScrollView) {
        _containerScrollView = [[UIScrollView alloc]init];
        _containerScrollView.scrollsToTop = NO;
        _containerScrollView.showsVerticalScrollIndicator = NO;
        _containerScrollView.showsHorizontalScrollIndicator = NO;
        _containerScrollView.pagingEnabled = YES;
        _containerScrollView.delegate = self;
    }
    return _containerScrollView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
