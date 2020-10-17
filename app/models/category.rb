class Category < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: '主菜' },
    { id: 3, name: '副菜' },
    { id: 4, name: '' },
    { id: 5, name: 'インテリア' },
    { id: 6, name: '本・音楽' },
    { id: 7, name: 'おもちゃ' },
    { id: 8, name: '家電・スマホ・カメラ' },
    { id: 9, name: 'ハンドメイド' },
    { id: 10, name: 'その他' }
  ]
end
