//
//  MLPImageSliderView.m
//  MLPImageSlider
//
//  Created by Javier Figueroa on 4/25/13.
//  Copyright (c) 2013 Mainloop LLC. All rights reserved.
//

#import "MLPImageViewSlider.h"

@interface MLPImageViewSlider()
{
    NSTimer *timer;
    int index;
}

@property (nonatomic, strong) UIImageView *backView;
@property (nonatomic, strong) UIImageView *frontView;

@end

@implementation MLPImageViewSlider

- (void)setDelegate:(id<MLPImageViewSliderDelegate>)delegate
{
    _delegate = delegate;
}

- (UIViewContentMode)contentMode
{
    if (!_contentMode) {
        _contentMode = UIViewContentModeScaleAspectFit;
    }
    
    return _contentMode;
}

- (UIImageView *)backView
{
    if (!_backView) {
        _backView = [[UIImageView alloc] initWithFrame:self.bounds];
        _backView.clipsToBounds = YES;
    }
    
    return _backView;
}

- (UIImageView *)frontView
{
    if (!_frontView) {
        _frontView = [[UIImageView alloc] initWithFrame:self.bounds];
        _frontView.clipsToBounds = YES;
    }
    
    return _frontView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addImageViews];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self addImageViews];        
    }

    return self;
}

- (void)addImageViews
{
    [self addSubview:self.backView];
    [self addSubview:self.frontView];
    self.clipsToBounds = YES;

}

- (void)didMoveToWindow
{
    const BOOL didAppear = (self.window != nil);
    
    if (didAppear)
    {
        [self restart];
    }
    else
    {
        [self stop];
    }
}

- (void)setImage:(UIImage*)image toView:(UIImageView*)imageView
{
    [imageView setImage:image];
    [imageView setContentMode:self.contentMode];
    [imageView setClipsToBounds:YES];
}


- (void)start
{
    if (!timer) {
        NSInteger numberOfImages = [self.delegate numberOfImagesInImageViewSlider:self];
        
        if (numberOfImages == 0) {
            self.frontView.alpha = 1;
            [self setImage:self.placeholder toView:self.frontView];
        }else if (numberOfImages > 0) {
            [self setImage:[_delegate MLPImageViewSlider:self imageAtIndex:0] toView:self.frontView];
            
            if (numberOfImages > 1) {
                timer = [NSTimer scheduledTimerWithTimeInterval:3
                                                         target:self
                                                       selector:@selector(animate)
                                                       userInfo:nil
                                                        repeats:YES];
            }
        }
    }
}

- (void)stop
{
    [timer invalidate];
    timer = nil;
    index = 0;
}

- (void)restart
{
    [self stop];
    [self start];
}

- (void)animate
{
    self.frontView.alpha = 1;
    self.backView.alpha = 0;
    
    NSInteger numberOfImages = [self.delegate numberOfImagesInImageViewSlider:self];    
    index = (index + 1) % numberOfImages;    
    [self setImage:[_delegate MLPImageViewSlider:self imageAtIndex:index] toView:self.backView];
    
    switch (self.animationType) {
        case MLPImageViewAnimationFade:
            [self fade];
            break;
        case MLPImageViewAnimationFadeLeft:
            [self fadeLeft];
            break;
        case MLPImageViewAnimationFlip:
            [self flip];
            break;
        default:
            [self fade];
            break;
    }
}

- (void)fade
{
    [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.frontView.alpha = 0;
        self.backView.alpha = 1;
    } completion:^(BOOL finished) {
        if (timer) {
            [self setImage:[_delegate MLPImageViewSlider:self imageAtIndex:index] toView:self.frontView];
        }
    }];
}

- (void)fadeLeft
{
    NSInteger frameWidth = self.frontView.frame.size.width;
    
    [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.frontView.alpha = 0;
        self.backView.alpha = 1;
        self.frontView.center = CGPointMake(self.frontView.center.x-frameWidth, self.frontView.center.y);
    } completion:^(BOOL finished) {
        if (timer) {
            [self setImage:[_delegate MLPImageViewSlider:self imageAtIndex:index] toView:self.frontView];
            self.frontView.center = CGPointMake(self.frontView.center.x+frameWidth, self.frontView.center.y);
        }
    }];
}

- (void)flip
{
    [UIView transitionWithView:self
                      duration:1
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        self.frontView.alpha = 0;
                        self.backView.alpha = 1;
                        if (timer) {
                            [self setImage:[_delegate MLPImageViewSlider:self imageAtIndex:index] toView:self.frontView];
                        }
                    } completion:^(BOOL finished) {
                        
                        
                    }];
}

@end
