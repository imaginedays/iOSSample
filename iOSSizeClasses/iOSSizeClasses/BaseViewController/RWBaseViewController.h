//
//  RWBaseViewController.h
//  iOSSizeClasses
//
//  Created by imaginedays on 14/12/2017.
//  Copyright © 2017 黄可. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RWBaseViewController : UIViewController

- (instancetype)initWithTitle:(NSString *)title andIdentifierStr:(NSString *) identifierStr;
- (instancetype)initWithTitle:(NSString *)title;

@property (nonatomic, copy) NSString *identifierStr;


@end
