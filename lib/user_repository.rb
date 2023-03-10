require_relative './user'

class UserRepository
  def all
    sql = 'SELECT id, email, username FROM users;'
    result_set = DatabaseConnection.exec_params(sql, [])

    users = []

    result_set.each{
      |result|
      user = User.new
      user.id = result['id']
      user.email = result['email']
      user.username = result['username']
      users << user
    }
      return users
  end

  def find(id)
    sql = 'SELECT id, email, username FROM users WHERE id = $1;'
    sql_params = [id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)
    result = result_set[0]
    user = User.new
    user.id = result['id']
    user.email = result['email']
    user.username = result['username']
    return user
  end

  def create(user)
    sql = 'INSERT INTO users (email, username) VALUES($1, $2)'
    sql_params = [user.email, user.username]
    DatabaseConnection.exec_params(sql, sql_params)
  end

  def delete(id)
    sql = 'DELETE FROM users WHERE id = $1'
    sql_params = [id]
    DatabaseConnection.exec_params(sql, sql_params)
  end

end