module CategoriesHelper

  def to_chinese(name)
    case name
    when "electronics"
      "手机数码"
    when "cards"
      "校园卡"
    when "belongings"
      "随身物品"
    when "books"
      "书籍资料"
    when "clothes"
      "衣物饰品"
    else
      "其他物品"
    end
  end

end
