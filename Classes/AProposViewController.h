//
//  AProposViewController.h
//
//  Created by Lis@cintosh on 10/01/2017.
//
//

@import SafariServices;

typedef NS_ENUM(NSUInteger, ApplicationLicenceType) {
	ApplicationLicenceTypePrivate = 0,
	
	ApplicationLicenceTypeMIT,
	ApplicationLicenceTypeApache,
	ApplicationLicenceTypePublicDomain
};
extern NSString * _Nullable shortDescriptionForLicenceType(ApplicationLicenceType licenceType);

@interface AProposViewController : UITableViewController

@property (nonatomic, assign) ApplicationLicenceType licenceType;
@property (nonatomic, strong, nonnull) NSString * author;
@property (nonatomic, strong, nonnull) NSArray <NSURL *> * urls;
@property (nonatomic, strong, nullable) NSURL * repositoryURL;

@end
