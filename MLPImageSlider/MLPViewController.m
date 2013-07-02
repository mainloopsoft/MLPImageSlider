//
//  MLPViewController.m
//  MLPImageSlider
//
//  Created by Javier Figueroa on 4/25/13.
//  Copyright (c) 2013 Mainloop LLC. All rights reserved.
//

#import "MLPViewController.h"

@interface MLPViewController ()

@property (nonatomic, strong) NSMutableArray *photos;

@end

@implementation MLPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Blurred"]];
	// Do any additional setup after loading the view, typically from a nib.
    self.photos = [[NSMutableArray alloc] init];
    [self.photos addObject:[UIImage imageNamed:@"youtube"]];
    [self.photos addObject:[UIImage imageNamed:@"tumblr"]];
    [self.photos addObject:[UIImage imageNamed:@"facebook"]];
    [self.photos addObject:[UIImage imageNamed:@"github"]];
    [self.photos addObject:[UIImage imageNamed:@"grooveshark"]];
    [self.photos addObject:[UIImage imageNamed:@"instagram"]];
    [self.photos addObject:[UIImage imageNamed:@"twitter"]];
    [self.photos addObject:[UIImage imageNamed:@"pinterest"]];
    
    NSArray *animations = @[[NSNumber numberWithInt:MLPImageViewAnimationFade],
                            [NSNumber numberWithInt:MLPImageViewAnimationFadeLeft],
                            [NSNumber numberWithInt:MLPImageViewAnimationFlip]];
    
    for (UIView *slider in self.view.subviews) {
        if ([slider isKindOfClass:[MLPImageViewSlider class]]) {
            MLPImageViewSlider *square = (MLPImageViewSlider*)slider;
            square.delegate = self;
            square.animationType = [animations[arc4random() % animations.count] intValue];
            square.contentMode = UIViewContentModeScaleAspectFill;
            [square start];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MLPImageViewSlider Delegate

- (UIImage *)MLPImageViewSlider:(MLPImageViewSlider *)slider imageAtIndex:(NSInteger)index
{
    //if you noticed a small flick is because of the randomness of this below
    //In your applications the flick should not happen because you should have a non-random array
    return self.photos[arc4random() % self.photos.count];
}

- (NSInteger)numberOfImagesInImageViewSlider:(MLPImageViewSlider *)slider
{
    return self.photos.count;
}

@end
