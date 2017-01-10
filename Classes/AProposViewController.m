//
//  AProposViewController.m
//
//  Created by Lis@cintosh on 10/01/2017.
//
//

#import "AProposViewController.h"

#define LocalizedString(key, default) \
	[NSBundle.mainBundle localizedStringForKey:(key) value:(default) table:nil]

NSString * shortDescriptionForLicenceType(ApplicationLicenceType licenceType) {
	switch (licenceType) {
		case ApplicationLicenceTypeMIT:		return @"MIT";
		case ApplicationLicenceTypeGNU:		return @"GNU General Public 3.0";
		case ApplicationLicenceTypeApache:	return @"Apache";
		case ApplicationLicenceTypeApacheV2: return @"Apache 2.0";
		case ApplicationLicenceTypePublicDomain: return @"public domain";
		default: break;
	}
	return nil;
}

@implementation NSDate (YearAddition)

- (NSInteger)year
{
	NSCalendar * calendar = [NSCalendar currentCalendar];
	return [calendar component:NSCalendarUnitYear fromDate:self];
}

@end

@implementation NSURL (FormatAddition)

- (NSString *)shortDescription
{
	return [self.host stringByAppendingString:self.path];
}

@end

@implementation AProposViewController

- (instancetype)init
{
	if ((self = [super initWithStyle:UITableViewStyleGrouped])) { }
	return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];

	self.title = LocalizedString(@"a-propos.title", @"About");
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
																						  target:self action:@selector(doneAction:)];
	
	[self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"cellID"];
}

- (void)doneAction:(id)sender
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 2 + (_licenceType != ApplicationLicenceTypePrivate) /* Top header informations, web links, licence details (if not private) */;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	switch (section) {
		case 0: return 0;
		case 1: return _urls.count;
		case 2: return 1;
	}
	return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
	NSDictionary * infoDictionary = [NSBundle mainBundle].infoDictionary;
	NSString * name = infoDictionary[(__bridge NSString *)kCFBundleExecutableKey];
	switch (section) {
		case 0: {
			const NSString * shortVersion = infoDictionary[@"CFBundleShortVersionString"];
			return [NSString stringWithFormat:@"%@ %@" @"\n" @"%@, %lu",
					name, shortVersion, _author, [NSDate date].year];
		}
		case 2: {
			return [NSString stringWithFormat:LocalizedString(@"a-propos.licence.description", @"%@ is an open-source projet, under %@ licence."),
					name, shortDescriptionForLicenceType(_licenceType)];
		}
		default: break;
	}
	return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	if (indexPath.section == 1) {
		cell.textLabel.text = _urls[indexPath.row].shortDescription;
	}
	else if (indexPath.section == 2) {
		cell.textLabel.text = _repositoryURL.shortDescription;
	}
	return cell;
}

#pragma mark - Table view delegate

- (void)openURL:(NSURL *)url
{
	if (NSClassFromString(@"SFSafariViewController")) {
		SFSafariViewController * viewController = [[SFSafariViewController alloc] initWithURL:url];
		[self presentViewController:viewController animated:YES completion:nil];
	} else {
		if ([UIApplication instancesRespondToSelector:@selector(openURL:options:completionHandler:)]) {
			[[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
		} else {
			[[UIApplication sharedApplication] openURL:url];
		}
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	if (indexPath.section == 1) {
		[self openURL:_urls[indexPath.row]];
	}
	else if (indexPath.section == 2) {
		[self openURL:_repositoryURL];
	}
}

@end
