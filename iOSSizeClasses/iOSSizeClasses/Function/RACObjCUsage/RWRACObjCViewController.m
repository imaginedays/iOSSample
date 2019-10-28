//
//  RWRACObjCViewController.m
//  iOSSizeClasses
//  https://www.jianshu.com/p/0845b1a07bfa
//  https://mochangxing.github.io/2018/08/26/RAC%20rac_signalForSelector%20%E5%A6%82%E4%BD%95%E5%AE%9E%E7%8E%B0%E5%AF%B9%E8%B1%A1%E6%96%B9%E6%B3%95%E7%9A%84hook/
//  Created by imaginedays on 2019/10/28.
//  Copyright © 2019 Robin Wong. All rights reserved.
//

#import "RWRACObjCViewController.h"
#import <objc/runtime.h>

@interface RWRACObjCViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *inputTextField;
@end

@implementation RWRACObjCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self rw_setupViews];
    // Do any additional setup after loading the view.
    
    // rac textfield
       [self.inputTextField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
           NSLog(@"input text = %@",x);
       }];
    // po [[UIApplication sharedApplication] _methodDescription]
//    [self.inputTextField performSelector:@selector(_methodDescription)];
//    [self dumpObjcMethods:self.inputTextField ];
    [self.inputTextField description];
}

#pragma mark - Private Method
- (void)rw_textFieldDidChange:(UITextField *)textField {
    
}

#pragma mark - Layout
- (void)rw_setupViews {
    [self.view addSubview:self.inputTextField];
    [self rw_makeConstraints];
}

- (void)rw_makeConstraints {
    [self.inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(200);
        make.left.mas_equalTo(self.view).offset(20);
        make.right.mas_equalTo(self.view).offset(-20);
    }];
}

#pragma mark - Accessor
- (UITextField *)inputTextField {
    if (!_inputTextField) {
        _inputTextField = [[UITextField alloc] init];
        _inputTextField.font = [UIFont systemFontOfSize:14.0f];
        _inputTextField.placeholder = @"输入内容";
        _inputTextField.textColor = HexRGB(0x333333);
        _inputTextField.textAlignment = NSTextAlignmentRight;
        _inputTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _inputTextField.spellCheckingType = UITextSpellCheckingTypeNo;
        _inputTextField.returnKeyType = UIReturnKeyDone;
        _inputTextField.delegate = self;
        _inputTextField.backgroundColor = [UIColor lightGrayColor];
        [_inputTextField addTarget:self action:@selector(rw_textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _inputTextField;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
