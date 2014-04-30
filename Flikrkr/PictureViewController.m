//
//  PictureViewController.m
//  Flikrkr
//
//  Created by esgi on 10/04/2014.
//  Copyright (c) 2014 Oui. All rights reserved.
//

#import "PictureViewController.h"
#import "ReaderView.h"

@interface PictureViewController () <ReaderViewDelegate>

@property (weak, nonatomic) IBOutlet ReaderView *readerView;
@property (strong, nonatomic) NSArray * pictures;

@end

@implementation PictureViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    FlickLocation location;
    
    // big ben
    // location.latitude = 51.500773;
    // location.longitude = -0.12464;
    // location.radius = 5;
    
    // central park
    // location.latitude = 40.767852;
    // location.longitude = -73.979694;
    // location.radius = 1;
    
    // paris
    location.latitude = 48.856667;
    location.longitude =  2.350987;
    location.radius = 10;
    
    self.pictures = [FlickPicture picturesAroundLocation:location];
    self.readerView.delegate = self;
}
- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.readerView displayPageAtIndex:0 animated:NO];
}
- (int) numberOfPages
{
    return self.pictures.count;
}
- (UIView *) pageAtIndex:(int)index
{
    //NSString * imageName = [NSString stringWithFormat:@"%i.jpg",index];
    //UIImage * image = [UIImage imageNamed:imageName];
    FlickPicture * picture = self.pictures[index];
    NSData * imageData = [NSData dataWithContentsOfURL:picture.url];
    UIImage * image = [UIImage imageWithData:imageData];
    
    UIImageView * imageView = [[UIImageView alloc] initWithImage: image];
    imageView.frame = self.readerView.bounds;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    return imageView;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
