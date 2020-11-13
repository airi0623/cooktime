class Thing < ActiveHash::Base
  self.data = [
    #野菜
      #根菜
    {id: 1, thing_name:'にんじん', spoon:'', unit:'本'},
    {id: 4, thing_name:'大根', spoon:'', unit:'本'},
    {id: 5, thing_name:'じゃがいも', spoon:'', unit:'個'},
      #葉野菜
    {id: 2, thing_name:'ねぎ', spoon:'', unit:'本'},
    {id: 19, thing_name:'ブロッコリー', spoon:'', unit:'g'},
      #果物
    {id: 21, thing_name:'レモン', spoon:'', unit:'個'},
      #その他
    {id: 3, thing_name:'きゅうり', spoon:'', unit:'本'},
    {id: 6, thing_name:'玉ねぎ', spoon:'', unit:'個'},
    {id: 7, thing_name:'茄子', spoon:'', unit:'個'},
    {id: 20, thing_name:'トマト', spoon:'', unit:'個'},
    #調味料
    {id: 8, thing_name:'水', spoon:'', unit:'ml'},
    {id: 9, thing_name:'醤油', spoon:'大さじ', unit:''},
    {id: 10, thing_name:'みりん', spoon:'大さじ', unit:''},
    {id: 16, thing_name:'カレールー', spoon:'', unit:'g'},
    {id: 18, thing_name:'だし', spoon:'小さじ', unit:'g'},
    #豚肉
    {id: 11, thing_name:'豚肉肩ロース', spoon:'', unit:'g'},
    {id: 12, thing_name:'豚肉細切れ', spoon:'', unit:'g'},
    {id: 13, thing_name:'豚肉バラ', spoon:'', unit:'g'},
    #牛肉
    {id: 14, thing_name:'牛肉ブロック', spoon:'', unit:'g'},
    {id: 15, thing_name:'牛肉細切れ', spoon:'', unit:'g'},
    #白身魚
    {id: 17, thing_name:'サーモン', spoon:'', unit:'切'},
    #その他
    {id: 22, thing_name:'豆腐', spoon:'', unit:'切'},
    {id: 23, thing_name:'卵', spoon:'', unit:'個'}
  ]
end
