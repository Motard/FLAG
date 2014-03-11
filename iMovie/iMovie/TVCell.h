//
//  TVCell.h
//  iMovie
//
//  Created by Formando FLAG on 11/03/14.
//  Copyright (c) 2014 Paulo Martins. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TVCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nomeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *imagemView;

@property (nonatomic) NSURLSessionDataTask *imagemDownloadTask;

@end
