//
//  ViewController.m
//  ToDoList
//
//  Created by rwan elmtary on 02/04/2024.
//

#import "ViewController.h"
#import "Model.h"
#import "AddingViewController.h"
#import "DetailsViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *myTable;
@property NSMutableArray *filterd;
@property  NSInteger selectedSegmentIndex;
@property (weak, nonatomic) IBOutlet UISearchBar *search;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *savedTasks = [[NSUserDefaults standardUserDefaults] objectForKey:@"tasks"];
        _data = [NSMutableArray array];
        for (NSDictionary *taskDict in savedTasks) {
            Model *model = [[Model alloc] init];
            model.name = taskDict[@"name"];
            model.desc = taskDict[@"desc"];
            model.time = taskDict[@"time"];
            model.pir = [taskDict[@"pir"] integerValue];
            [_data addObject:model];
            
            self.filterd = [NSMutableArray arrayWithArray:_data];
            self.selectedSegmentIndex = UISegmentedControlNoSegment;
        }
        
    self.myTable.delegate = self;
       self.myTable.dataSource = self;
   // _data = [NSMutableArray new];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _filterd.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
    //Model *model = _data[indexPath.row];
    Model *model = _filterd[indexPath.row];

//    cell.textLabel.text = [[_data objectAtIndex:indexPath.row]name];
    cell.textLabel.text = model.name;


    return cell;
}

- (IBAction)addTask:(id)sender {
    AddingViewController *adding  = [self.storyboard instantiateViewControllerWithIdentifier:@"AddingViewController"];
    [self presentViewController:adding animated:YES completion:nil];
    adding.p = self;
    
}
- (void)reload:(Model *)m{
    [_data addObject:m];
  
    [self updateFilteredData];
    [self.myTable reloadData];
}
-(void)updateFilteredData {
    if (self.selectedSegmentIndex == 3) {
        self.filterd = [NSMutableArray arrayWithArray:_data]; // Show all tasks
    } else if (self.selectedSegmentIndex != UISegmentedControlNoSegment) {
        self.filterd = [NSMutableArray array];
        for (Model *task in _data) {
            if (task.pir == self.selectedSegmentIndex) {
                [self.filterd addObject:task];
            }
        }
    } else {
        self.filterd = [NSMutableArray arrayWithArray:_data];
    }
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailsViewController *details = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsViewController"];
    [details setModelObject:[_data objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:details animated:YES];


}
- (IBAction)filterPirority:(id)sender {
    self.selectedSegmentIndex = [sender selectedSegmentIndex];
    [self updateFilteredData];
       [self.myTable reloadData];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length == 0) {
        [self updateFilteredData]; // Reload all tasks
    } else {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name CONTAINS[cd] %@", searchText];
        NSArray *filteredTasks = [_data filteredArrayUsingPredicate:predicate];
        
        self.filterd = [NSMutableArray arrayWithArray:filteredTasks];
        [self.myTable reloadData]; // Reload the table view with filtered tasks
    }
}
- (void)viewWillAppear:(BOOL)animated
{
    [_myTable reloadData];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSDictionary *deletedTask;
        deletedTask = [
        self
        .filterd objectAtIndex:indexPath.row];
         if (indexPath.row < self.filterd.count) {
            deletedTask = [self.filterd objectAtIndex:indexPath.row];
            [self.filterd removeObjectAtIndex:indexPath.row];
        }
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        // Update tasks in UserDefaults
        [self updateTasksInUserDefaults];
    }
}

//- (void)updateTasksInUserDefaults {
//    // Update tasks in UserDefaults
//    NSArray *tasksArray = [NSArray arrayWithArray:self.data];
//    [[NSUserDefaults standardUserDefaults] setObject:tasksArray forKey:@"tasks"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}
- (void)updateTasksInUserDefaults {
    NSMutableArray *tasksArray = [NSMutableArray array];
    for (Model *task in self.data) {
        NSDictionary *taskDict = @{
            @"name": task.name,
            @"desc": task.desc,
            @"time": task.time,
            @"pir": @(task.pir)
        };
        [tasksArray addObject:taskDict];
    }
    [[NSUserDefaults standardUserDefaults] setObject:tasksArray forKey:@"tasks"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}




@end
		
