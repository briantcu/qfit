class UniqueFriendPairs < ActiveRecord::Migration
  def change
    execute('create unique index pair_unique_idx on friends (LEAST(id_one,id_two), GREATEST(id_one,id_two));')
  end
end
