require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  let!(:user_general) { FactoryBot.create(:user, :general_authority) }
  let!(:user_general2) { FactoryBot.create(:user, :general_authority) }
  let!(:user_admin) { FactoryBot.create(:user, :admin_authority) }
  let!(:user_admin2) { FactoryBot.create(:user, :admin_authority) }

  # ユーザー一覧
  describe '#index' do
    context '未ログイン' do
      it 'リダイレクトを行う' do
        get :index
        expect(response).to redirect_to new_user_session_path
      end

      it '302レスポンスを返す' do
        get :index
        expect(response).to have_http_status "302"
      end
    end

    context '一般ユーザー' do
      before do
        sign_in user_general
      end
      it '正常なレスポンスを返す' do
        get :index
        expect(response).to be_successful
      end

      it '200レスポンスを返す' do
        get :index
        expect(response).to have_http_status "200"
      end
    end

    context '管理ユーザー' do
      before do
        sign_in user_admin
      end
      it '正常なレスポンスを返す' do
        get :index
        expect(response).to be_successful
      end

      it '200レスポンスを返す' do
        get :index
        expect(response).to have_http_status "200"
      end
    end
  end

  # ユーザー削除
  describe '#delete_user' do
    context '未ログイン' do
      it 'リダイレクトを行う' do
        delete :delete_user, params: { id: user_general.id }
        expect(response).to redirect_to new_user_session_path
      end

      it '302レスポンスを返す' do
        delete :delete_user, params: { id: user_general.id }
        expect(response).to have_http_status "302"
      end
    end

    context '一般ユーザーが自分を削除' do
      before do
        sign_in user_general
      end
      it 'リダイレクトを行う' do
        delete :delete_user, params: { id: user_general.id }
        expect(response).to redirect_to users_path
      end

      it '302レスポンスを返す' do
        delete :delete_user, params: { id: user_general.id }
        expect(response).to have_http_status "302"
      end
    end

    context '一般ユーザーが他の一般ユーザーを削除' do
      before do
        sign_in user_general
      end
      it 'リダイレクトを行う' do
        delete :delete_user, params: { id: user_general2.id }
        expect(response).to redirect_to users_path
      end

      it '302レスポンスを返す' do
        delete :delete_user, params: { id: user_general2.id }
        expect(response).to have_http_status "302"
      end
    end

    context '管理ユーザーが一般ユーザーを削除' do
      before do
        sign_in user_admin
      end

      it 'ユーザーの総数がマイナス1' do
        expect{
          delete :delete_user, params: { id: user_general.id }
        }.to change(User, :count).by(-1)
      end

      it 'リダイレクトを行う' do
        delete :delete_user, params: { id: user_general.id }
        expect(response).to redirect_to users_path
      end

      it '302レスポンスを返す' do
        delete :delete_user, params: { id: user_general.id }
        expect(response).to have_http_status "302"
      end
    end

    context '管理ユーザーが自分を削除' do
      before do
        sign_in user_admin
      end

      it 'ユーザーの総数がマイナス1' do
        expect{
          delete :delete_user, params: { id: user_admin.id }
        }.to change(User, :count).by(-1)
      end

      it 'リダイレクトを行う' do
        delete :delete_user, params: { id: user_admin.id }
        expect(response).to redirect_to users_path
      end

      it '302レスポンスを返す' do
        delete :delete_user, params: { id: user_admin.id }
        expect(response).to have_http_status "302"
      end
    end

    context '管理ユーザーが他の管理ユーザーを削除' do
      before do
        sign_in user_admin
      end

      it 'ユーザーの総数がマイナス1' do
        expect{
          delete :delete_user, params: { id: user_admin2.id }
        }.to change(User, :count).by(-1)
      end

      it 'リダイレクトを行う' do
        delete :delete_user, params: { id: user_admin2.id }
        expect(response).to redirect_to users_path
      end

      it '302レスポンスを返す' do
        delete :delete_user, params: { id: user_admin2.id }
        expect(response).to have_http_status "302"
      end
    end
  end

  # ユーザー詳細
  describe '#show_user' do
    context '未ログイン' do
      it 'リダイレクトを行う' do
        get :show_user, params: { id: user_general.id }
        expect(response).to redirect_to new_user_session_path
      end

      it '302レスポンスを返す' do
        get :show_user, params: { id: user_general.id }
        expect(response).to have_http_status "302"
      end
    end

    context '一般ユーザーが自分の詳細ページにアクセス' do
      before do
        sign_in user_general
      end
      it '正常なレスポンスを返す' do
        get :show_user, params: { id: user_general.id }
        expect(response).to be_successful
      end

      it '302レスポンスを返す' do
        get :show_user, params: { id: user_general.id }
        expect(response).to have_http_status "200"
      end
    end

    context '一般ユーザーが他の一般ユーザーの詳細ページにアクセス' do
      before do
        sign_in user_general
      end
      it '正常なレスポンスを返す' do
        get :show_user, params: { id: user_general2.id }
        expect(response).to be_successful
      end

      it '302レスポンスを返す' do
        get :show_user, params: { id: user_general2.id }
        expect(response).to have_http_status "200"
      end
    end

    context '一般ユーザーが他の管理ユーザーの詳細ページにアクセス' do
      before do
        sign_in user_general
      end
      it '正常なレスポンスを返す' do
        get :show_user, params: { id: user_admin.id }
        expect(response).to be_successful
      end

      it '302レスポンスを返す' do
        get :show_user, params: { id: user_admin.id }
        expect(response).to have_http_status "200"
      end
    end

    context '管理ユーザーが他の一般ユーザーの詳細ページにアクセス' do
      before do
        sign_in user_admin
      end

      it '正常なレスポンスを返す' do
        get :show_user, params: { id: user_general.id }
        expect(response).to be_successful
      end

      it '302レスポンスを返す' do
        get :show_user, params: { id: user_general.id }
        expect(response).to have_http_status "200"
      end
    end

    context '管理ユーザーが他の管理ユーザーの詳細ページにアクセス' do
      before do
        sign_in user_admin
      end

      it '正常なレスポンスを返す' do
        get :show_user, params: { id: user_admin2.id }
        expect(response).to be_successful
      end

      it '302レスポンスを返す' do
        get :show_user, params: { id: user_admin2.id }
        expect(response).to have_http_status "200"
      end
    end
  end

  # フォロー一覧
  describe '#following' do
    context '未ログイン' do
      it 'リダイレクトを行う' do
        get :following, params: { id: user_general.id }
        expect(response).to redirect_to new_user_session_path
      end

      it '302レスポンスを返す' do
        get :following, params: { id: user_general.id }
        expect(response).to have_http_status "302"
      end
    end

    context '一般ユーザー' do
      before do
        sign_in user_general
      end
      it '正常なレスポンスを返す' do
        get :following, params: { id: user_general.id }
        expect(response).to be_successful
      end

      it '200レスポンスを返す' do
        get :following, params: { id: user_general.id }
        expect(response).to have_http_status "200"
      end
    end

    context '管理ユーザー' do
      before do
        sign_in user_admin
      end
      it '正常なレスポンスを返す' do
        get :following, params: { id: user_general.id }
        expect(response).to be_successful
      end

      it '200レスポンスを返す' do
        get :following, params: { id: user_general.id }
        expect(response).to have_http_status "200"
      end
    end
  end

  # フォロワー一覧
  describe '#followers' do
    context '未ログイン' do
      it 'リダイレクトを行う' do
        get :followers, params: { id: user_general.id }
        expect(response).to redirect_to new_user_session_path
      end

      it '302レスポンスを返す' do
        get :followers, params: { id: user_general.id }
        expect(response).to have_http_status "302"
      end
    end

    context '一般ユーザー' do
      before do
        sign_in user_general
      end
      it '正常なレスポンスを返す' do
        get :followers, params: { id: user_general.id }
        expect(response).to be_successful
      end

      it '200レスポンスを返す' do
        get :followers, params: { id: user_general.id }
        expect(response).to have_http_status "200"
      end
    end

    context '管理ユーザー' do
      before do
        sign_in user_admin
      end
      it '正常なレスポンスを返す' do
        get :followers, params: { id: user_general.id }
        expect(response).to be_successful
      end

      it '200レスポンスを返す' do
        get :followers, params: { id: user_general.id }
        expect(response).to have_http_status "200"
      end
    end
  end
end
