//
//  ZSHPickerSheet.h
//  zsh
//
//  Created by R0CKSTAR on 5/28/14.
//  Copyright (c) 2014 anewlives. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZSHPickerSheet : UIActionSheet

@property (nonatomic, strong) id data;

@property (nonatomic) int selectedRow0;

@property (nonatomic) int selectedRow1;

- (void)showInView:(UIView *)view doneEvent:(ActionEvent)doneEvent cancelEvent:(ActionEvent)cancelEvent;

@end
