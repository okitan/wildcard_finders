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

__END__

@@ layout
html
  body
    == yield
