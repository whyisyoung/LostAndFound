namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do

    AdminUser.create!(email: "linus@admin.com", password: "linusyoung")


    # Create 100 user, the first is admin.
    User.create!(name: "Admin",
                 email: "example@railstutorial.org",
                 password: "foobar",
                 password_confirmation: "foobar",
                 admin: true)
    99.times do |n|
      name = Faker::Name.first_name
      email = "example-#{n+1}@railstutorial.org"
      password = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end

    # creat some lost items for the first 6 user.
    users = User.all(limit: 6)

    # category 1

    details = ["捡到了一部三星手机，白色",
               "捡到了一个 ipad mini，保护套为黑色",
               "捡到了一部 iphone，黑色，有保护壳",
               "5月12日捡到一个 ipod shuffle，蓝色，无耳机",
               "4月19日捡到一个 mp3, 很小巧精致",
               "3月16日捡到一个收音机，德生的，无耳机",
               "前几天捡到一个 iPad Air, 白色，无保护套",
               "周末捡到一个 U 盘， 8g, Kingston"]
    15.times do
      detail = details.sample
      users.each do |user|
        user.lost_items.create!(lost_time: rand(100.days).ago,
                                detail: detail,
                                place: ["四教", "一教", "二教", "三教", "图书馆", "河西食堂", "河东食堂"].sample,
                                status: ['无人认领', '已认领'].sample,
                                finder: ["李阳", "小林", "小杨", "小方"].sample,
                                phone: ["18817551234", "13713219821", "18612342134", "15921942312"].sample,
                                category_id: 1)
      end
    end

    # category 2

    details = ["捡到校园卡一张，姓名为吴亮，环境科学系",
               "捡到校园卡一张，姓名为李明，化学系",
               "捡到校园卡一张，姓名为乐闻奇，计算机系",
               "捡到校园卡一张，姓名为李磊，物理系",
               "捡到校园卡一张，姓名为陈家乐，统计系",
               "捡到校园卡一张，姓名为吴凡，数学系",
               "捡到校园卡一张，姓名为杨盛，中文系",
               "捡到校园卡一张，姓名为缪佳琪，历史系"]
    15.times do
      detail = details.sample
      users.each do |user|
        user.lost_items.create!(lost_time: rand(100.days).ago,
                                detail: detail,
                                place: ["四教", "一教", "二教", "三教", "图书馆", "河西食堂", "河东食堂"].sample,
                                status: ['无人认领', '已认领'].sample,
                                finder: ["李阳", "小林", "小杨", "小方"].sample,
                                phone: ["18817551234", "13713219821", "18612342134", "15921942312"].sample,
                                category_id: 2)
      end
    end

    # category 3

    details = ["捡到了钱包（内含身份证、银行卡、现金若干），身份证姓名为李阳",
               "5月15日捡到一串钥匙，上面挂有个生肖鸡的平安豆",
               "3月16日捡到一个钱包，内含若干现金",
               "5月13日捡到一串钥匙，上面挂有一个羽毛球模型",
               "前几天捡到一串钥匙，上面挂有火影的鸣人",
               "周末捡到一串钥匙，上挂有一个 U 盘",
               "捡到一个黑色钱包，内含身份证，现金，姓名为袁浩",
               "4月15日捡到一串钥匙，挂有一个小闹钟",
               "捡到身份证一张，姓名为胡洋"]
    15.times do
      detail = details.sample
      users.each do |user|
        user.lost_items.create!(lost_time: rand(100.days).ago,
                                detail: detail,
                                place: ["四教", "一教", "二教", "三教", "图书馆", "河西食堂", "河东食堂"].sample,
                                finder: ["李阳", "小林", "小杨", "小方"].sample,
                                status: ['无人认领', '已认领'].sample,
                                phone: ["18817551234", "13713219821", "18612342134", "15921942312"].sample,
                                category_id: 3)
      end
    end

    # category 4

    details = ["捡到一本书，《时间都去哪儿了》",
               "昨天捡到一本书，《编译原理实践》",
               "周末捡到一本书，《人工智能》",
               "前几日捡到一本书，《算法导论》",
               "在四教3楼捡到一本书，《高效能人士的七个习惯》",
               "捡到一本书，《该怎样读书》",
               "捡到一本书，《大数据时代》",
               "捡到一本书，《c++ primer》",
               "捡到一本书，《世界文明史》"]
    15.times do
      detail = details.sample
      users.each do |user|
        user.lost_items.create!(lost_time: rand(100.days).ago,
                                detail: detail,
                                place: ["四教", "一教", "二教", "三教", "图书馆", "河西食堂", "河东食堂"].sample,
                                status: ['无人认领', '已认领'].sample,
                                finder: ["李阳", "小林", "小杨", "小方"].sample,
                                phone: ["18817551234", "13713219821", "18612342134", "15921942312"].sample,
                                category_id: 4)
      end
    end

    # category 5

    details = ["捡到一件白色衬衫， 蛮干净的",
               "昨天捡到一件 nike 黑色外套",
               "周末捡到一件小背心，目测是刚打完篮球",
               "前几天捡到一件 T 恤，有印花，白色， 印有 I love HK",
               "捡到一件 dickens 线衫，灰色",
               "在河西食堂捡到一条 selected 牛仔裤，深蓝色",
               "捡到一条 nike 运动裤，浅蓝色",
               "捡到一双 nike 运动鞋，白蓝相间"]
    15.times do
      detail = details.sample
      users.each do |user|
        user.lost_items.create!(lost_time: rand(100.days).ago,
                                detail: detail,
                                place: ["四教", "一教", "二教", "三教", "图书馆", "河西食堂", "河东食堂"].sample,
                                status: ['无人认领', '已认领'].sample,
                                finder: ["李阳", "小林", "小杨", "小方"].sample,
                                phone: ["18817551234", "13713219821", "18612342134", "15921942312"].sample,
                                category_id: 5)
      end
    end

    # category 6

    details = ["捡到一把伞，天堂牌子的",
               "昨天在图书馆捡到一把大黑伞",
               "捡到一个笔袋，布的，印有小狗",
               "周末捡到一个水杯，乐扣乐扣的，透明色",
               "在2楼教室捡到一个笔袋， 无印良品的，透明小盒子",
               "前几天捡到一个文件袋，里面有一些打印的论文，目测统计系的",
               "捡到一个充电宝， 充电线不在了， aigo 的",
               "捡到一个记事本，里面记满了编译原理的课堂笔记",
               "捡到一个游戏鼠标，罗技的，蓝色"]
    15.times do
      detail = details.sample
      users.each do |user|
        user.lost_items.create!(lost_time: rand(100.days).ago,
                                detail: detail,
                                place: ["四教", "一教", "二教", "三教", "图书馆", "河西食堂", "河东食堂"].sample,
                                status: ['无人认领', '已认领'].sample,
                                finder: ["李阳", "小林", "小杨", "小方"].sample,
                                phone: ["18817551234", "13713219821", "18612342134", "15921942312"].sample,
                                category_id: 6)
      end
    end




    # 50.times do
    #   detail = Faker::Lorem.sentence(5)
    #   users.each do |user|
    #     user.lost_items.create!(lost_time: DateTime.now,
    #                             detail: detail,
    #                             place:  "Library",
    #                             status: "unclaimed",
    #                             finder: "Lin",
    #                             phone:  "18817551234",
    #                             category_id: Random.new.rand(1..6))
    #   end
    # end

    # Create 6 categories.
    categories = ["electronics", "cards", "belongings", "books", "clothes", "other"]
    categories.each do |category|
      Category.create!(name: category)
    end

  end
end