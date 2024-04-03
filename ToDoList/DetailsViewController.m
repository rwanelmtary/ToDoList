//
//  DetailsViewController.m
//  ToDoList
//
//  Created by rwan elmtary on 02/04/2024.
//

#import "DetailsViewController.h"
#import "Model.h"


@interface DetailsViewController ()

@end

@implementation DetailsViewController
- (instancetype)init{
    _modelObject = [Model new];
    return self;
    }

- (void)viewDidLoad {
    [super viewDidLoad];
    self.details_Name.text = self.modelObject.name;
    self.details_Desc.text = self.modelObject.desc;
    self.currentTime.text = self.modelObject.time;
    self.details_piriority .selectedSegmentIndex = self.modelObject.pir;
    
}
- (IBAction)filterTask:(id)sender {
    
    
    
    NSDictionary *dict = @{
        @"name" : self.details_Name.text,
        @"desc" : self.details_Desc.text,
        @"pir"  : @(self.details_piriority.selectedSegmentIndex)
    };
    
    _progresArr =[[[NSUserDefaults standardUserDefaults]objectForKey:@"progress"]mutableCopy];
    _doneArr =[[[NSUserDefaults standardUserDefaults]objectForKey:@"done"]mutableCopy];
    
    if (!_progresArr) {
        _progresArr = [NSMutableArray array];
    }
    
    [_progresArr addObject:dict];
    
    [[NSUserDefaults standardUserDefaults]setObject:_progresArr forKey:@"progress"];
    
    if (!_doneArr) {
        _doneArr = [NSMutableArray array];
    }
    
    [_doneArr addObject:dict];
    
    [[NSUserDefaults standardUserDefaults]setObject:_doneArr forKey:@"done"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
