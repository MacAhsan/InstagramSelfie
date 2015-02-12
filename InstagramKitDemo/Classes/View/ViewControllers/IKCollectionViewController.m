//  Created by Muhammad Ahsan on 01/20/15.
// Code Test
//

#import "IKCollectionViewController.h"
#import "InstagramKit.h"
#import "UIImageView+AFNetworking.h"
#import "IKCell.h"
#import "InstagramMedia.h"
#import "InstagramUser.h"
#import "IKLoginViewController.h"
#import "IKMediaViewController.h"

@interface IKCollectionViewController ()
{
    NSMutableArray *mediaArray;
    __weak IBOutlet UITextField *textField;
}
@property (nonatomic, strong) InstagramPaginationInfo *currentPaginationInfo;
@end

@implementation IKCollectionViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        mediaArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadMedia];
}

- (IBAction)reloadMedia
{
    self.currentPaginationInfo = nil;
    if (mediaArray) {
        [mediaArray removeAllObjects];
    }

    [self loadMedia];
}

- (void)loadMedia
{
    [textField resignFirstResponder];
    textField.text = @"selfie";

    InstagramEngine *sharedEngine = [InstagramEngine sharedEngine];
    
    if (sharedEngine.accessToken)
    {
        //[self testLoadSelfFeed];
//        [self testLoadSelfLikedMedia];
//        [self getSelfUserDetails];
        [self testGetMediaFromTag:@"selfie"];
    }
    else
    {
        //[self testLoadPopularMedia];
         [self testGetMediaFromTag:@"selfie"];
    }
}

- (IBAction)searchMedia
{
    self.currentPaginationInfo = nil;
    if (mediaArray) {
        [mediaArray removeAllObjects];
    }
    [textField resignFirstResponder];

    if ([textField.text length]) {
        [self testGetMediaFromTag:textField.text];
//        [self testSearchUsersWithString:textField.text];
    }
}


- (void)testLoadPopularMedia
{
    [[InstagramEngine sharedEngine] getPopularMediaWithSuccess:^(NSArray *media, InstagramPaginationInfo *paginationInfo) {
        [mediaArray removeAllObjects];
        [mediaArray addObjectsFromArray:media];
        [self reloadData];
    } failure:^(NSError *error) {
        NSLog(@"Load Popular Media Failed");
    }];

}

- (void)getSelfUserDetails
{
    [[InstagramEngine sharedEngine] getSelfUserDetailsWithSuccess:^(InstagramUser *userDetail) {
        NSLog(@"%@",userDetail);
    } failure:^(NSError *error) {
        
    }];
}


- (void)testLoadSelfFeed
{
    [[InstagramEngine sharedEngine] getSelfFeedWithCount:15 maxId:self.currentPaginationInfo.nextMaxId success:^(NSArray *media, InstagramPaginationInfo *paginationInfo) {
        self.currentPaginationInfo = paginationInfo;
        
        [mediaArray addObjectsFromArray:media];
        
        [self reloadData];
    } failure:^(NSError *error) {
        NSLog(@"Request Self Feed Failed");
    }];
}


- (void)testLoadSelfLikedMedia
{
    [[InstagramEngine sharedEngine] getMediaLikedBySelfWithCount:15 maxId:self.currentPaginationInfo.nextMaxId success:^(NSArray *media, InstagramPaginationInfo *paginationInfo) {
        self.currentPaginationInfo = paginationInfo;
        
        [mediaArray addObjectsFromArray:media];
        
        [self reloadData];
    } failure:^(NSError *error) {
        NSLog(@"Request Self Liked Media Failed");
        
    }];
}


- (void)testSearchUsersWithString:(NSString *)string
{
    [[InstagramEngine sharedEngine] searchUsersWithString:string withSuccess:^(NSArray *users, InstagramPaginationInfo *paginationInfo) {
        NSLog(@"%ld users found", (long)users.count);
    } failure:^(NSError *error) {
        NSLog(@"user search failed");
    }];
}

- (void)testGetMediaFromTag:(NSString *)tag
{
    [[InstagramEngine sharedEngine] getMediaWithTagName:tag count:15 maxId:self.currentPaginationInfo.nextMaxId withSuccess:^(NSArray *media, InstagramPaginationInfo *paginationInfo) {
        self.currentPaginationInfo = paginationInfo;
        [mediaArray addObjectsFromArray:media];
        [self reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"Search Media Failed");
    }];
}

- (void)testLoadMediaForUser:(InstagramUser *)user
{
    [[InstagramEngine sharedEngine] getMediaForUser:user.Id count:15 maxId:self.currentPaginationInfo.nextMaxId withSuccess:^(NSArray *feed, InstagramPaginationInfo *paginationInfo) {

        if (paginationInfo) {
            self.currentPaginationInfo = paginationInfo;
        }
        
        [mediaArray addObjectsFromArray:feed];
        [self reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"Loading User media failed");
    }];
}

- (void)testPaginationRequest:(InstagramPaginationInfo *)pInfo
{
    [[InstagramEngine sharedEngine] getPaginatedItemsForInfo:self.currentPaginationInfo withSuccess:^(NSArray *media, InstagramPaginationInfo *paginationInfo) {
        NSLog(@"%ld more media in Pagination",(unsigned long)media.count);
        self.currentPaginationInfo = paginationInfo;
        [mediaArray addObjectsFromArray:media];
        [self reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"Pagination Failed");
    }];
}

- (void)reloadData
{
    [self.collectionView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"segue.media.detail"]) {
        IKMediaViewController *mvc = (IKMediaViewController *)segue.destinationViewController;
        NSIndexPath *selectedIndexPath = [self.collectionView indexPathsForSelectedItems][0];
        InstagramMedia *media = mediaArray[selectedIndexPath.item];
        mvc.media = media;
    }
    if ([segue.identifier isEqualToString:@"segue.login"]) {
        UINavigationController *loginNavigationVC = (UINavigationController *)segue.destinationViewController;
        IKLoginViewController *loginVc = loginNavigationVC.viewControllers[0];
        loginVc.collectionViewController = self;
    }
}

#pragma mark - UICollectionViewDelegate -

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return mediaArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    IKCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CPCELL" forIndexPath:indexPath];
    
    if (mediaArray.count >= indexPath.row+1) {
        InstagramMedia *media = mediaArray[indexPath.row];
        [cell.imageView setImageWithURL:media.thumbnailURL];
    }
    else
        [cell.imageView setImage:nil];
    return cell;

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
//    InstagramMedia *media = mediaArray[indexPath.row];
//    [self testLoadMediaForUser:media.user];
    
    if (self.currentPaginationInfo)
    {
//  Paginate on navigating to detail
//either
//        [self loadMedia];
//or
//        [self testPaginationRequest:self.currentPaginationInfo];
    }
}

#pragma mark - UITextFieldDelegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)tField
{
    if (tField.text.length) {
        [self searchMedia];
    }
    [tField resignFirstResponder];

    return YES;
}

@end
