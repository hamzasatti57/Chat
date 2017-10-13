class Search < ApplicationRecord

def self.search(name)
  if name
    where('name LIKE ?', "%#{name}%").order('id DESC')
  else
    order('id DESC') 
  end
end

end
