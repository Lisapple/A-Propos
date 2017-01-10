//
//  ViewController.m
//
//  Created by Lisacintosh on 10/01/2017.
//
//

#import "ViewController.h"
#import "AProposViewController.h"

@implementation ViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.view.backgroundColor = [UIColor whiteColor];
	
	UIButton * button = [UIButton buttonWithType:UIButtonTypeInfoDark];
	[button addTarget:self action:@selector(presentAboutAction:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:button];
	// Center button in center of view
	button.translatesAutoresizingMaskIntoConstraints = NO;
	[self.view addConstraints:@[ [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual
																 toItem:button attribute:NSLayoutAttributeCenterX multiplier:1 constant:0],
								 [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual
																 toItem:button attribute:NSLayoutAttributeCenterY multiplier:1 constant:0] ]];
}

- (void)presentAboutAction:(id)sender
{
	AProposViewController * controller = [[AProposViewController alloc] init];
	controller.author = @"Lisacintosh";
	controller.licenceType = ApplicationLicenceTypePublicDomain;
	controller.urls = @[ [NSURL URLWithString:@"https://appstore.com/lisacintosh"],
						 [NSURL URLWithString:@"https://support.lisacintosh.com"],
						 [NSURL URLWithString:@"https://lisacintosh.com"] ];
	
	controller.repositoryURL = [NSURL URLWithString:[@"https://github.com/lisapple/a-propos" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	
	UINavigationController * navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
	[self presentViewController:navigationController animated:YES completion:nil];
}

@end
