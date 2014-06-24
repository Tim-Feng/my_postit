class Post < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :votes, as: :voteable

  validates :title, presence: true, length: {minimum: 5}
  validates :description, presence: true
  validates :url, presence: true, uniqueness: true

  before_save :generate_slug

  def total_votes
    up_vote - down_vote
  end

  def up_vote
    self.votes.where(vote: true).size
  end

  def down_vote
    self.votes.where(vote: false).size
  end

  def to_param
    self.slug
  end

  def generate_slug
    the_slug = to_slug(self.title)
    post = Post.find_by slug: the_slug
    if post
      the_slug = the_slug + '-2'
    end
    self.slug = the_slug.downcase
  end

  def to_slug(name)
    str = name.strip
    str.gsub! /\s*[^A-Za-z0-9]\s*/, '-' #將符號轉成"-"
    str.gsub! /-+/, "-" #將多個"-"轉成一個"-"
    str
  end

end