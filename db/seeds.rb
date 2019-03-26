# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# require 'securerandom'

puts "Cleaning up DB..."

Project.destroy_all
Skill.destroy_all
Developer.destroy_all
User.destroy_all
Booking.destroy_all

puts "Creating skills..."

skills = [ "ruby", "ruby on rails", "javascript", "react",
  "vue", "python", "c", "clojure", "objective-c", "c++",
  "c#", "node.js", "php",
  "java", "kotlin", "html", "css", "laravel", "go", "r",
  "typescript", "coffeescript", "elixir", "phoenix", "sql", "erlang", "sass", "angular",
  "backbone", "ember", "expressjs", "knockoutjs", "meteor",
  "django", "haskell", "scala", "swift", "crystal", "drupal", "symfony", "sinatra" ]

skills.each { |skill| Skill.create!(name: skill) }
puts ""
puts "Created #{Skill.count} skills!"
puts ""

puts "Creating users ..."
puts ""

user1 = User.create!(email: "dev@dev.dev", password: "password")
user2 = User.create!(email: "de@de.de", password: "password")

puts "Creating devs..."

torvalds = Developer.new(
  first_name: "Linus",
  last_name: "Torvalds",
  github_username: "torvalds",
  avatar_url: "https://avatars0.githubusercontent.com/u/1024025?v=4",
  hourly_rate: 450,
  user_id: User.all.sample.id,
  bio: "Linus Benedict Torvalds is a Finnish–American software engineer who is the creator, and historically, the principal developer of the Linux kernel, which became the kernel for many Linux distributions and operating systems such as Android and Chrome OS. He also created the distributed version control system Git and the diving logging and planning software Subsurface. He was honoured, along with Shinya Yamanaka, with the 2012 Millennium Technology Prize by the Technology Academy Finland \"in recognition of his creation of a new open source operating system for computers leading to the widely used Linux kernel\". He is also the recipient of the 2014 IEEE Computer Society Computer Pioneer Award and the 2018 IEEE Masaru Ibuka Consumer Electronics Award."
  )
%w(c c++).each do |s|
  torvalds.skills << Skill.find_by_name(s)
end
torvalds.save!

wharton = Developer.new(
  first_name: "Jake",
  last_name: "Wharton",
  github_username: "jakewharton",
  avatar_url: "https://avatars0.githubusercontent.com/u/66577?s=400&v=4",
  hourly_rate: 350,
  user_id: User.all.sample.id,
  bio: "Programmer. Web developer. Open source practitioner and contributor. Android enthusiast."
)
%w(kotlin java html javascript css).each do |s|
  wharton.skills << Skill.find_by_name(s)
end
wharton.save!

evan = Developer.new(
  first_name: "Evan",
  last_name: "You",
  github_username: "yyx990803",
  avatar_url: "https://avatars3.githubusercontent.com/u/499550?s=400&v=4",
  hourly_rate: 420,
  user_id: User.all.sample.id,
  bio: "Design. Hack. Imagine. Front-end engineering, UI/UX & creative coding."
)
%w(javascript vue html css php python).each do |s|
  evan.skills << Skill.find_by_name(s)
end
evan.save!

tj = Developer.new(
  first_name: "TJ",
  last_name: " Holowaychuk",
  github_username: "tj",
  avatar_url: "https://avatars2.githubusercontent.com/u/25254?s=400&v=4",
  hourly_rate: 390,
  user_id: User.all.sample.id,
  bio: "Founder of Apex\r\nhttps://apex.sh, a non-startup.\r\nmedium.com/@tjholowaychuk • twitter.com/tjholowaychuk • tjholowaychuk.com"
)
%w(javascript go html).each do |s|
  tj.skills << Skill.find_by_name(s)
end
tj.save!

sindresorhus = Developer.new(
  first_name: "Sindre",
  last_name: " Sorhus",
  github_username: "sindresorhus",
  avatar_url: "https://avatars3.githubusercontent.com/u/170270?s=400&v=4",
  hourly_rate: 380,
  user_id: User.all.sample.id,
  bio: "Maker · Full-Time Open-Sourcerer · Into Swift and Node.js"
)
%w(javascript swift node.js typescript css html).each do |s|
  sindresorhus.skills << Skill.find_by_name(s)
end
sindresorhus.save!

defunkt = Developer.new(
  first_name: "Chris",
  last_name: " Wanstrath",
  github_username: "defunkt",
  avatar_url: "https://avatars2.githubusercontent.com/u/2?s=400&v=4",
  hourly_rate: 320,
  user_id: User.all.sample.id,
  bio: "Chris Wanstrath is an American technology entrepreneur. He is the co-founder and CEO of GitHub, a social network centred around software development, which he created with Tom Preston-Werner in 2008. Before starting GitHub, he worked with CNET on GameSpot. According to Forbes, his net worth is estimated to be $1.4 billion and he is listed in Forbes Magazine in America's richest entrepreneurs under 40, as well as Fortune Magazine's 40 under 40. He was one of the key speakers at NASA's open source summit. He was named in CNBC's Disruptor 50 list."
)
%w(ruby javascript coffeescript python c).each do |s|
  defunkt.skills << Skill.find_by_name(s)
end
defunkt.save!

getify = Developer.new(
  first_name: "Kyle",
  last_name: " Simpson",
  github_username: "getify",
  avatar_url: "https://avatars0.githubusercontent.com/u/150330?s=400&v=4",
  hourly_rate: 370,
  user_id: User.all.sample.id,
  bio: "Kyle Simpson is an evangelist of the open web, passionate about all things JavaScript. He writes books, teaches JavaScript, speaks, and contributes to the world of OSS."
)
%w(javascript).each do |s|
  getify.skills << Skill.find_by_name(s)
end
getify.save!

jlord = Developer.new(
  first_name: "Jessica",
  last_name: " Lord",
  github_username: "jlord",
  avatar_url: "https://avatars0.githubusercontent.com/u/1305617?s=400&v=4",
  hourly_rate: 260,
  user_id: User.all.sample.id,
  bio: "Jessica is an urban designer turned open web developer—which isn't as odd as it sounds. She's a backend engineer at Splice. Before that she worked on a bunch of things at GitHub, last was starting the Electron team. The year that changed everything was being a Code for America fellow in 2012. She did the fellowship after working at the City of Boston's Urban Design Technology group and an architecture firm. Before that she was in college, Georgia Tech, graduating with an architecture degree."
)
%w(javascript css html node.js).each do |s|
  jlord.skills << Skill.find_by_name(s)
end
jlord.save!

grider = Developer.new(
  first_name: "Stephen",
  last_name: " Grider",
  github_username: "stephengrider",
  avatar_url: "https://avatars3.githubusercontent.com/u/5003903?s=400&v=4",
  hourly_rate: 320,
  user_id: User.all.sample.id,
  bio: "Stephen Grider has been building complex Javascript front ends for top corporations in the San Francisco Bay Area. With an innate ability to simplify complex topics, Stephen has been mentoring engineers beginning their careers in software development for years, and has now expanded that experience onto Udemy, authoring the highest rated React course. He teaches on Udemy to share the knowledge he has gained with other software engineers. Invest in yourself by learning from Stephen's published courses."
)
%w(javascript css html elixir react node.js vue).each do |s|
  grider.skills << Skill.find_by_name(s)
end
grider.save!

dhh = Developer.new(
  first_name: "David",
  last_name: "Heinemeier Hansson",
  github_username: "dhh",
  avatar_url: "https://avatars3.githubusercontent.com/u/2741?s=400&v=4",
  hourly_rate: 520,
  user_id: User.all.sample.id,
  bio: "David Heinemeier Hansson (born 15 October 1979; also known to the Ruby programming language and automobile racing communities as DHH) is a Danish programmer and the creator of the popular Ruby on Rails web development framework and the Instiki wiki. He is also a partner at the web-based software development firm Basecamp. Hansson co-wrote Agile Web Development with Rails with Dave Thomas in 2005 as part of The Facets of Ruby Series. He also co-wrote Getting Real, Rework, and Remote with Jason Fried."
)
%w(ruby ruby\ on\ rails javascript coffeescript).each do |s|
  dhh.skills << Skill.find_by_name(s)
end
dhh.save!

drujensen = Developer.new(
  first_name: "Dru",
  last_name: "Jensen",
  github_username: "drujensen",
  avatar_url: "https://avatars3.githubusercontent.com/u/18718?s=400&v=4",
  hourly_rate: 190,
  user_id: User.all.sample.id,
  bio: "20 years of experience in software development with expertise in implementing web-based applications and phone apps. Expert knowledge in many different platforms, languages, and frameworks. Extensive experience with the whole life-cycle of designing, implementing, deploying and maintaining a software application. Hands on technologist who thrives in environments focused on producing value to customers."
)
%w(ruby php crystal javascript).each do |s|
  drujensen.skills << Skill.find_by_name(s)
end
drujensen.save!

tenderlove = Developer.new(
  first_name: "Aaron",
  last_name: "Patterson",
  github_username: "tenderlove",
  avatar_url: "https://avatars2.githubusercontent.com/u/3124?s=400&v=4",
  hourly_rate: 330,
  user_id: User.all.sample.id,
  bio: "His talent is inspiring people. He likes to do that by writing fun and interesting programs and sharing them with others for the express purposes of teaching. He is passionate about helping other people in my field, and he thinks the most effective way for me to impact the most developers is by working on Open Source software. He chooses to work on Ruby and Rails because improving Rails provides a large impact on the developer community. He believes he has the skills and experience to be one of the most effective framework and language developers."
)
%w(ruby ruby\ on\ rails c c++).each do |s|
  tenderlove.skills << Skill.find_by_name(s)
end
tenderlove.save!

eileencodes = Developer.new(
  first_name: "Eileen",
  last_name: "M. Uchitelle",
  github_username: "eileencodes",
  avatar_url: "https://avatars2.githubusercontent.com/u/1080678?s=400&v=4",
  hourly_rate: 390,
  user_id: User.all.sample.id,
  bio: "Eileen M. Uchitelle Senior Systems Engineer at GitHub. Her focus is to ensure applications and code are secure and fast. She is an avid contributor to open source focusing most of her energy on improving the Ruby on Rails framework. She's is a member of the Rails Core team and the Rails Security team. Eileen is also a speaker and has presented at many conferences on performance, Active Record, and contributing to Rails."
)
%w(ruby ruby\ on\ rails c swift javascript go).each do |s|
  eileencodes.skills << Skill.find_by_name(s)
end
eileencodes.save!

seb = Developer.new(
  first_name: "Sébastien",
  last_name: "Saunier",
  github_username: "seb@saunier.me",
  avatar_url: "https://avatars0.githubusercontent.com/u/414418?s=400&v=4",
  hourly_rate: 170,
  user_id: User.all.sample.id,
  bio: "Sébastien is a developer with 10+ years of experience with shipping technological products. He co-founded Le Wagon to bring technical skills to creative people teaching them to code and build their own product."
)
%w(ruby ruby\ on\ rails css html javascript react).each do |s|
  seb.skills << Skill.find_by_name(s)
end
seb.save!

boris = Developer.new(
  first_name: "Boris",
  last_name: "Paillard",
  github_username: "papillard",
  avatar_url: "https://avatars0.githubusercontent.com/u/2471555?s=400&v=4",
  hourly_rate: 60,
  user_id: User.all.sample.id,
  bio: "Passionate about education, Boris launched Le Wagon to bring technical skills to creative people and entrepreneurs. Le Wagon is now ranked #1 coding school in the world."
)
%w(html css).each do |s|
  boris.skills << Skill.find_by_name(s)
end
boris.save!

puts "Created #{Developer.count} developers!"
puts ""
puts "Creating projects..."

Developer.find_each do |developer|
  Project.create!(
    developer: developer,
    name: "Quicky Forecast",
    stack: "Ruby | Ruby on Rails | Javascript | React",
    photo: "https://res.cloudinary.com/opratododia/image/upload/v1540565710/case-projects/quicky-forecast-02.png",
    description: "Quicky Forecast removes this illusion of activity, by offering a UI that promotes simplicity and transparency. In just a glance, the entire team is allowed to understand the sales forecast situation, see what's closed, what's forecasted and when. Rather than just generating sales forecasts weekly or monthly, Quicky Forecast is always available and ready."
  )

  Project.create!(
    developer: developer,
    name: " GasBuddy",
    stack: "Swift | Objective C",
    photo: "https://res.cloudinary.com/opratododia/image/upload/v1540565717/case-projects/gasbuddy-01.jpg",
    description: "With a rebrand in progress to support this new future, we worked with GasBuddy to improve their existing iOS and Android apps’ interface and user experience to bring them into the modern age of mobile design, and find a new system that would allow new features to be added logically."
  )

  Project.create!(
    developer: developer,
    name: " Joydrive",
    stack: "Elixir | Phoenix",
    photo: "https://res.cloudinary.com/opratododia/image/upload/v1540565712/case-projects/joydrive-01.jpg",
    description: "Joydrive reduces the stress of purchasing a car by providing customers a hassle-free online storefront where they can browse multiple dealers for new and used cars, get immediate Kelly Blue Book trade-in value, and have cars picked up and delivered right to their front door all in a single app. ."
  )

  Project.create!(
    developer: developer,
    name: "Escate the City",
    stack: "Ruby | Ruby on Rails",
    photo: "https://res.cloudinary.com/opratododia/image/upload/v1540574889/case-projects/escapethecity.png",
    description: "Escape the City had an old site based on PHP. In order to raise funding and accelerate the business growth, they urgently needed a higher quality technology platform that would help gain traction with users."
  )

  Project.create!(
    developer: developer,
    name: "Easyteach",
    stack: "Ruby | Ruby on Rails | Saas | React",
    photo: "https://res.cloudinary.com/opratododia/image/upload/v1540629385/case-projects/easytech.jpg",
    description: "Easytech's mission is to design and develop medical devices conceived for a full recovery of physical and motor abilities of every person. The working philosophy developed by Easytech aims at developing technologies designed to provide the best possible benefits to operators."
  )

  Project.create!(
    developer: developer,
    name: "Limoney",
    stack: "Ruby | Ruby on Rails | Saas | CoffeeScript",
    photo: "https://res.cloudinary.com/opratododia/image/upload/v1540629387/case-projects/limoney.jpg",
    description: "Easytech's mission is to design and develop medical devices conceived for a full recovery of physical and motor abilities of every person. The working philosophy developed by Easytech aims at developing technologies designed to provide the best possible benefits to operators."
  )

  Project.create!(
    developer: developer,
    name: "Lepori",
    stack: "Ruby | Ruby on Rails",
    photo: "https://res.cloudinary.com/opratododia/image/upload/v1540629567/case-projects/lepori.jpg",
    description: "Indios shoes was established in 1956 and, along the years, it has specialized in the production of mocassins. We have built their website and the online store with ruby on rails and spree ecommerce."
  )
end

puts "Seed completed!"



