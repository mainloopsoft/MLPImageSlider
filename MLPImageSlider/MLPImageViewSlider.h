//
//  MLPImageSliderView.h
//  MLPImageSlider
//
//  Created by Javier Figueroa on 4/25/13.
//  Copyright (c) 2013 Mainloop LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
	MLPImageViewAnimationFade,
    MLPImageViewAnimationFadeLeft,
	MLPImageViewAnimationFlip, 
} MLPImageViewAnimation;

@class MLPImageViewSlider;
@protocol MLPImageViewSliderDelegate <NSObject>

- (NSInteger)numberOfImagesInImageViewSlider:(MLPImageViewSlider*)slider;

- (UIImage*)MLPImageViewSlider:(MLPImageViewSlider*)slider imageAtIndex:(NSInteger)index;

@end

@interface MLPImageViewSlider : UIView


@property (nonatomic, strong) UIImage *placeholder;
@property (nonatomic) UIViewContentMode contentMode; //defaults to UIViewContentModeScaleAspectFit
@property (nonatomic, assign) id<MLPImageViewSliderDelegate> delegate;
@property (nonatomic, assign) MLPImageViewAnimation animationType;

- (void)start;

- (void)restart;

- (void)stop;

@end
