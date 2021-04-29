require "rakuten_web_service"
RakutenWebService.configure do |config|
    config.application_id = '1065089521056890320'
    config.affiliate_id = '1f2c48a8.ba81cee2.1f2c48a9.960929f9'
    config.max_retries = 3 #リクエストのリトライ回数
    config.debug = true #デバッグモード
end
# @title = "砂漠"
# results = RakutenWebService::Books::Book.search({
#   title: @title,
# })
genre = RakutenWebService::Books::Genre.search({ booksGenreId: '001004' })
p genre.first["children"].map{|v| {
    id: v["booksGenreId"],
    name: v["booksGenreName"]
  }}
# binding.irb
# genre_results.each do |result|
#   puts 'hello'
#   puts result["booksGenreName"]
# end