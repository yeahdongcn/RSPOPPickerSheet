//
//  RSPickerSheet.h
//  RSPOPPickerSheet
//
//  Created by R0CKSTAR on 5/28/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RSPlainButton.h"

#define LoadXib(name) [[[NSBundle mainBundle] loadNibNamed:name owner:nil options:nil] firstObject]

@interface RSPickerSheet : UIActionSheet

@property (nonatomic, strong) id data;

@property (nonatomic) NSInteger selectedRow0;

@property (nonatomic) NSInteger selectedRow1;

- (void)showInView:(UIView *)view doneEvent:(ActionEvent)doneEvent cancelEvent:(ActionEvent)cancelEvent;

@end
