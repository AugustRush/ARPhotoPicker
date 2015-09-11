//
//  UIView+ARPPAutoLayout.h
//  ARPhotoPickerExample
//
//  Created by August on 15/9/11.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, UIViewEdgeTypeOptions) {
    UIViewEdgeTypeOptionsLeft = 1 << 0,
    UIViewEdgeTypeOptionsRight = 1 << 1,
    UIViewEdgeTypeOptionsTop = 1 << 2,
    UIViewEdgeTypeOptionsBottom = 1 << 3
};

@interface UIView (ARPPAutoLayout)

- (void)autoAlignEdgesToSuperViewWithOptions:(UIViewEdgeTypeOptions)options;
- (void)autoAlignEdgesToSuperViewWithOptions:(UIViewEdgeTypeOptions)options margin:(CGFloat)margin;

- (void)autoConstraintToHeight:(CGFloat)height;
- (void)autoConstraintToWidth:(CGFloat)width;

@end
