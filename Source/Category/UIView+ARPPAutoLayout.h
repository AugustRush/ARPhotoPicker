//
//  UIView+ARPPAutoLayout.h
//  ARPhotoPickerExample
//
//  Created by August on 15/9/11.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, ARViewEdgeTypeOptions) {
    ARViewEdgeTypeOptionsLeft = 1 << 0,
    ARViewEdgeTypeOptionsRight = 1 << 1,
    ARViewEdgeTypeOptionsTop = 1 << 2,
    ARViewEdgeTypeOptionsBottom = 1 << 3
};

@interface UIView (ARPPAutoLayout)

// for superView
- (void)autoAlignEdgesToSuperViewWithOptions:(ARViewEdgeTypeOptions)options;
- (void)autoAlignEdgesToSuperViewWithOptions:(ARViewEdgeTypeOptions)options margin:(CGFloat)margin;

- (void)autoConstraintToHeight:(CGFloat)height;
- (void)autoConstraintToWidth:(CGFloat)width;

@end
