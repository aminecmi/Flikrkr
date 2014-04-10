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
-(void)displayPageAtIndex:(int)index
{
    if (index >= 0 && index < [self.delegate numberOfPages]) {
        UIView * view = [self.delegate pageAtIndex:index];
        [self addSubview:view];
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
    [self displayPageAtIndex:self.currentIndex-1];
}
- (void) nextPage
{
    [self displayPageAtIndex:self.currentIndex+1];
}
@end
