require 'post_repository'

def reset_posts_table
  seed_sql = File.read('spec/seeds_users.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end
describe PostRepository do
  before(:each) do 
    reset_posts_table
  end

  it "returns all posts" do
    repo = PostRepository.new
    users = repo.all
    expect(users.length).to eq 1
    expect(users[0].id).to eq "1"
    expect(users[0].content).to eq "Hello world"
    expect(users[0].views).to eq "2000"
    expect(users[0].user_id).to eq "2"
  end

  it "returns an individual post from the database" do
    repo = PostRepository.new
    post = repo.find(1)
    expect(post.id).to eq "1"
    expect(post.content).to eq "Hello world" 
    expect(post.views).to eq "2000" 
  end

  it "creates a new post in the database based on user input" do
    repo = PostRepository.new
    post = Post.new
    post.content = "Hello tutor"
    post.views = 1000
    post.user_id = 2
    repo.create(post)
    all_users = repo.all
    expect(all_users).to include(
      have_attributes(
        content: "Hello tutor",
        views: "1000",
        user_id: "2"
      )
    )
  end

  it "deletes a specified user from the database" do
    repo = PostRepository.new
    repo.delete(1)
    all_users = repo.all
    expect(all_users.size).to eq 0
  end
end