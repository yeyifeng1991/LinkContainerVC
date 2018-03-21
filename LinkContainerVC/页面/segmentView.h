//
//  segmentView.h
//  LinkContainerVC
//
//  Created by YeYiFeng on 2018/3/21.
//  Copyright © 2018年 叶子. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+FRAME.h"
//typedef void(^segmentButton)(NSInteger index);
@interface segmentView : UIView

/*
 1.回调索引
 2.暴露接口给外部调用
 3.实例化方法
 */
@property(nonatomic,copy)void(^segmentButton)(NSInteger index);
-(void)moveToCurrentSelectSegment:(NSInteger)index;
-(instancetype)initWithSegmentWithTitleArray:(NSArray*)segTitleArray;
@end
