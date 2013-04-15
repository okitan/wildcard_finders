require "spec_helper"

describe WildcardFinders::Finders do
  include WildcardFinders::Finders

  context ".find_anchor_like" do
    where(:attr, :value, :expected_id) do
      [ [ :href,    /hoge/, "href_hoge" ],
        [ :href,    /fuga/, "href_fuga" ],
        [ :onclick, /hoge/, "onclick_hoge" ],
        [ :href,    "hoge", "href_hoge" ],
        [ :href,    "fuga", "href_fuga" ],
        [ :onclick, "hoge", "onclick_hoge" ],
      ]
    end

    with_them do
      it "with hash as matcher ({ attr => value }) finds" do
        visit "/a"
        page.find_anchor_like(attr => value)[:id].should == expected_id
      end

      it "with block as matcher ({|e| value === e[attr] }) finds" do
        visit "/a"
        page.find_anchor_like {|e| value === e[attr] }[:id].should == expected_id
      end

      it "with proc as matcher (->(e) { value === e[attr] }) finds" do
        visit "/a"
        page.find_anchor_like(->(e) { value === e[attr] })[:id].should == expected_id
      end
    end

    context "specifying class" do
      where(:klass, :expected_id) do
        [ [ "hoge", "hoge_fuga" ],
          [ "ugu",  "fuga_ugu"  ],
        ]
      end

      with_them do
        it "with specifying value finds out whether class has multi values" do
          visit "/@class"
          page.find_anchor_like(class: klass)[:id].should == expected_id
        end
      end
    end

    context "specifying text" do
      where(:text, :href, :expected_id) do
        [ [ "hoge", "hoge", "text_hoge_href_hoge" ],
          [ "fuga", "hoge", "text_fuga_href_hoge" ],
        ]
      end

      with_them do
        it "with specifying value also use text()" do
          visit "/text"
          page.find_anchor_like(text: text, href: href)[:id].should == expected_id
        end
      end
    end

  end
end
