class Category < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: '主菜' },
    { id: 3, name: '副菜' },
    { id: 4, name: '主食' },
    { id: 5, name: '汁物' },
    { id: 6, name: 'デザート' }
  ]
end
