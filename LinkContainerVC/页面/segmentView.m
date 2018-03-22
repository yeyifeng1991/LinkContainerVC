//
//  segmentView.m
//  LinkContainerVC
//
//  Created by YeYiFeng on 2018/3/21.
//  Copyright © 2018年 叶子. All rights reserved.
//

#import "segmentView.h"
#import "UIView+frame.h"
#import "Masonry.h"
#import "linkHeader.h"
#define kCanSliderLineWidth  (APPCONFIG_UI_SCREEN_FWIDTH - 15 *2)/self.segementTitleArray.count

@interface segmentView()
@property (nonatomic, strong)NSArray *segementTitleArray;/**<按钮标题数组*/
@property (nonatomic, strong)NSMutableArray *segementButtonArray;/**<按钮数组 */
@property (nonatomic, strong)UIView *segementContainer;/**<按钮容器*/
@property (nonatomic, strong)UIView *canSliderLine; /**<底部可滑动的线*/
@property (nonatomic, strong)UIView *bottomLine; /**<底部分割线*/
@end

@implementation segmentView


-(instancetype)initWithSegmentWithTitleArray:(NSArray*)segTitleArray;
{
    self = [super init];
    if (self) {
        self.segementTitleArray = segTitleArray;
        self.backgroundColor = [UIColor whiteColor];
        [self setSegmentView]; //创建循环按钮
        [self setMainViews]; // 创建顶部视图
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    //1. 设置视图容器的frame
    self.segementContainer.top = 0;
    self.segementContainer.left = 15;
    self.segementContainer.width = self.width - 15*2;
    self.segementContainer.height = self.height;
    //2. 设置bottomLine的frame
    self.bottomLine.frame = CGRectMake(0, self.height-APPCONFIG_UNIT_LINE_WIDTH, self.width, APPCONFIG_UNIT_LINE_WIDTH);
    //3. 每个子segment的宽度
    CGFloat segmentWith = (self.width-15*2) / self.segementTitleArray.count;
    for (int i=0; i<self.segementButtonArray.count; i++) {
        UIButton *button = (UIButton *)self.segementButtonArray[i];
        button.top = 0;
        button.left = i * segmentWith;
        button.width = segmentWith;
        button.height = 40;
    }
    //4. 设置canSliderLine底部红色滑动线条的位置
    self.canSliderLine.bottom = self.bottomLine.top;
    self.canSliderLine.left = self.segementContainer.left;
    self.canSliderLine.width = segmentWith;
    self.canSliderLine.height = 2.0f;
    
}
#pragma mark - 创建顶部的视图
-(void)setMainViews
{
    [self addSubview:self.segementContainer]; // 创建顶部视图容器
    for (UIButton * button in self.segementButtonArray) {
        [self.segementContainer addSubview:button];
    }
    [self addSubview:self.bottomLine];
    [self addSubview:self.canSliderLine];
}
#pragma mark - 循环创建btn按钮
-(void)setSegmentView
{
    self.segementButtonArray = [NSMutableArray array];
    for (int i = 0; i<self.segementTitleArray.count; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [btn setTitle:self.segementTitleArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        btn.titleLabel.adjustsFontSizeToFitWidth = YES;
        if (i ==0) {
            btn.selected = YES;
        }
        else
        {
            btn.selected = NO;
        }
        btn.tag = i;
        [self.segementButtonArray addObject:btn];
    }
    
}
#pragma mark - 按钮的点击事件
-(void)clickBtn:(UIButton*)button
{
    UIButton * selectBtn = button;
    //1. 回调给控制器
    if (self.segmentButton) {
        self.segmentButton(selectBtn.tag);
    }
    // 2.按钮设置为点击状态
    selectBtn.selected = YES;
    // 3.其他按钮取消选择属性
    for (UIButton * button in self.segementButtonArray) {
        if (![button isEqual:selectBtn]) {
            button.selected = NO;
        }
    }
    // 4.下部滑动view开始移动
    [UIView animateWithDuration:0.2f animations:^{
        self.canSliderLine.left = 15+selectBtn.tag * kCanSliderLineWidth;
    }];
}

#pragma mark - 移动指定的位置
-(void)moveToCurrentSelectSegment:(NSInteger)index;
{
    UIButton * selectBtn = self.segementButtonArray[index];
    [self clickBtn:selectBtn];
    
}
-(UIView *)bottomLine{
    
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc]init];
        _bottomLine.backgroundColor = [UIColor whiteColor];
    }
    return _bottomLine;
}
- (UIView *)canSliderLine
{
    if (!_canSliderLine) {
        _canSliderLine = [[UIView alloc]init];
        _canSliderLine.backgroundColor = [UIColor redColor];
    }
    return _canSliderLine;
    
}
- (UIView *)segementContainer
{
    if (!_segementContainer) {
        _segementContainer = [[UIView alloc]init];
        _segementContainer.backgroundColor = [UIColor whiteColor];
    }
    return _segementContainer;
}
@end
