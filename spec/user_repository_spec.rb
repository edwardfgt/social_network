def reset_users_table
  seed_sql = File.read('spec/seeds_users.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end
describe StudentRepository do
  before(:each) do 
    reset_users_table
  end
  
  


end