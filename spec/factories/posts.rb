FactoryBot.define do
  factory :post do
    association :user, factory: :user
    title { "MyString" }
    content { "<img src='https://test.com/test.jpg'></img>The path of the righteous man is beset on all sides by the iniquities of the selfish and the tyranny of evil men. Blessed is he who, in the name of charity and good will, shepherds the weak through the valley of darkness, for he is truly his brother’s keeper and the finder of lost children. And I will strike down upon thee with great vengeance and furious anger those who would attempt to poison and destroy My brothers. And you will know My name is the Lord when I lay My vengeance upon thee." }
    dollars { "MyString" }
    hours { "MyString" }
    visibility { "MyString" }
    featured { false }
    meta_description { "Now that we know who you are, I know who I am. I’m not a mistake! It all makes sense! In a comic, you know how you can tell who the arch-villain’s going to be? He’s the exact opposite of the hero. And most times they’re friends, like you and me! I should’ve known way back when… You know why, David? Because of the kids. They called me Mr Glass." }
  end
end
