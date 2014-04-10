//
//  ReaderView.m
//  Flikrkr
//
//  Created by esgi on 10/04/2014.
//  Copyright (c) 2014 Oui. All rights reserved.
//

#import "ReaderView.h"

@interface ReaderView ()

@property (nonatomic, assign) int currentIndex;

@end

@implementation ReaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */
-(void)displayPageAtIndex:(int)index animated:(BOOL)animated
{
    if (index >= 0 && index < [self.delegate numberOfPages]) {
        if (!animated) {
            [self.subviews.lastObject removeFromSuperview];
            UIView * view = [self.delegate pageAtIndex:index];
            [self addSubview:view];
        }
        else {
            UIView * oldView = [self.subviews lastObject];
            UIView * newView = [self.delegate pageAtIndex:index];
            [self addSubview:newView];
            CGPoint center = newView.center;
            CGPoint left = CGPointMake(center.x - self.bounds.size.width, center.y);
            CGPoint right = CGPointMake(center.x + self.bounds.size.width, center.y);
            if (index < self.currentIndex) {
                // page précédente
                newView.center = left;
                [UIView animateWithDuration:.3
                                 animations:^{
                                     newView.center = center;
                                     oldView.center = right;
                                 }
                                 completion:^(BOOL finished) {
                                     [oldView removeFromSuperview];
                                 }];
            }
            else {
                // page suivante
                newView.center = right;
                [UIView animateWithDuration:.3
                                 animations:^{
                                     newView.center = center;
                                     oldView.center = left;
                                 }
                                 completion:^(BOOL finished) {
                                     [oldView removeFromSuperview];
                                 }];
                
            }
        }
        self.currentIndex = index;
    }
}
- (void)layoutSubviews
{
    if (!self.gestureRecognizers.count) {
        UISwipeGestureRecognizer * previousPageRecognizer =
        [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(previousPage)];
        previousPageRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
        [self addGestureRecognizer:previousPageRecognizer];
        
        UISwipeGestureRecognizer * nextPageRecognizer =
        [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(nextPage)];
        nextPageRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
        [self addGestureRecognizer:nextPageRecognizer];
        
        self.userInteractionEnabled = YES;
    }
}

- (void) previousPage
{
    [self displayPageAtIndex:self.currentIndex-1 animated:YES];
}
- (void) nextPage
{
    [self displayPageAtIndex:self.currentIndex+1 animated:YES];
}
@end
