//
//  RWUITextFieldVC.m
//  iOSSizeClasses
//
//  Created by Robin Wong on 2019/3/21.
//  Copyright © 2019 黄可. All rights reserved.
//

#import "RWUITextFieldVC.h"
#import "RWAutoDictionary.h"

@interface RWUITextFieldVC ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *inputTextField;
@end

@implementation RWUITextFieldVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self rw_setupViews];
    RWAutoDictionary *dic = [RWAutoDictionary new];
    dic.date = [NSDate dateWithTimeIntervalSince1970:475372800];
    NSLog(@"dict.date = %@",dic.date);
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
//        make.height.equalTo(@21);
    }];
}

#pragma mark - Private Method
- (void)rw_textFieldDidChange:(UITextField *)textField {
    
}

// 过滤所有表情
- (BOOL)stringContainsEmoji:(NSString *)string {
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     returnValue = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 returnValue = YES;
             }
             
         } else {
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff) {
                 returnValue = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 returnValue = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 returnValue = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 returnValue = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 returnValue = YES;
             }
         }
     }];
    
    return returnValue;
}

#pragma mark - UITextFieldDelegate
// return NO to disallow editing.
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}

// became first responder
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
}

// return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    return YES;
}

// may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
}

// if implemented, called in place of textFieldDidEndEditing:  NS_AVAILABLE_IOS(10_0);
- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason {
    
}

// return NO to not change text
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // 不让输入表情
//    if ([textField isFirstResponder]) {
//        if ([[[textField textInputMode] primaryLanguage] isEqualToString:@"emoji"] || ![[textField textInputMode] primaryLanguage]) {
//            NSLog(@"输入的是表情，返回NO");
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告！" message:@"不能输入表情" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
//            [alertView show];
//            return NO;
//        }
//    }
    NSLog(@"textField.text = %@",textField.text);
    NSLog(@"string = %@",string);
    
    if ([self stringContainsEmoji:string]) {
        NSLog(@"包含表情符号");
        
        return NO;
    } else {
        NSLog(@"不包含表情符号");
    }
    
    return YES;
}

// called when clear button pressed. return NO to ignore (no notifications)
- (BOOL)textFieldShouldClear:(UITextField *)textField {
    return YES;
}

// called when 'return' key pressed. return NO to ignore.
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return YES;
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
@end
