//
//  MovieModel.h
//  SinkOrSwim
//
//  Created by Joseph DiLiello on 9/10/21.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MovieModel : NSObject

+(MovieModel*)sharedInstance;

-(NSArray*)getUniqueGenres;
-(NSInteger)numberOfMovies;
-(NSInteger)numberInGenre:(NSString*)genre;
-(NSArray*)getTiltlesInGenre:(NSString*)genre;
-(UIImage*)getPosterWithTitle:(NSString*)title;
-(NSString*)getNameUsingIndex:(NSInteger)index;

@property (strong, nonatomic) NSMutableDictionary *movieDict;
@property (strong, nonatomic) NSMutableDictionary *genreDict;
@property (strong, nonatomic) NSMutableArray *genreArray;

@end

NS_ASSUME_NONNULL_END
