# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
puts "Destroy models"
InvolvedCompany.destroy_all
Platform.destroy_all
Genre.destroy_all
Critic.destroy_all
Company.destroy_all
User.destroy_all
Game.destroy_all
puts "Start seeding"
game = Game.create(name: "The Last Of Us", summary: "Shadow of the Tomb Raider is a 2018 action-adventure video game developed by Eidos-Montréal
                                                     and published by Square Enix. It continues the narrative from the 2015 game Rise of the Tomb 
                                                     Raider and is the twelfth mainline entry in the Tomb Raider series. The game was originally 
                                                     released worldwide for Microsoft Windows, PlayStation 4 and Xbox One. Versions for macOS and
                                                     Linux, and Stadia, were released in November 2019. After release, the game was expanded upon
                                                     with downloadable content in both a season pass and as standalone releases.",
                  release_date: "2020-02-02", category: 0, rating: 94.0)
game2 = Game.create(name: "Super Mario World", summary: "The original shooter-looter returns, packing bazillions of guns and a mayhem-fueled adventure! Bl...",
    release_date: "2013-02-02", category: 0, rating: 94.0)
game.cover.attach(io: File.open("db/images/games/The_Last_Of_Us.png"), filename: "TLOU")
game2.cover.attach(io: File.open("db/images/games/Super_Mario_World.png"), filename: "SPW")
user = User.create(email:"test@mail.com",password:"123456",username:"tester", role:"admin")
user2 = User.create(email:"test2@mail.com",password:"123456",username:"tester2", role:"admin")
critic = Critic.create(title:"New Critic", body:"body", user_id: user.id, criticable:game)
company = Company.create(name:"Nintendo", description: "Nintendo Co., Ltd. is a multinational corporation located in Kyoto, Japan.
                               Founded on September 23, 1889 by Fusajiro Yamauchi, it produced handmade hanafuda cards. By 1963, 
                               the company had tried several small niche businesses, such as a cab company and a love hotel. 
                               Nintendo developed into a video game company, becoming one of the most influential in the industry
                               and Japan's third most valuable listed company, with a market value of over US$85 billion.
                               Besides video games, Nintendo is also the majority owner of the Seattle Mariners, a Major League Baseball
                               team in Seattle, Washington. According to Nintendo's Touch! Generations website,
                               the name 'Nintendo' translated from Japanese to English means 'Leave luck to Heaven'.",
                        start_date: "2020-02-02", country: "Japan")
company.cover.attach(io: File.open("db/images/companies/Nintendo.png"), filename: "Nintendo")
company2 = Company.create(name:"Sony", description: "Sony, Ltd. is a multinational corporation located in Kyoto, Japan.
                                                    Founded on September 23, 1889 by Fusajiro Yamauchi, it produced handmade hanafuda cards. By 1963, 
                                                    the company had tried several small niche businesses, such as a cab company and a love hotel. 
                                                    Sony developed into a video game company, becoming one of the most influential in the industry
                                                    and Japan's third most valuable listed company, with a market value of over US$70 billion.
                                                    Besides video games, Sony is also the majority owner of the Seattle Mariners, a Major League Baseball
                                                    team in Seattle, Washington. According to Sony's Touch! Generations website,
                                                    the name 'Sony' translated from Japanese to English means 'Leave luck to Heaven'.",
                        start_date: "2020-02-02", country: "Japan")
company2.cover.attach(io: File.open("db/images/companies/Sony.png"), filename: "Sony")
game.involved_companies << InvolvedCompany.create(company:company, game:game2, developer:true, publisher:true)
game.involved_companies << InvolvedCompany.create(company:company2, game:game2, developer:false, publisher:true)
genre = Genre.create(name:"Horror")
platform = Platform.create(name:"Consola",category:1)
game2.genres << genre
game2.platforms << platform
puts "End seeding"
                        