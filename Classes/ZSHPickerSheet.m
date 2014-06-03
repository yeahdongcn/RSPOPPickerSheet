//
//  ZSHPickerSheet.m
//  zsh
//
//  Created by R0CKSTAR on 5/28/14.
//  Copyright (c) 2014 anewlives. All rights reserved.
//

#import "ZSHPickerSheet.h"

#import <POP.h>

@interface ZSHPickerSheet () <UIPickerViewDataSource, UIPickerViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, weak) IBOutlet UIView *background;

@property (nonatomic, weak) IBOutlet UIView *container;

@property (nonatomic, weak) IBOutlet UIToolbar *toolbar;

@property (nonatomic, weak) IBOutlet UIPickerView *picker;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *bottom;

@property (nonatomic, weak) ZSHPlainButton *cancel;

@property (nonatomic, weak) ZSHBoldPlainButton *done;

@property (nonatomic, copy) ActionEvent launchEvent;

@end

@implementation ZSHPickerSheet

- (void)dismiss
{
    self.frame = SharedWindow.bounds;
    
    [self dismissWithClickedButtonIndex:0 animated:YES];
    
    POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    opacityAnimation.toValue = @(0);
    [self.background.layer pop_addAnimation:opacityAnimation forKey:@"opacityAnimation"];
}

- (void)tap:(UITapGestureRecognizer *)tapGestureRecognizer
{
    [self dismiss];
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.y = frame.origin.y + frame.size.height - self.toolbar.bounds.size.height - self.picker.bounds.size.height;
    frame.size.height = self.toolbar.bounds.size.height + self.picker.bounds.size.height;
    [super setFrame:frame];
    
    if (self.launchEvent && frame.origin.y > 0) {
        self.launchEvent(self);
        self.launchEvent = nil;
    }
}

- (void)awakeFromNib
{
    __weak __typeof(self)weakself = self;
    self.launchEvent = ^(id sender) {
        POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayoutConstraintConstant];
        positionAnimation.toValue = 0;
        positionAnimation.springBounciness = 20;
        
        POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
        scaleAnimation.springBounciness = 20;
        scaleAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0.95f, 0.95f)];
        
        POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
        opacityAnimation.toValue = @(0.2);
        opacityAnimation.completionBlock = ^(POPAnimation *anim, BOOL finished) {
            if (finished) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [super setFrame:SharedWindow.bounds];
                });
            }
        };
        
        [weakself.bottom pop_addAnimation:positionAnimation forKey:@"positionAnimation"];
        [weakself.container.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
        [weakself.background.layer pop_addAnimation:opacityAnimation forKey:@"opacityAnimation"];
    };
    
    self.background.layer.opacity = 0;
    self.background.backgroundColor = [UIColor colorWithHexString:[SharedUiss.variablesPreprocessor getValueForVariableWithName:@"black"]];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.background addGestureRecognizer:tap];
    
    self.cancel = [ZSHPlainButton button];
    [self.cancel setTitle:UIKitLocalizedString(@"Cancel") forState:UIControlStateNormal];
    self.cancel.click = ^(id sender) {
        [self dismiss];
    };
    [self.cancel sizeToFit];
    
    self.done = [ZSHBoldPlainButton button];
    [self.done setTitle:UIKitLocalizedString(@"Done") forState:UIControlStateNormal];
    self.done.click = ^(id sender) {
        [self dismiss];
    };
    [self.done sizeToFit];
    
    self.toolbar.items = @[[[UIBarButtonItem alloc] initWithCustomView:self.cancel],
                           self.toolbar.items[1],
                           [[UIBarButtonItem alloc] initWithCustomView:self.done]];
    
    self.picker.dataSource = self;
    self.picker.delegate = self;
}

- (void)drawRect:(CGRect)rect
{
    for (UIView *subview in self.subviews) {
        if (subview != self.container
            && subview != self.background) {
            [subview removeFromSuperview];
        }
    }
}

- (void)showInView:(UIView *)view doneEvent:(ActionEvent)doneEvent cancelEvent:(ActionEvent)cancelEvent
{
    self.cancel.click = ^(id sender) {
        if (cancelEvent) {
            cancelEvent(self);
        }
        [self dismiss];
    };
    self.done.click = ^(id sender) {
        if (doneEvent) {
            doneEvent(self);
        }
        [self dismiss];
    };
    [super showInView:view];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if ([self.data isKindOfClass:[NSArray class]]) {
        return 1;
    } else if ([self.data isKindOfClass:[NSDictionary class]]) {
        return 2;
    } else {
        return 0;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if ([self.data isKindOfClass:[NSArray class]]) {
        return [(NSArray *)self.data count];
    } else if ([self.data isKindOfClass:[NSDictionary class]]) {
        if (component == 0) {
            return [[(NSDictionary *)self.data allKeys] count];
        } else {
            return [(NSArray *)[(NSDictionary *)self.data objectForKey:[(NSDictionary *)self.data allKeys][self.selectedRow0]] count];
        }
    } else {
        return 0;
    }
}

#pragma mark - UIPickerViewDelegate

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = nil;
    if (view) {
        label = (UILabel *)view;
    } else {
        label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.textColor = [UIColor colorWithHexString:[SharedUiss.variablesPreprocessor getValueForVariableWithName:@"gray_light"]];
        label.font = [UIFont systemFontOfSize:[[SharedUiss.variablesPreprocessor getValueForVariableWithName:@"font_24"] floatValue]];
        NSArray *shadowOffset = [SharedUiss.variablesPreprocessor getValueForVariableWithName:@"shadowOffsetZero"];
        label.shadowOffset = CGSizeMake([shadowOffset[0] floatValue], [shadowOffset[1] floatValue]);
    }
    
    if ([self.data isKindOfClass:[NSArray class]]) {
        label.text = ((NSArray *)self.data)[row];
    } else if ([self.data isKindOfClass:[NSDictionary class]]) {
        if (component == 0) {
            label.text = [(NSDictionary *)self.data allKeys][row];
        } else {
            label.text = ((NSArray *)[(NSDictionary *)self.data objectForKey:[(NSDictionary *)self.data allKeys][self.selectedRow0]])[row];
        }
    }
    [label sizeToFit];
    
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ([self.data isKindOfClass:[NSArray class]]) {
        self.selectedRow0 = row;
    } else if ([self.data isKindOfClass:[NSDictionary class]]) {
        if (component == 0) {
            self.selectedRow0 = row;
            self.selectedRow1 = 0;
            [pickerView reloadComponent:1];
            [pickerView selectRow:self.selectedRow1 inComponent:1 animated:YES];
        } else {
            self.selectedRow1 = row;
        }
    }
}

@end
