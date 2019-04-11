//
//  RWStepTabView.h
//  iOSSizeClasses
//
//  Created by imaginedays on 2019/3/27.
//  Copyright © 2019 黄可. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RWItemView : UIView

@end

@interface RWStepTabView : UIView
- (void)setupStepWithStepName:(NSArray *)titleArr;
- (void)setupStepWithIndex:(int)index;
@end

NS_ASSUME_NONNULL_END
