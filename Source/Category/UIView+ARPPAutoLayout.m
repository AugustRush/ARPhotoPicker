//
//  UIView+ARPPAutoLayout.m
//  ARPhotoPickerExample
//
//  Created by August on 15/9/11.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "UIView+ARPPAutoLayout.h"

@implementation UIView (ARPPAutoLayout)

- (void)autoAlignEdgesToSuperViewWithOptions:(UIViewEdgeTypeOptions)options {
    [self autoAlignEdgesToSuperViewWithOptions:options margin:0];
}

- (void)autoAlignEdgesToSuperViewWithOptions:(UIViewEdgeTypeOptions)options margin:(CGFloat)margin {
    NSAssert(self.superview != nil, @"superView should not be nil");
    self.translatesAutoresizingMaskIntoConstraints = NO;
    UIView *superView = self.superview;
    NSMutableArray *attributes = @[].mutableCopy;
    if (options & 1) {
        [attributes addObject:@(NSLayoutAttributeLeft)];
    }
    if (options & (1 << 1)) {
        [attributes addObject:@(NSLayoutAttributeRight)];
    }
    if (options & (1 << 2)) {
        [attributes addObject:@(NSLayoutAttributeTop)];
    }
    if (options & (1 << 3)) {
        [attributes addObject:@(NSLayoutAttributeBottom)];
    }
    
    [attributes enumerateObjectsUsingBlock:^(NSNumber *obj, NSUInteger idx, BOOL *stop) {
        NSLayoutAttribute attribute = [obj integerValue];
        [superView addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                              attribute:attribute
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:superView
                                                              attribute:attribute
                                                             multiplier:1
                                                               constant:margin]];
    }];

}

- (void)autoConstraintToHeight:(CGFloat)height {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:1
                                                      constant:height]];
}

- (void)autoConstraintToWidth:(CGFloat)width {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:1
                                                      constant:width]];
}

@end
