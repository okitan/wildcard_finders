require "sinatra"
require "slim"

set :slim, layout: :layout

get "/a" do
  slim <<_SLIM_
a id="href_hoge" href="hoge"
a id="href_fuga" href="fuga"
a id="onclick_hoge" onclick="hoge"
_SLIM_
end

get "/@class" do
  slim <<_SLIM_
a id="hoge_fuga" class="hoge fuga"
a id="fuga_ugu"  class="fuga ugu"
_SLIM_
end

get "/text" do
  slim <<_SLIM_
a id="text_hoge_href_hoge" href="hoge"
  | hoge
a id="text_fuga_href_hoge" href="hoge"
  | fuga
_SLIM_
end

__END__

@@ layout
html
  body
    == yield
