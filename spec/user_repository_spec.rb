require "user_repository"

def reset_users_table
  seed_sql = File.read('spec/seeds_users.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end
describe UserRepository do
  before(:each) do 
    reset_users_table
  end
   it "returns all users" do
    repo = UserRepository.new
    users = repo.all
    expect(users.length).to eq 3
    expect(users[0].id).to eq "1"
    expect(users[0].username).to eq "Edward"
    expect(users[0].email).to eq "edward@makers.com" 
    expect(users[1].id).to eq "2"
    expect(users[1].username).to eq "Luke"
    expect(users[1].email).to eq "luke@makers.com"
  end

  it "returns an individual user from the database" do
    repo = UserRepository.new
    user = repo.find(1)
    expect(user.id).to eq "1"
    expect(user.username).to eq "Edward" 
    expect(user.email).to eq "edward@makers.com" 
  end

  it "creates a new user in the database based on user input" do
    repo = UserRepository.new
    user = User.new
    user.email = "paul@gmail.com"
    user.username = "Paul"
    repo.create(user)
    all_users = repo.all
    expect(all_users).to include(
      have_attributes(
        email: "paul@gmail.com",
        username: "Paul"
      )
    )

  end
end