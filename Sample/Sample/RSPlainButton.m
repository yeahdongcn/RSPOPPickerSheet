//
//  RSPlainButton.m
//  RSPOPPickerSheet
//
//  Created by R0CKSTAR on 5/22/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import "RSPlainButton.h"

#import <POP.h>

@implementation RSPlainButton

+ (instancetype)button
{
    return [self buttonWithType:UIButtonTypeCustom];
}

- (void)action:(id)sender
{
    if (self.click) {
        self.click(sender);
    }
}

- (void)setFrame:(CGRect)frame
{
    if (CGSizeEqualToSize(self.frame.size, CGSizeZero)) {
        [super setFrame:frame];
    }
    
    if (!CGPointEqualToPoint(self.frame.origin, frame.origin)) {
        frame.size.width = self.frame.size.width;
        frame.size.height = self.frame.size.height;
        [super setFrame:frame];
    }
}

- (void)scaleToSmall
{
    POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(0.95f, 0.95f)];
    [self.layer pop_addAnimation:scaleAnimation forKey:@"layerScaleSmallAnimation"];
}

- (void)scaleAnimation
{
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1, 1)];
    scaleAnimation.velocity = [NSValue valueWithCGSize:CGSizeMake(2, 2)];
    scaleAnimation.springBounciness = 20;
    [self.layer pop_addAnimation:scaleAnimation forKey:@"layerScaleSpringAnimation"];
}

- (void)scaleToDefault
{
    POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1, 1)];
    [self.layer pop_addAnimation:scaleAnimation forKey:@"layerScaleDefaultAnimation"];
}

- (void)setup
{
    [self addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(scaleToSmall) forControlEvents:UIControlEventTouchDown | UIControlEventTouchDragEnter];
    [self addTarget:self action:@selector(scaleAnimation) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(scaleToDefault) forControlEvents:UIControlEventTouchDragExit];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [self setup];
}

@end

@implementation RSBoldPlainButton

+ (instancetype)button
{
    RSBoldPlainButton *button = [super button];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:button.titleLabel.font.pointSize];
    return button;
}

@end
