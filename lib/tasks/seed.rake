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

  POSITIONS = ['Developer', 'Team Leader', 'Manager', 'Engineer', 'Q.A']

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
          position: POSITIONS.sample,
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

  task :seed_positions => :environment do
    1000.times do
      skills = []
      3.times do
        skills << SKILLS.sample
      end
      skills.uniq!
      d = (0..6).to_a.sample.days.ago
      position = Position.new({
                                  company: Forgery(:name).company_name,
                                  position: POSITIONS.sample,
                                  location: Forgery(:address).city,
                                  skills: skills,
                                  created_at: d.to_i
                              })
      position.save
    end
  end
end

namespace :avro do

  task :seed_positions => :environment do
    AvroLogger::Position.log Position.all
  end

end