//
//  ContainerViewController.m
//  twitterapp
//
//  Created by Bharti Agrawal on 7/14/14.
//  Copyright (c) 2014 Yahoo Inc. All rights reserved.
//

#import "ContainerViewController.h"
#import "TweetViewController.h"
#import "TimeLineViewController.h"
#import "MainMenuViewController.h"



@interface ContainerViewController ()
@property (nonatomic, strong) MainMenuViewController *mmvc;
@property (nonatomic, strong) TweetViewController *tvc;
@property (nonatomic, strong) TimeLineViewController *tlvc;
@property (nonatomic, strong) NSArray *tweets;
@property BOOL menuPresented;

@end

@implementation ContainerViewController

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
    // Do any additional setup after loading the view from its nib.
    self.mmvc = [[MainMenuViewController alloc] init];
    
    [self timeline];
    
    // Configure the right button
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(toggle)];
    [leftButton setImage:[UIImage imageNamed:@"menu.png"]];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    //add pan gesture recognizer
    UIScreenEdgePanGestureRecognizer *gestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self.menuInteractor action:@selector(userDidPan:)];
    gestureRecognizer.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:gestureRecognizer];
    
}

- (id) menuInteractor{
    return nil;
}

-(void)userDidPan:(UIScreenEdgePanGestureRecognizer *)recognizer{
    [self presentViewController:self.mmvc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (ContainerViewController *) initWithArray:(NSArray *)tweets{
    self.tweets = [Tweet tweetsWithArray:tweets];
    self.tlvc = [[TimeLineViewController alloc] initWithArray:tweets];

    return self;
}

- (void) toggle{
    if (self.menuPresented){
        [self timeline];
    } else {
        [self settings];
    }
}

- (void) timeline{
    //add the timeline view controller
    [self addChildViewController:self.tlvc];
    [self.view addSubview:self.tlvc.view];
    [self.tlvc didMoveToParentViewController:self];
    self.menuPresented = false;
}


- (void) settings{
    //add the menu view controller
    [self addChildViewController:self.mmvc];
    [self.view addSubview:self.mmvc.view];
    [self.mmvc didMoveToParentViewController:self];
    self.menuPresented = true;
}


-(void)swapCurrentControllerWith:(UIViewController*)viewController{
    
    //1. The current controller is going to be removed
    [self.mmvc willMoveToParentViewController:nil];
    
    //2. The new controller is a new child of the container
    [self addChildViewController:viewController];
    
    //3. Setup the new controller's frame depending on the animation you want to obtain
    viewController.view.frame = CGRectMake(0, 2000, viewController.view.frame.size.width, viewController.view.frame.size.height);
    
    //The transition automatically removes the old view from the superview and attaches the new controller's view as child of the
    //container controller's view
    
    //Save the button position... we'll need it later
    //CGPoint buttonCenter = self.button.center;
    
    [self transitionFromViewController:self.tlvc toViewController:viewController
                              duration:1.3 options:0
                            animations:^{
                                
                                //The new controller's view is going to take the position of the current controller's view
                                viewController.view.frame = self.tlvc.view.frame;
                                
                                //The current controller's view will be moved outside the window
                                self.tlvc.view.frame = CGRectMake(0,
                                                                                         -2000,
                                                                                         self.tlvc.view.frame.size.width,
                                                                                         self.tlvc.view.frame.size.width);
                                
                                //self.button.center = CGPointMake(buttonCenter.x,1000);
                                
                                
                            } completion:^(BOOL finished) {
                                //Remove the old view controller
                                [self.tlvc removeFromParentViewController];
                                
                                //Set the new view controller as current
                                self.tlvc = viewController;
                                [self.tlvc didMoveToParentViewController:self];
                                
                                //reset the button position
                                /*[UIView animateWithDuration:0.5 animations:^{
                                    self.button.center = buttonCenter;
                                }];*/
                                
                            }];
}

@end
