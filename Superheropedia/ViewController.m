//
//  ViewController.m
//  Superheropedia
//
//  Created by Shannon Beck on 1/19/15.
//  Copyright (c) 2015 Shannon Beck. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property NSArray *heroesArray;
@property (strong, nonatomic) IBOutlet UITableView *heroesTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.heroesArray = @[@{@"name":@"Iron Man", @"age":@32},
//                         @{@"name":@"Dr. Strange", @"age":@45},
//                         @{@"name":@"Spiderman", @"age":@21},
//                         @{@"name":@"Superman", @"age":@31},
//                         @{@"name":@"Wolverine", @"age":@122}];

    NSURL *url = [NSURL URLWithString:@"https://s3.amazonaws.com/mobile-makers-lib/superheroes.json"];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];

    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^
     (NSURLResponse *response, NSData *data, NSError *connectionError)
    {
        self.heroesArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        [self.heroesTableView reloadData];
    }];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.heroesArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];


    NSDictionary *superhero = [self.heroesArray objectAtIndex:indexPath.row];

    NSURL *imageURL = [NSURL URLWithString:superhero[@"avatar_url"]];

    cell.textLabel.text = superhero[@"name"];
    cell.detailTextLabel.text = superhero[@"description"];
    cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageURL]];
    cell.detailTextLabel.numberOfLines = 3;

    return cell;
}


@end
