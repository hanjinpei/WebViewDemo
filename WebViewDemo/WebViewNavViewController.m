//
//  WebViewNavViewController.m
//  WebViewDemo
//
//  Created by FNT on 5/31/13.
//  Copyright (c) 2013 WebViewDemo. All rights reserved.
//

#import "WebViewNavViewController.h"
#import "WebViewViewController.h"
#import "Product.h"

@interface WebViewNavViewController ()
{
    UITableView *searchTableView;
    UISearchDisplayController *displayController;
}
@end

@implementation WebViewNavViewController

@synthesize listContent;
@synthesize filteredListContent;
@synthesize savedSearchTerm;
@synthesize savedScopeButtonIndex;
@synthesize searchWasActive;


#pragma mark -
#pragma mark Added By cclv
- (void)scrollToTop {
	
	[searchTableView setContentOffset:CGPointMake(0, 44.f) animated:YES];
}

- (void)scrollToBottom {
	
	NSUInteger sectionCount = [searchTableView numberOfSections];
	if (sectionCount) {
		
		NSUInteger rowCount = [searchTableView numberOfRowsInSection:0];
		if (rowCount) {
			
			NSUInteger ii[2] = {0, rowCount - 1};
			NSIndexPath* indexPath = [NSIndexPath indexPathWithIndexes:ii length:2];
			[searchTableView scrollToRowAtIndexPath:indexPath
                                   atScrollPosition:UITableViewScrollPositionBottom animated:NO];
		}
	}
}


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
    
    self.title = @"Products";
    
    CGRect frmae = [UIScreen mainScreen].applicationFrame;
	searchTableView = [[UITableView alloc] init];
    searchTableView.frame = CGRectMake(0, 0, 320, frmae.size.height - 44);
    searchTableView.delegate = self;
    searchTableView.dataSource = self;
    [self.view addSubview:searchTableView];
    
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.scopeButtonTitles = [NSArray arrayWithObjects:@"All", @"Device",@"Desktop",@"Portable",nil];
    [searchBar sizeToFit];
    searchBar.delegate = self;
    displayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    displayController.delegate = self;
    displayController.searchResultsDataSource = self;
    displayController.searchResultsDelegate = self;
    
    searchTableView.tableHeaderView = searchBar;
    [searchBar release];
    
    // create a filtered list that will contain products for the search results table.
	self.filteredListContent = [NSMutableArray arrayWithCapacity:[self.listContent count]];
	
	// restore search settings if they were saved in didReceiveMemoryWarning.
    if (self.savedSearchTerm)
	{
        [displayController setActive:self.searchWasActive];
        [displayController.searchBar setSelectedScopeButtonIndex:self.savedScopeButtonIndex];
        [displayController.searchBar setText:savedSearchTerm];
        
        self.savedSearchTerm = nil;
    }
	searchTableView.scrollEnabled = YES;
}

- (void)viewDidAppear:(BOOL)animated {
	
	[self scrollToTop];
}

- (void)viewDidUnload
{
	// Save the state of the search UI so that it can be restored if the view is re-created.
    self.searchWasActive = [displayController isActive];
    self.savedSearchTerm = [displayController.searchBar text];
    self.savedScopeButtonIndex = [displayController.searchBar selectedScopeButtonIndex];
	
	self.filteredListContent = nil;
}


- (void)dealloc
{
	[listContent release];
	[filteredListContent release];
	
	[super dealloc];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    /*
	 If the requesting table view is the search display controller's table view, return the count of the filtered list, otherwise return the count of the main list.
	 */
	if (tableView == displayController.searchResultsTableView)
	{
        return [self.filteredListContent count];
    }
	else
	{
        return [self.listContent count];
    }
    
}

//生成cell或者自定义cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kCellID = @"cellID";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellID] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	
	/*
	 If the requesting table view is the search display controller's table view, configure the cell using the filtered content, otherwise use the main list.
	 */
	Product *product = nil;
	if (tableView == displayController.searchResultsTableView)
	{
        product = [self.filteredListContent objectAtIndex:indexPath.row];
    }
	else
	{
        product = [self.listContent objectAtIndex:indexPath.row];
    }
	
	cell.textLabel.text = product.name;
	return cell;
}

//改变行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WebViewViewController *detailsViewController = [[WebViewViewController alloc] init];
    
	/*
	 If the requesting table view is the search display controller's table view, configure the next view controller using the filtered content, otherwise use the main list.
	 */
	Product *product = nil;
	if (tableView == displayController.searchResultsTableView)
	{
        product = [self.filteredListContent objectAtIndex:indexPath.row];
    }
	else
	{
        product = [self.listContent objectAtIndex:indexPath.row];
    }
	detailsViewController.title = product.name;
    detailsViewController.webUrl = product.url;
    
    [[self navigationController] pushViewController:detailsViewController animated:YES];
    [detailsViewController release];
}

#pragma mark -
#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
	/*
	 Update the filtered array based on the search text and scope.
	 */
	
	[self.filteredListContent removeAllObjects]; // First clear the filtered array.
	
	/*
	 Search the main list for products whose type matches the scope (if selected) and whose name matches searchText; add items that match to the filtered array.
	 */
	for (Product *product in listContent)
	{
		if ([scope isEqualToString:@"All"] || [product.type isEqualToString:scope])
		{
			NSComparisonResult result = [product.name compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
            if (result == NSOrderedSame)
			{
				[self.filteredListContent addObject:product];
            }
		}
	}
}


#pragma mark -
#pragma mark UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:
     [[displayController.searchBar scopeButtonTitles] objectAtIndex:[displayController.searchBar selectedScopeButtonIndex]]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:[displayController.searchBar text] scope:
     [[displayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}
@end
