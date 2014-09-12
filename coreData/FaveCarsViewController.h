//
//  FaveCarsViewController.h
//  coreData
//
//  Created by Marcelo Sampaio on 9/12/14.
//  Copyright (c) 2014 Marcelo Sampaio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FaveCarsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *textFieldMake;
@property (weak, nonatomic) IBOutlet UITextField *textFieldModel;
@property (weak, nonatomic) IBOutlet UITextField *textFieldColor;

@property (strong) NSManagedObject *car;

@end
