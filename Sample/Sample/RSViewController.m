//
//  RSViewController.m
//  Sample
//
//  Created by R0CKSTAR on 6/3/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import "RSViewController.h"

#import "RSPickerSheet.h"

@interface RSViewController ()

@end

@implementation RSViewController

- (IBAction)clicked:(id)sender
{
    RSPickerSheet *picker = LoadXib(@"RSPickerSheet");
    /**
     *  picker.data should be NSArray<NSString> or NSDictionary<NSString, NSArray<NSString>>
     */
//    picker.data = @[@"item0", @"item1", @"item2"];
    picker.data = @{@"small": @[@"item0", @"item1", @"item2"],
                    @"normal": @[@"item0", @"item1", @"item2"],
                    @"big": @[@"item0", @"item1", @"item2"]};
    [picker showInView:self.view doneEvent:^(id sender) {
        NSLog(@"%d %d", picker.selectedRow0, picker.selectedRow1);
    } cancelEvent:^(id sender) {
    }];
}

@end
