//
//  RSPlainButton.h
//  RSPOPPickerSheet
//
//  Created by R0CKSTAR on 5/22/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ActionEvent)(id sender);

@interface RSPlainButton : UIButton

@property (nonatomic, copy) ActionEvent click;

+ (instancetype)button;

- (void)action:(id)sender;

@end

@interface RSBoldPlainButton : RSPlainButton

@end

