require 'rails_helper'

RSpec.describe User, type: :model do
  describe '正常な値' do
    it 'name, email, passwordがある場合有効な状態である' do
      user = User.new(
        name:     'default_user',
        email:    'samplesamplee@sample.sample.aaaaa',
        password: 'password'
      )
      expect(user).to be_valid
    end
  end

  describe 'nameの異常を検知する' do
    it 'nameが空白の場合無効な状態である' do
      user = User.new(name: "")
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")
    end

    it 'nameが空文字の場合無効な状態である' do
      user = User.new(name: "  ")
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")
    end

    it 'nameがnilの場合無効な状態である' do
      user = User.new(name: nil)
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")
    end

    it 'name < 4文字 の場合無効な状態である' do
      user = User.new(name: 'a'*3)
      user.valid?
      expect(user.errors[:name]).to include("is too short (minimum is 4 characters)")
    end

    it 'name > 20文字 の場合無効な状態である' do
      user = User.new(name: 'a'*21)
      user.valid?
      expect(user.errors[:name]).to include("is too long (maximum is 20 characters)")
    end
  end

  describe 'passwordの異常を検知する' do
    it 'passwordがnilの場合無効な状態である' do
      user = User.new(password: nil)
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    it 'passwordが空白の場合無効な状態である' do
      user = User.new(password: nil)
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    it 'passwordが空文字の場合無効な状態である' do
      user = User.new(password: nil)
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    it 'password < 6文字 の場合無効な状態である' do
      user = User.new(password: 'a'*5)
      user.valid?
      expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
    end

    it 'password > 128文字 の場合無効な状態である' do
      user = User.new(password: 'a'*129)
      user.valid?
      expect(user.errors[:password]).to include("is too long (maximum is 128 characters)")
    end
  end

  describe 'emailの異常を検知する' do
    it 'emailが空白の場合無効な状態である' do
      user = User.new(email: "")
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it 'emailが空文字の場合無効な状態である' do
      user = User.new(email: "  ")
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it 'emailがnilの場合無効な状態である' do
      user = User.new(email: nil)
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it 'emailの行頭が@の場合無効な状態である' do
      user = User.new(email: '@samplesamplee@sample.sample.aaaaa')
      user.valid?
      expect(user.errors[:email]).to include("is invalid")
    end

    it 'emailの行末が@の場合無効な状態である' do
      user = User.new(email: 'samplesamplee@sample.sample.aaaaa@')
      user.valid?
      expect(user.errors[:email]).to include("is invalid")
    end

    it 'email内に@を含まない場合無効な状態である' do
      user = User.new(email: 'samplesampleesample.sample.aaaaa')
      user.valid?
      expect(user.errors[:email]).to include("is invalid")
    end

    it 'email > 254文字 の場合無効な状態である' do
      user = User.new(email: "'a@'#{'a'*253}")
      user.valid?
      expect(user.errors[:email]).to include("is too long (maximum is 254 characters)")
    end

    it '同じemailが保存されている場合無効な状態である' do
      User.create(
        name:     "Tester1",
        email:    "tester@example.com",
        password: "dottle-nouveau-pavilion-tights-furze",
      )
      user = User.new(
        name:     "Tester2",
        email:    "tester@example.com",
        password: "dottle-nouveau-pavilion-tights-furze",
      )
      user.valid?
      expect(user.errors[:email]).to include("has already been taken")
    end
  end

  describe 'web_pageの異常を検知する' do
    it 'web_page > 400文字 の場合無効な状態である' do
      user = User.new(web_page: 'a'*401)
      user.valid?
      expect(user.errors[:web_page]).to include("is too long (maximum is 400 characters)")
    end
  end

  describe 'commentの異常を検知する' do
    it 'comment > 400文字 の場合無効な状態である' do
      user = User.new(comment: 'a'*401)
      user.valid?
      expect(user.errors[:comment]).to include("is too long (maximum is 400 characters)")
    end
  end

  describe 'icon_passの異常を検知する' do
    it 'icon_pass > 400文字 の場合無効な状態である' do
      user = User.new(icon_pass: 'a'*401)
      user.valid?
      expect(user.errors[:icon_pass]).to include("is too long (maximum is 400 characters)")
    end
  end

  describe 'adminの異常を検知する' do
    before do
      @user = User.new(
        name:     'default_user',
        email:    'samplesamplee@sample.sample.aaaaa',
        password: 'password'
      )
    end

    it 'adminがnilの場合無効な状態である' do
      @user.admin = nil
      @user.valid?
      expect(@user.errors[:admin]).to include("is not included in the list")
    end

    it 'adminがtrueの場合有効な状態である' do
      @user.admin = true
      expect(@user).to be_valid
    end

    it 'adminがfalseの場合有効な状態である' do
      @user.admin = false
      expect(@user).to be_valid
    end

    it 'adminが未定義の場合、デフォルトでfalseのため有効な状態である' do
      expect(@user).to be_valid
    end
  end

  describe 'follow, unfollowメソッド' do
    before do
      @user1 = User.create(
        name:     "Tester1",
        email:    "tester1@example.comm",
        password: "dottle-nouveau-pavilion-tights-furze"
      )
      @user2 = User.create(
        name:     "Tester2",
        email:    "tester2@example.comm",
        password: "dottle-nouveau-pavilion-tights-furze"
      )
    end

    context 'followしていないときにfollowした場合' do
      it 'RelationshipDBの総数+1' do
        expect { @user1.follow(@user2) }.to change { Relationship.all.size }.by(1)
      end
    end

    context 'followしているときにunfollowした場合' do
      it 'RelationshipDBの総数-1' do
        @user1.follow(@user2)
        expect { @user1.unfollow(@user2) }.to change { Relationship.all.size }.by(-1)
      end
    end
  end

  describe 'following?メソッド' do
    before do
      @user1 = User.create(
        name:     "Tester1",
        email:    "tester1@example.comm",
        password: "dottle-nouveau-pavilion-tights-furze"
      )
      @user2 = User.create(
        name:     "Tester2",
        email:    "tester2@example.comm",
        password: "dottle-nouveau-pavilion-tights-furze"
      )
    end

    context 'user1がuser2をfollowしている場合' do
      it 'user1はtrue' do
        @user1.follow(@user2)
        expect(@user1.following?(@user2)).to eq true
      end

      it 'user2はfalse' do
        @user1.follow(@user2)
        expect(@user2.following?(@user1)).to eq false
      end
    end

    context 'user1がuser2をfollowしていない場合' do
      it 'user1はfalse' do
        expect(@user1.following?(@user2)).to eq false
      end

      it 'user2はfalse' do
        expect(@user2.following?(@user1)).to eq false
      end
    end
  end
end
