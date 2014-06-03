//
//  ZSHPlainButton.h
//  zsh
//
//  Created by R0CKSTAR on 5/22/14.
//  Copyright (c) 2014 anewlives. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZSHPlainButton : UIButton

@property (nonatomic, copy) ActionEvent click;

+ (instancetype)button;

- (void)action:(id)sender;

@end
