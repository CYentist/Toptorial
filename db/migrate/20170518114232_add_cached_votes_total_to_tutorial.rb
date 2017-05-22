class AddCachedVotesTotalToTutorial < ActiveRecord::Migration[5.0]
  def self.up
  add_column :tutorials, :cached_votes_total, :integer, :default => 0
  add_column :tutorials, :cached_votes_score, :integer, :default => 0
  add_column :tutorials, :cached_votes_up, :integer, :default => 0
  add_column :tutorials, :cached_votes_down, :integer, :default => 0
  add_index  :tutorials, :cached_votes_total
  add_index  :tutorials, :cached_votes_score
  add_index  :tutorials, :cached_votes_up
  add_index  :tutorials, :cached_votes_down


   Tutorial.find_each(&:update_cached_votes)
  end

  def self.down
  remove_column :tutorials, :cached_votes_total
  remove_column :tutorials, :cached_votes_score
  remove_column :tutorials, :cached_votes_up
  remove_column :tutorials, :cached_votes_down
  end
end
