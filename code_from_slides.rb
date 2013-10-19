####################
# Все есть объект
####################
1.class #=> Fixnum
3.14.class #=> Float
'string'.class #=> String
/\Aregexp\Z/.class #=> Regexp
:symbol.class #=> Symbol
[1,2,3].class #=> Array
{'a' => 1, 2 => 'ololo'}.class #=> Hash
{a: 1 b: 2, c: 3}.class #=> Hash


class Integer
  def leap_year?
    (self % 4 == 0 && self % 100 != 0) || self % 400 == 0
  end

  def year
    days = 0
    current_year = Time.now.year
    self.times do |n|
      days += (current_year + n + 1).leap_year? ? 366 : 365
    end

    return 3600 * 24 * days
  end

  alias years year
end

2013.leap_year? #=> false
5.years #=> 157766400
Time.now #=> 2013-10-08 16:03:20 +0300
Time.now.class #=> Time
Time.now + 10.years #=> 2023-10-08 16:03:29 +0300


####################
# Наследование
####################
class User
  def initialize(name, last_name, email)
     @name = name
     @last_name = last_name
     @email = email
  end
end

user = User.new('Bill', 'Clinton', 'bclinton@whitehouse.gov')
user.class #=> User
user.name # raises NoMethodError exception

class President < User
  attr_reader :name, :last_name, :email, :elected_at, :on_period
  def initialize(name, last_name, email, elected_at, on_period)
    super(name, last_name, email)

    @elected_at = elected_at
    @on_period  = on_period
  end
end

President.ancestors #=> => [President, User, Object, Kernel, BasicObject]

president = President.new('Bill', 'Clinton', 'bclinton@whitehouse.gov', Time.new(2001, 1, 10), 4)

president.name #=> 'Bill'


####################
# Модули и примеси
####################
module Singleton
  def self.extended(klass)
    klass.class_eval do
      extend ClassMethods
      include InstanceMethods
    end
  end

  module ClassMethods
    def new(*args)
      @instance = super(*args) unless @instance
      return @instance
    end
  end

  module InstanceMethods
    def singleton?; true end
  end
end

class User
  def initialize(name, last_name)
    @name = name
    @last_name = last_name
  end
end

User.new('Bill', 'Clinton').object_id #=> 7939460
User.new('Bill', 'Clinton').object_id #=> 7874780

User.extend Singleton

User.new('Bill', 'Clinton').object_id #=> 7767300
User.new('Bill', 'Clinton').object_id #=> 7767300


####################
# Блоки кода
####################

def do_something
  yield 100
end

def do_something(&block)
  block.call 100
end

def do_somethind
  yield 100 if block_given?
end

do_something { |n| n.to_s(2) } #=> "1100100"

do_something do |n|
  n ** 2
end
#=> 10000

####################
# Итераторы
####################

[1, 2, 3, 4, 5].inject(0) { |s, n| s += n } #=> 15
[1, 2, 3, 4, 5].select { |n| n % 2 == 0 } #=> [2, 4]

{a: 1, b: 2}.each { |k, v| puts "#{k} -> #{v}" }
# a -> 1
# b -> 2

3.times { |t| puts t }
# 0
# 1
# 2

[2, 4 , 6].all? { |n| n.even? } #=> true



####################
# MODELS
####################

# app/models/user.rb
class User < ActiveRecord::Base
  has_many :articles, foreign_key: :author_id
  has_many :comments, foreign_key: :commenter_id
end
# app/models/article.rb
class Article < ActiveRecord::Base
  belongs_to :author, class_name: 'User'
  has_many :comments, as: :commentable, dependent: :destroy
end
# app/models/comment.rb
class Comment < ActiveRecord::Base
  belongs_to :commenter, class_name: 'User'
  belongs_to :commentable, polymorphic: true
end


class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
end

class ArticlesController < ApplicationController
  # http://localhost:3000/articles
  def index
    @articles = Article.order('published_at DESC').includes(:author)
  end
  # http://localhost:3000/articles/:id
  def show
    @article = Article.find(params[:id])
    @comments = @article.comments
  end


#articles
  - @articles.each do |article|
    .article{id: "article_#{article.id}"}
      .a-title= article.title
      .a-published_at= article.published_at
      .a-content= article.content
      .a-author
         authored by:
         link_to article.author.name, article.author
end



<div id="articles">
    <div class="article" id="article_2">
        <div class="a-title">Article 2 Title</div>
        <div class="a-published-at">2013-09-28</div>
        <div class="a-content">Article 2 Content</div>
        <div class="a-author">
            authored by: <a href="/users/1">Bill Clinton</a>
        </div>
      </div>

      <div class="article", id="article_1">
          <!-- ... -->
      </div>
</div>
