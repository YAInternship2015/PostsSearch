//
//  ILTInstagramsPostes.m
//  PostesMarked
//
//  Created by Konstantin Kolontay on 10/7/15.
//  Copyright © 2015 Konstantin Kolontay. All rights reserved.
//

#import "ILTInstagramPoste.h"

@implementation ILTInstagramPoste

#pragma mark - get image

#warning я кажется уже писал Вам, что в именах геттеров не используется "get"
- (UIImage *)getImage {
#warning Вы наверное сами заметили, что приложение "подлагивает" при скролле таблицы. Это происходит из-за того, что вызов dataWithContentsOfURL: синхронный, то есть он блокирует вызывающий его поток, пока не загрузятся данные. В данном случае грузить картинки из сети нужно асинхронно, этот вопрос очень широко обсужден в интернете, кое-что можно почитать тут http://natashatherobot.com/ios-how-to-download-images-asynchronously-make-uitableview-scroll-fast/ . Вообще рекомендую Вам использовать https://github.com/rs/SDWebImage , библиотека очень проста в испольщовании + она кеширует данные
    return  [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.imageURLString]]];
}

#pragma mark - fill data

#warning updateWithDataDictionary:
- (void)fillData:(NSDictionary *)dictionary {
    self.postID = [dictionary objectForKey:@"id"];
    self.commentText = [dictionary valueForKeyPath:@"caption.text"];
    self.imageURLString = [dictionary valueForKeyPath:@"images.low_resolution.url"];
}
@end
