namespace :db do

  SKILLS = [
      'Big Data',
      'MongoDB',
      'Cassandra',
      'Apache Hive',
      'Pig Latin',
      'Riak',
      'Hadoop',
      'Java',
      'Ruby',
      'Redis',
      'MySQL',
      'Postgresql',
      'AWS'
  ]

  task :seed_users => :environment do

    1000.times do

      skills = []
      3.times do
        skills << SKILLS.sample
      end
      skills.uniq!

      employment = Employment.new({
          name: Forgery(:name).company_name,
          started_at: Date.today - [1,2,3,4].sample.year,
          finished_at: Date.today,
          position: ['Developer', 'Team Leader', 'Manager', 'Engineer', 'Q.A'].sample,
          job_description: Forgery(:internet).email_subject
      })

      user = User.new({
        firstname: Forgery(:name).first_name,
        lastname: Forgery(:name).last_name,
        email: Forgery(:email).address,
        friends: [],
        skills: skills,
        address: {
          city: Forgery(:address).city,
          country: Forgery(:address).country,
        }
      })
      user.employments.push employment

      user.save
    end

  end

  task :seed_user_friends => :environment do
    users = User.all
    ids = users.map(&:_id)
    users.each do |user|
      friends = []
      4.times do
        friends << Moped::BSON::ObjectId(ids.sample)
      end
      friends.uniq!
      friends.delete user.id.to_s
      user.update_attributes friends: friends
    end
  end
end