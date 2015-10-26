//
//  Define.h
//  lookTheWorld
//
//  Created by qianfeng001 on 15/9/16.
//  Copyright (c) 2015年 苗军艳. All rights reserved.
//

#ifndef lookTheWorld_Define_h
#define lookTheWorld_Define_h

#define kScreenSize   [UIScreen mainScreen].bounds.size
#define kScreenWidth  kScreenSize.width
#define kScreenHeight kScreenSize.height

 //资讯
//http://ktx.cms.palmtrends.com/api_v2.php?action=home_list&offset=0&count=15&uid=13957812&pid=10053&platform=a&mobile=HM+NOTE+1LTE&e=311510c836281462c0873c230f8d3017
//资讯接口
#define kInformation @"http:ktx.cms.palmtrends.com/api_v2.php?action=home_list&offset=%ld&count=16&uid=13957812&pid=10053&platform=a&mobile=HM+NOTE+1LTE&e=311510c836281462c0873c230f8d3017"
//微言
//http://ktx.cms.palmtrends.com/api_v2.php?action=get_mags_list&offset=0&count=15&uid=13957812&pid=10053&platform=a&mobile=HM+NOTE+1LTE&e=311510c836281462c0873c230f8d3017
// 微言
#define kRespectable @"http://ktx.cms.palmtrends.com/api_v2.php?action=get_mags_list&offset=%ld&count=15&uid=13957812&pid=10053&platform=a&mobile=HM+NOTE+1LTE&e=311510c836281462c0873c230f8d3017"

//// 杂志的转换
//http://ktx.cms.palmtrends.com/api_v2.php?action=get_cats&offset=0&count=16&uid=13957812&pid=10053&platform=a&mobile=HM+NOTE+1LTE&e=311510c836281462c0873c230f8d3017
//杂志接口
#define kMagazine @"http://ktx.cms.palmtrends.com/api_v2.php?action=get_cats&offset=0&count=16&uid=13957812&pid=10053&platform=a&mobile=HM+NOTE+1LTE&e=311510c836281462c0873c230f8d3017"
//酷图
//http://ktx.cms.palmtrends.com/api_v2.php?action=piclist&sa=kutu&uid=13957812&pid=10053&platform=a&mobile=android&offset=0&count=15
// 酷图接口
#define kPicture @"http://ktx.cms.palmtrends.com/api_v2.php?action=piclist&sa=kutu&uid=13957812&pid=10053&platform=a&mobile=android&offset=%ld&count=15"
//杂志转口
#define kMagazineTo @"http://ktx.cms.palmtrends.com/api_v2.php?action=get_article_list_by_cat&cat_id=%ld&offset=0&count=15&uid=13957812&pid=10053&platform=a&mobile=HM+NOTE+1LTE&e=311510c836281462c0873c230f8d3017"
//http://ktx.cms.palmtrends.com/api_v2.php?action=get_article_list_by_cat&cat_id=10&offset=0&count=15&uid=13957812&pid=10053&platform=a&mobile=HM+NOTE+1LTE&e=311510c836281462c0873c230f8d3017
//资讯 杂志详情

#define kDetailUrl @"http://ktx.cms.palmtrends.com/api_v2.php?action=article&mobile=android&id=%d&fontsize=b&uid=13957812&pid=10053&platform=a&mobile=HM+NOTE+1LTE&e=311510c836281462c0873c230f8d3017"
//http://ktx.cms.palmtrends.com/api_v2.php?action=get_mags_list&offset=%ld&count=15&uid=13957812&pid=10053&platform=a&mobile=HM+NOTE+1LTE&e=311510c836281462c0873c230f8d3017

//http://ktx.cms.palmtrends.com/api_v2.php?action=article&mobile=android&id=5401&fontsize=b&uid=13957812&e=311510c836281462c0873c230f8d3017&platform=a&pid=10053&mobile=HM%2BNOTE%2B1LTE
//酷图 详情
//http://ktx.cms.palmtrends.com/api_v2.php?action=picture&mobile=android&gid=5481&uid=13957812&pid=10053&platform=a&mobile=HM+NOTE+1LTE&e=311510c836281462c0873c230f8d3017
#define kKuToDetail @"http://ktx.cms.palmtrends.com/api_v2.php?action=picture&mobile=android&gid=%@&uid=13957812&pid=10053&platform=a&mobile=HM+NOTE+1LTE&e=311510c836281462c0873c230f8d3017"
#endif
