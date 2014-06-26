# Using Concern

module Voteable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :voteable
  end

  def total_votes
    up_vote - down_vote
  end

  def up_vote
    self.votes.where(vote: true).size
  end

  def down_vote
    self.votes.where(vote: false).size
  end

end

# Using normal metaprograming
=begin
module Voteable
  def self.included(base)
    base.send(:include, InstanceMethods)
    base.extend ClassMethods
    base.class_eval do
      my_class_method
    end
  end

  module InstanceMethods
    def total_votes
      up_vote - down_vote
    end

    def up_vote
      self.votes.where(vote: true).size
    end

    def down_vote
      self.votes.where(vote: false).size
    end
  end

  module ClassMethods
    def my_class_method
      has_many :votes, as: :voteable
    end
  end

end
=end