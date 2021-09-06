//
//  ImageModel.m
//  SinkOrSwim
//
//  Created by Joseph DiLiello on 9/6/21.
//

#import "ImageModel.h"

@interface ImageModel ()
// declare properties
@property (strong, nonatomic) NSArray *imageNameArray;
@property (strong, nonatomic) NSMutableDictionary *imageDict;
@end

@implementation ImageModel

// link the properties to the variables
@synthesize imageDict = _imageDict;
@synthesize imageNameArray = _imageNameArray;

+(ImageModel*)sharedInstance{
    static ImageModel* _sharedInstance = nil;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        _sharedInstance = [[ImageModel alloc] init];
    } );
    return _sharedInstance;
}

// create an array that is lazily instantiated
// that holds the names of the images we are loading
// (this is the only part of the code that is hard coded
-(NSArray*)imageNameArray{
    if(!_imageNameArray)
        _imageNameArray = @[@"Bird", @"Starry Night", @"Mercury", @"Tires", @"Saturn"];
    return _imageNameArray;
}

// create a lazy dict from the imageNameArray
// takes each name from imageNameArray as the key
// then stores the UIImage object with that name
// as the value in the dictionary
-(NSMutableDictionary*)imageDict{
    if (!_imageDict)
        _imageDict = [[NSMutableDictionary alloc] init];
        for (id name in self.imageNameArray){
            [_imageDict setObject:[UIImage imageNamed:name] forKey:name];
        };
    return _imageDict;
}

-(NSArray*)getArrayOfImageNames{
    return self.imageNameArray;
}

// return the image from the name
-(UIImage*)getImageWithName:(NSString*)name{
    return self.imageDict[name];
}

// get the name by index from the name array
// then return the image using the name
-(UIImage*)getImageWithIndex:(NSInteger)index{
    return self.imageDict[self.imageNameArray[index]];
}

// return the count of keys in imageDict
-(NSInteger)numberOfImages{
    return [self.imageDict count];
}

// return the image name from the index
-(NSString*)getImageNameByIndex:(NSInteger)index;{
    return self.imageNameArray[index];
}

@end
