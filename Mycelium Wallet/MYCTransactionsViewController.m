//
//  MYCTransactionsViewController.m
//  Mycelium Wallet
//
//  Created by Oleg Andreev on 29.09.2014.
//  Copyright (c) 2014 Mycelium. All rights reserved.
//

#import "MYCTransactionsViewController.h"
#import "MYCWallet.h"
#import "MYCWalletAccount.h"

#import "PTableViewSource.h"

@interface MYCTransactionsViewController () <UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, weak) IBOutlet UITableView* tableView;
@property(nonatomic) PTableViewSource* tableViewSource;
@property(nonatomic) NSArray* transactions;
@property(nonatomic) MYCWalletAccount* currentAccount;
@end

@implementation MYCTransactionsViewController

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        self.title = NSLocalizedString(@"Transactions", @"");
        self.tintColor = [UIColor colorWithHue:41.0f/360.0f saturation:1.0f brightness:1.0f alpha:1.0f];
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"Transactions", @"") image:[UIImage imageNamed:@"TabTransactions"] selectedImage:[UIImage imageNamed:@"TabTransactionsSelected"]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (BOOL) shouldOverrideTintColor
{
    // Only override tint color if opened in the context of tabbar (no specific account is selected).
    return !_account;
}

- (MYCWalletAccount*) account
{
    return _account ?: _currentAccount;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    // If no account at all, load currentAccount.
    if (!self.account)
    {
        [[MYCWallet currentWallet] inDatabase:^(FMDatabase *db) {
            self.currentAccount = [MYCWalletAccount loadCurrentAccountFromDatabase:db];
        }];
    }

    // Reload account.
    [[MYCWallet currentWallet] inDatabase:^(FMDatabase *db) {
        [self.account reloadFromDatabase:db];
    }];

    [self.tableView reloadData];
}

- (void) updateTransactions
{
    self.transactions = @[];
}

#pragma mark - UITableView


- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.transactions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}


@end
