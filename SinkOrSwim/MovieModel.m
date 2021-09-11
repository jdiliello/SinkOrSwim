//
//  MovieModel.m
//  SinkOrSwim
//
//  Created by Joseph DiLiello on 9/10/21.
//

#import "MovieModel.h"

@interface MovieModel ()
// declare properties
@property (strong, nonatomic) NSMutableArray *movieArray;
@property (strong, nonatomic) NSMutableDictionary *posterDict;
@property (strong, nonatomic) NSString *csvFileString;
@end

@implementation MovieModel

// link the properties to the variables
@synthesize movieDict = _movieDict;
@synthesize genreDict = _genreDict;
@synthesize genreArray = _genreArray;
@synthesize csvFileString = _csvFileString;

+(MovieModel*)sharedInstance{
    static MovieModel* _sharedInstance = nil;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        _sharedInstance = [[MovieModel alloc] init];
    } );
    return _sharedInstance;
}
// hardcoded the CSV file string
// issues loading in the file into a string as a csv
-(NSString*)csvFileString{
    if(!_csvFileString)
        _csvFileString = @"Donnie Darko,2001,113,8,728383,Drama\nLittle Miss Sunshine,2006,101,7.8,431988,Comedy\nThe Man from Earth,2007,87,7.9,170744,Drama\nDeadpool,2016,108,8,882037,Action\nThe Help,2011,146,8,419566,Drama\nMoonrise Kingdom,2012,94,7.8,311669,Comedy\nGuardians of the Galaxy,2014,121,8,1023350,Action\nWheels,2014,115,8.8,17814,Drama\nGone Girl,2014,149,8.1,833485,Drama\nShort Term 12,2013,96,8,79731,Drama\nStar Wars The Force Awakens,2015,138,7.9,845102,Action\nWhiplash,2014,106,8.5,690732,Drama\nThor Ragnarok,2017,130,7.9,564511,Action\nRogue One,2016,133,7.8,538641,Action\nManchester by the Sea,2016,137,7.8,238464,Drama\nAvengers Infinity War,2018,149,8.4,796486,Action\nTogo,2019,113,8,30833,Adventure";
    return _csvFileString;
}

-(NSMutableDictionary*)movieDict{
    NSLog(@"Init movie dict");
    if (!_movieDict)
        NSLog(@"filling out movie dict");
        _movieDict = [[NSMutableDictionary alloc] init];
        NSString* fileContents = self.csvFileString;
        NSLog(@"%@", fileContents);
        NSArray* rows = [fileContents componentsSeparatedByString:@"\n"];
        NSLog(@"ROWS");
        NSLog(@"%@", rows);
        for (NSString *row in rows){
            NSArray* columns = [row componentsSeparatedByString:@","];
            NSLog(@"%@", columns);
            NSMutableDictionary* _titleDict = [[NSMutableDictionary alloc] init];
            [_titleDict setObject:columns[1] forKey:@"year"];
            [_titleDict setObject:columns[2] forKey:@"duration"];
            [_titleDict setObject:columns[3] forKey:@"rating"];
            [_titleDict setObject:columns[4] forKey:@"votes"];
            [_titleDict setObject:columns[5] forKey:@"genre"];
            [_titleDict setObject:[UIImage imageNamed:columns[0]] forKey:@"poster"];
            [_movieDict setObject:_titleDict forKey:columns[0]];
        }
        NSLog(@"Finsihed making movie dict");
    return _movieDict;
}

-(NSArray*)genreArray{
    if(!_genreArray)
        NSLog(@"Making genre array");
        NSMutableArray* tempArray = [[NSMutableArray alloc] init];
        for (id key in self.movieDict){
            [tempArray addObject:self.movieDict[key][@"genre"]];
        }
        NSArray *_genreArray = [[NSOrderedSet orderedSetWithArray:tempArray] array];
        NSLog(@"Finsihed making genre array");
    return _genreArray;
}

-(NSMutableArray*)movieArray{
    if(!_movieArray)
        _movieArray = [[NSMutableArray alloc] init];
        for (id key in self.movieDict){
            [_movieArray addObject:key];
        }
    return _movieArray;
}

-(NSMutableDictionary*)genreDict{
    if(!_genreDict){
        NSLog(@"Making genre dict");
        _genreDict = [[NSMutableDictionary alloc] init];
        NSMutableArray* genreArray = [[NSMutableArray alloc] init];
        for (id key in self.movieDict){
            [genreArray addObject:self.movieDict[key][@"genre"]];
        }
        NSLog(@"Got unique genres");
        NSArray *uniqueArray = [[NSOrderedSet orderedSetWithArray:genreArray] array];
        for (NSString *genre in uniqueArray){
            NSMutableArray *titles = [[NSMutableArray alloc] init];
            for (id key in self.movieDict){
                if(genre == self.movieDict[key][@"genre"]){
                    [titles addObject:key];
                }
            }
            [_genreDict setObject:titles forKey:genre];
        }
        NSLog(@"Made genre dict");
    }
    return _genreDict;
}

-(NSArray*)getUniqueGenres{
    NSMutableArray* genreArray = [[NSMutableArray alloc] init];
    for (id key in self.movieDict){
        [genreArray addObject:self.movieDict[key][@"genre"]];
    }
    NSArray *uniqueArray = [[NSOrderedSet orderedSetWithArray:genreArray] array];
    return uniqueArray;
}

-(NSInteger)numberOfMovies{
    return [self.movieDict count];
}

-(NSInteger)numberInGenre:(NSString*)genre{
    return [self.genreDict[genre] count];
}

-(NSArray*)getTiltlesInGenre:(NSString*)genre{
    return self.genreDict[genre];
}

// return the image from the name
-(UIImage*)getPosterWithTitle:(NSString*)title{
    return self.movieDict[title][@"poster"];
}

-(NSString*)getNameUsingIndex:(NSInteger)index{
    return self.movieArray[index];
}

@end
