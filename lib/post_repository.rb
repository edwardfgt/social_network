require_relative './post.rb'

class PostRepository
  def all
    sql = 'SELECT id, content, views, user_id FROM posts;'
    result_set = DatabaseConnection.exec_params(sql, [])

    posts = []

    result_set.each{
      |result|
      post = Post.new
      post.id = result['id']
      post.content = result['content']
      post.views = result['views']
      post.user_id = result['user_id']
      posts << post
    }
    
    return posts
  end

  def find(id)
    sql = 'SELECT id, content, views, user_id FROM posts WHERE id = $1;'
    sql_params = [id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)
    result = result_set[0]
    post = Post.new
    post.id = result['id']
    post.content = result['content']
    post.views = result['views']
    post.user_id = result['user_id']
    return post
  end

  def create(post)
    sql = 'INSERT INTO posts (content, views, user_id) VALUES ($1, $2, $3)'
    sql_params = [post.content, post.views, post.user_id]
    DatabaseConnection.exec_params(sql, sql_params)
  end

  def delete(id)
    sql = 'DELETE FROM posts WHERE id = $1'
    sql_params = [id]
    DatabaseConnection.exec_params(sql, sql_params)
  end  
end