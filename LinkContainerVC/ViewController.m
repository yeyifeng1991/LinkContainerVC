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
