describe "#new" do
    context "as an authorized user" do
      # 正常なレスポンスか？
      it "responds successfully" do
        sign_in @user
        get :new
        expect(response).to be_success
      end
      # 200レスポンスが返ってきているか？
      it "returns a 200 response" do
        sign_in @user
        get :new
        expect(response).to have_http_status "200"
      end
    end
    context "as a guest user" do
      # 正常なレスポンスが返ってきていないか？
      it "does not respond successfully" do
        get :new
        expect(response).to_not be_success
      end
      # 302レスポンスが返ってきているか？
      it "returns a 302 response" do
        get :new
        expect(response).to have_http_status "302"
      end
      # ログイン画面にリダイレクトされているか？
      it "redirects the page to /login" do
        get :new
        expect(response).to redirect_to "/login"
      end
    end
  end


describe 'Post #create' do
  context "@userが保存できた時" do

    it "データベースに値が保存される" do
    end

    it "正しいビューに変遷する" do
    end

  end

  context "@userが保存できなかった時" do

    it "データベースに値が保存されない" do
    end

    it "正しいビューに変遷する" do
    end

  end

 end